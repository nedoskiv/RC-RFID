l = file.list();
c=0
for k,v in pairs(l) do
  -- print("name:"..k)
 
  if #(k) > 6 and string.sub(k,1,2) == "T_"
    then
        c=c+1
        print (c.." " .. k)
  --      file.remove(k)
  end
end