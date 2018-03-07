
local function savetag(tab)
	local u = {}
	local fn
	for k,v in pairs(tab)
		do
			u[k] = v
		end
	fn=u.tag
	u.tag=nil
	u.init=nil
	return fwoj("T_"..fn,u)
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
		elseif tab.init=="savetag"
			then
				r=savetag(tab)
				if r=="true"
					then
						print ("[ WEB_TAG.LUA ] Saved T_" ..tab.tag)
					else
						print ("[ WEB_TAG.LUA ] Error writing to T_" ..tab.tag)
				end
--		else
--			print ("HEEEEEEEEEEEre   "..tab.init)
	end
	return r
end
