local function clearcounter(tab)
	local u = frj ("T_"..tab.tag)
	u.u=0
--	for k,v in pairs(tab)
--		do
--			u[k] = v
--		end
--	u.tag=nil
--	u.init=nil
	return fwoj("T_"..tab.tag,u)
end
local function savetag(tab)
	local sp,n=string.find(tab.u,"/")
	local u = {
	mu=tab.mu,
	e=tab.e,
	n=tab.n,
	p=tab.p
	}
	u.u=string.sub(tab.u,1,sp-1)
	u.wu=string.sub(tab.u,sp+1)
--	for k,v in pairs(tab)
--		do
--			u[k] = v
--		end
--	u.tag=nil
--	u.init=nil
	return fwoj("T_"..tab.tag,u)
end
local function delete(tab)
	print ("[ WEB_TAG.LUA ] Deleted T_" ..tab.tag)
	file.remove ("T_" ..tab.tag)
	return "true"
end
return function (tab)
--	for k,v in pairs(tab)
--		do
--			print ("tuka e ".. k .. " - "..v)
--		end
	local r="false"
	if tab.init=="delete"
		then
			r=delete(tab)
		elseif tab.init=="clearcounter"
			then
				r=clearcounter(tab)
				if r=="true"
					then
						print ("[ WEB_TAG.LUA ] Clear counter for :" ..tab.tag)
					else
						print ("[ WEB_TAG.LUA ] Error clear counter for: " ..tab.tag)
				end
		elseif tab.init=="savetag"
			then
				r=savetag(tab)
				if r=="true"
					then
						print ("[ WEB_TAG.LUA ] Saved T_" ..tab.tag)
					else
						print ("[ WEB_TAG.LUA ] Error writing to T_" ..tab.tag)
				end
		elseif tab.init=="modechange"
			then
				local fn
				if tonumber(tab.md)==4
					then
						fn="exporttitle"
					else
						fn="listtitle"
				end
				s.md=tab.md
				s.msg=2					-- set msg to failure
				r=fwoj("setting.json",s)
				tab.init=nil
				fwoj(fn,tab)
--				if file.open(fn, "w+")
--					then
--						file.write(tab.lt)
--						file.close()
--				end
				tmr.create():alarm(2000, tmr.ALARM_SINGLE, function()print("[ INFO ] Mode changed to "..s.md..". Rebooting")node.restart()end)
		elseif tab.init=="manual"
			then
				if #(tab.tag) ~= 10
					then
						r="false"
					else
						lt=tab.tag
						r="true"
				end
--		else
--			print ("HEEEEEEEEEEEre   "..tab.init)
	end
	return r
end
