for i = 2250,2000,-1 
do 
   print(i)
   u={u=node.random(50), mu=1000,p="none", wu=node.random(50),e=2,n="Auto"..i}
   fwoj("T_AAVVDD"..tostring(i),u)
end