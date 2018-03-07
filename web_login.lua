local function auth(arg)
	return arg.login..arg.pass==s.auth_login..s.auth_pass and tostring((string.byte(arg.pass))*s.token) or "false"
end

return function (tab)
	return (auth(tab))
end
