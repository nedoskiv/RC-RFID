--gpio.mode(1, gpio.INPUT)
--s=dofile("init_settings.lua")(gpio.read(1))
dofile("functions.lc")
dofile("RC522.lc")
dofile("reader6.lua")
dofile("init_wifi.lua")(s.wifi_mode,s.wifi_id,s.wifi_pass,s.wifi_phy,function(con)
 print(con)
 if(not srv_init)then dofile('web.lua')end
end)

