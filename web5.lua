srv = net.createServer(net.TCP,10)
cr={}
tmr.alarm(5, 10000, tmr.ALARM_SEMI, function()		-- it is good timer interval to match TCP timeout time 
	cr=nil
	cr={}
end )
tmr.stop(5)
srv:listen(80,function(conn)
 local cn
 conn:on("receive", function(conn,payload)
	tmr.stop(5)
	tmr.start(5)
	local req = dofile("web_request.lc")(payload)
	cn=req.uri.file
	cr[cn] = nil
	collectgarbage()
	if req
		then
			cr[cn] = coroutine.create(dofile("web_file.lc"))
	end

	if (req and req.method == "GET")
		then
			if coroutine.status(cr[cn]) ~= "dead"
				then
					local b,res = coroutine.resume(cr[cn], conn, req.uri.file, req.uri.args,req.cookie)
				end
		elseif req and req.method == "POST"
			then
				dofile("web_file.lc")(conn, req.uri.file,req.getRequestData(payload),req.cookie)
	end
	print(node.heap())
end)

 conn:on("sent", function(conn)
 if cr[cn]
	then
		local crStatus = coroutine.status(cr[cn])
		if crStatus == "suspended"
			then
				local status, err = coroutine.resume(cr[cn])
				if not status
					then
						conn:close()

						cr[cn] = nil
						collectgarbage()
				end
			elseif crStatus == "dead" 
				then
					conn:close()
					cr[cn] = nil
					collectgarbage()
		end
 end
end)
end)
print ("[ WEB5 ] Web server started")