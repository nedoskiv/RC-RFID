spi.setup(1, spi.MASTER, spi.CPOL_LOW, spi.CPHA_LOW, spi.DATABITS_8, 0)
if s.ss2 < 13	then print(dofile("RC522.lc")("init",s.ss2))end
print(dofile("RC522.lc")("init",s.ss1))

local function appendHex(t)
  local str = ""
  for i,v in ipairs(t) do
    str = str..string.format("%X",t[i])
  end
  return str
end

tmr.alarm(0, 500, tmr.ALARM_AUTO, function()
 if rdr==2 and s.ss2 < 13	then
  pin_ss=s.ss2
 else
  pin_ss=s.ss1
 end
 rdr = (rdr==1) and 2 or 1
 local isTagNear, cardType = dofile("RC522.lc")("request",pin_ss)
  if isTagNear == true then
   tmr.stop(0)
   local _, serialNo = dofile("RC522.lc")("anticoll",pin_ss)
   serialNo=appendHex(serialNo)
   print (dofile("tag4.lc")(serialNo))
   tmr.start(0)
  end
end)
