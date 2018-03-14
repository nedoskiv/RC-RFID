srv = net.createServer(net.TCP,20)
cr={}
tmr.alarm(5, 15000, tmr.ALARM_SEMI, function()
	cr=nil
	cr={}
	print ("[ WEB5_TIMER_DEBUG ] Coroutines cleared.")
end )
tmr.stop(5)
srv:listen(80,function(conn)
 local cn
 conn:on("receive", function(conn,payload)
	local req = dofile("web_request.lc")(payload)
	cn=req.uri.file
	cr[cn] = nil
	collectgarbage()
	if req
		then
			tmr.stop(5)
			tmr.start(5)
--			print ("[ WEB5_RECV_DEBUG ] Timer reset.")
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
	print("[ WEB5 ] "..node.heap())
end)

 conn:on("sent", function(conn)
 if cr[cn]
	then
--		tmr.stop(5)
--		tmr.start(5)
--		print ("[ WEB5_SENT_DEBUG ] Timer reset.")
		local crStatus = coroutine.status(cr[cn])
		if crStatus == "suspended"
			then
				local status, err = coroutine.resume(cr[cn])
				if not status
					then
						conn:close()
						cr[cn] = nil
						collectgarbage()
						print ("[ WEB5_SENT_DEBUG ] Conn:close (status)")
				end
			elseif crStatus == "dead" 
				then
					conn:close()
					cr[cn] = nil
					collectgarbage()
					print ("[ WEB5_SENT_DEBUG ] Conn:close (dead)")
		end
 end
end)
end)
print ("[ WEB5 ] Web server started")