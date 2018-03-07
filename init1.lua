dofile("functions.lc")
s.wifi_pass=tostring(s.wifi_pass)
----- different mode checkup should be placed here
if s.md == 5				--	mode 5, keep auth_token for next sessios (keep user signed in after reboot)
	then
		s.md=1
		fwoj("setting.json",s)
		print ("[ INIT1 ] System start in MODE 5")
end

--wifi init
cfg={}		
if s.wifi_mode=="AP"
	then
		cfg.ssid=s.wifi_id	
		if #(s.wifi_pass) < 8	-- if no password or invalid one, start up open network
			then
				cfg.auth=wifi.OPEN
				print ("[ INIT1 ] Wifi in open AP mode with SSID: "..s.wifi_id)
			else
				cfg.auth=wifi.WPA_PSK
				cfg.pwd=s.wifi_pass
				print ("[ INIT1 ] Wifi in AP mode (WPA-PSK: "..s.wifi_pass..") with SSID: "..s.wifi_id)
		end
		cfg.max=1			-- limit max available connection to 1 to decrease memory usage
		wifi.ap.config(cfg)
		wifi.setphymode(s.wifi_phy)
		wifi.setmode(wifi.SOFTAP)
	else
		cfg={}												-- set up wifi in station mode
		cfg.ssid=s.wifi_id
		cfg.pwd=s.wifi_pass
		cfg.save=true
		cfg.auto=true
		wifi.setmode(wifi.STATION)
		wifi.sta.config(cfg)
		print ("[ INIT1 ] Wifi in STA mode. SSID: "..s.wifi_id)
end
cfg=nil
dofile('web5.lc')
dofile("RC522.lc")
dofile("reader6.lc")
			buzz(1)
			tmr.delay(100000)
			buzz(0)
			tmr.delay(150000)
			buzz(1)
			tmr.delay(50000)
			buzz(0)
			tmr.delay(100000)
			buzz(1)
			tmr.delay(50000)
			buzz(0)
--dofile("init_wifi.lua")(s.wifi_mode,s.wifi_id,s.wifi_pass,s.wifi_phy,function(con)
-- print(con)
 --if(not srv_init)then dofile('web.lua')end
--end)

