
local function tofloatrup(num, zeros)
	local str=tostring(num)
	local slen=string.len(str) 
	if slen < zeros
		then
			for i=slen,zeros
				do
				str="0"..str
			end
	end

--	print (num,str)
	slen=string.len(str) 
--	print (slen,zeros)
	local parta=string.sub(str,1,(slen-zeros))
	if string.len(parta)==0 then parta="0" end
--	print ("a "..parta)
	local partb=string.sub(str,(slen-zeros+1),slen)
--	print ("b "..partb)
	local result=parta.."."..string.sub(partb,1,2)
--	print (result)
	local partc=string.sub(partb,3)
--	print ("c "..partc)
	if zeros>2 and tonumber(partc) >0
		then
--			print ("rounding")
			str=tostring(tonumber("9"..parta..string.sub(partb,1,2))+1)
			slen=string.len(str)
			parta=string.sub(str,2,(slen-2))
--			print ("a "..parta)
			partb=string.sub(str,(slen-1),slen)
--			print ("b "..partb)
--			print (parta.."."..partb)
			return parta.."."..partb, tonumber(parta..partb)
		else
			return result, tonumber(parta..string.sub(partb,1,2))
	end
end

local l = file.list();
local tc=0	
local uc=0
local wuc=0
local u={}
local buff=""
local tmp
local tmp1
local single
local suadd
local fn ="fulllist.html"
print ("[ GEN_LIST ] Started.")
for k,v in pairs(l) do
  -- print("name:"..k)
 
  if #(k) > 6 and string.sub(k,1,2) == "T_"
    then

        tc=tc+1
		u={}
		buzz(0)
		u=frj(k)
		buzz(1)
		if u.u == nil  or u.mu == nil or u.e== nil or u.n == nil	-- failsafe if read zero file
			then
				print ("[ GEN_LIST ] Invalid data:" ..k)
				u={u=0, mu=100, wu=0,p="none",e=0,n="НЕВАЛИДНИ ДАННИ"}
		end

		uc=uc+u.u
		wuc=wuc+u.wu
  --      file.remove(k)
  end
end
buzz(0)
local stat={}
stat=frj("listtitle")
stat.ts=tonumber(stat.ts)
stat.tu=uc+wuc
stat.addsum=0
if stat.tu==0
	then
		single=0
	else
		single=(stat.ts*100000)/stat.tu
end

s.msg=1
file.remove ("listtitlec")

dofile ("list_p.lc")(fn,stat.lt,stat.ts)
tc=0
uc=0
wuc=0
for k,v in pairs(l) do
  -- print("name:"..k)
 
  if #(k) > 6 and string.sub(k,1,2) == "T_"
    then
        tc=tc+1
		u={}
		u=frj(k)
		if u.u == nil  or u.mu == nil or u.e== nil or u.n == nil	-- failsafe if read zero file
			then
				print ("[ GEN_LIST ] Invalid data:" ..k)
				u={u=0, mu=100, wu=0,p="none",e=0,n="НЕВАЛИДНИ ДАННИ"}
		end
		buff=buff..'<tr><td><a href="rfid.html?tag='..string.sub(k,3)..'" class="brand">'..u.n..'</a></td><td>'..string.sub(k,3)..'</td><td>'
		u.e=tonumber(u.e)
		if u.e==1
			then
				buff=buff.."RFID"
			elseif u.e==2
				then
					buff=buff.."НЕ"
			elseif u.e==3
				then
					buff=buff.."WEB"
			elseif u.e==4
				then
					buff=buff.."RFID+WEB"
		end
		buff=buff..'</td><td>'..u.u..'/'..u.wu..'</td><td>'..u.mu..'</td>'
		tmp1 = single*(u.u+u.wu)
		tmp,tmp1=tofloatrup(tmp1,5)
		stat.addsum=stat.addsum+tmp1
		buff=buff.."<td>"..tmp.."</td></tr>\n"
		if #(buff) > 1024
			then
				buzz(1)
				if file.open(fn, "a") 
					then
						print ("[ GEN_LIST ] Write")
						file.write(buff)
						file.close()
					else
						print ("[ GEN_LIST ] Error")
						s.msg=2
				end
				buff=""
				buzz(0)
		end
		uc=uc+u.u
		wuc=wuc+u.wu
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
buff=nil
l=nil
collectgarbage()
tmp,tmp1=tofloatrup(stat.addsum,2)
dofile ("list_s.lc")(fn,tc,uc,wuc,tmp)
u={}
u.tt=tc
u.tu=uc
u.twu=wuc
fwoj("setting.json",s)
fwoj("listtitlec",u)
print ("[ GEN_LIST ] Finished")
