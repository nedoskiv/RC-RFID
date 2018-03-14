local l = file.list();
local tc=0	
local u={}
local buff=""
print ("[ DELETETAGS ] Started.")
for k,v in pairs(l) do
  -- print("name:"..k)
 
  if #(k) > 6 and string.sub(k,1,2) == "T_"
    then
        tc=tc+1
		file.remove(k)
  --      file.remove(k)
  end

end
file.remove ("listtitle")
file.remove ("listtitlec")
file.remove ("exporttitle")
file.remove ("exporttitlec")
print ("[ GEN_LIST ] Finished. Total tags deleted: "..tc)
s.msg=1
fwoj("setting.json",s)

