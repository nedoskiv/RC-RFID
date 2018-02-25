return function (m,i,p,ph,c)
local cfg={}
cfg.ssid=i
cfg.pwd = string.len(p)>=8 and p or nil
if m=="AP"then
print("Access point")
wifi.setmode(wifi.SOFTAP)
wifi.setphymode(ph)
cfg.max=1			-- limit max available connection to 1 to decrease memory usage
wifi.ap.config(cfg)
wifi.eventmon.register(wifi.eventmon.AP_STACONNECTED,function(T)
c("Connect client: "..wifi.ap.getip())
end)
elseif m=="ST"then
print("Wireless client")
wifi.setmode(wifi.STATION)
--wifi.setphymode(ph)
wifi.nullmodesleep(false)
wifi.sta.config(cfg)
wifi.eventmon.register(wifi.eventmon.STA_CONNECTED,function(T)
tmr.create(0):alarm(3000,tmr.ALARM_SINGLE,function()
c("Connect access point\nIP:"..wifi.sta.getip())
end)
end)
end
end
