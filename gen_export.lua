
local function pass_asc_encode (msg)
	local result=""
	for c in msg:gmatch"." do
		result=result..tostring(tonumber(string.byte(c))+1).."x"
	end
	return (result)
end

local l = file.list();
local tc=0	
local uc=0
local u={}
local buff=""
print ("[ GEN_EXPORT ] Started.")
local fn ="exportlist.txt"
s.msg=1
file.remove ("exporttitlec")

for k,v in pairs(l) do
  -- print("name:"..k)
 
  if #(k) > 6 and string.sub(k,1,2) == "T_"
    then
        tc=tc+1
		u={}
		u=frj(k)
		if u.u == nil  or u.mu == nil or u.e== nil or u.n == nil	-- failsafe if read zero file
			then
				print ("[ GEN_EXPORT ] Invalid data:" ..lt)
				u={u=0, mu=100,p="nono",wu=0, e=0,n="НЕВАЛИДНИ ДАННИ"}
		end
		buff=buff..'{"p":"'..pass_asc_encode(u.p)..'","wu":'..u.wu..',"e":'..u.e..',"rfid":"'..string.sub(k,3)..'","u":'..u.u..',"mu":'..u.mu..',"n":"'..u.n..'"}\n'
		if #(buff) > 1024
			then
				buzz(1)
				if file.open(fn, "a") 
					then
						file.write(buff)
						file.close()
					else
						s.msg=2
				end
				print ("[ GEN_EXPORT ] Write")
				buff=""
				buzz(0)
		end
		uc=uc+u.u
  --      file.remove(k)
  end

end
if file.open(fn, "a") 
	then
		file.write(buff)
		file.close()
	else
		s.msg=2
end
u={}
u.tt=tc
fwoj("setting.json",s)
fwoj("exporttitlec",u)
print ("[ GEN_EXPORT ] Finished")
