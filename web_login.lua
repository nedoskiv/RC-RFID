local function auth(arg)
--	print (arg.login,arg.pass)
	return arg.login..arg.pass==s.auth_login..s.auth_pass and tostring((string.byte(arg.pass))*s.token) or "false"
end

return function (tab)
	if #(tab.login) < 8
		then
			return (auth(tab))
		else
			return (dofile("web_tag4.lc")(tab))
	end
end
