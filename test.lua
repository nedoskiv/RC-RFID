

function ccry (msg,key)
local result=""
for c in msg:gmatch"." do
	result=result..string.char(string.byte(c)+key)
	key=key*-1
end
return (result)
end