local function auth(arg)
	return arg.login..arg.pass==s.auth_login..s.auth_pass and tostring((string.byte(arg.pass))*s.token) or "false"
end
local function save(tab)
	for k,v in pairs(tab)
		do
			s[k] = (tonumber(v) and k ~= "auth_pass") and tonumber(v) or v
		end
	return fwoj("setting.json",s)
end
local function listap(t)
	local d = {}
	local i = {}
	for k,v in pairs(t)
		do
			d.am, d.ri, d.bd, d.cl = v:match("([^,]+),([^,]+),([^,]+),([^,]+)")
			d.sd=k
			i[#i+1]=d
			d={}
		end
		fwoj("get_network.json",i)
end
return function (tab)
	local r="false"
	if tab.init=="save"
		then
			tab.init=nil
			r=save(tab)
		elseif tab.init=="scan"
			then
				wifi.sta.getap(listap)
				r="true"
		elseif tab.init=="reboot"
			then
				tmr.create():alarm(2000, tmr.ALARM_SINGLE, function()print("[ INFO ] Rebooting")node.restart()end)
				r="true"
		elseif tab.init=="get"
			then
				if (file.open("get_network.json","r"))
					then r = file.read('\n') file.close()
				end
		elseif tab.init=="auth" 
			then r=auth(tab)
	end
	return r
end
