lt="none"		--	last read tag, gonna be used in web interface						
rdr=1						--	value which RC522 is readed currently
rg=3				-- reset GPIO not configurable, 3 is best choice

function frj (filetemp)
	if file.open(filetemp, "r")
		then
			local s
			local ok, json = pcall(sjson.decode,file.read('\n'))
			s = ok and json or {}
			file.close()
			return s
		else
			return false
	end
end

function fwoj(f,s)	-- file_write_override_json
 local ok, json = pcall(sjson.encode, s)
  if ok then
   if file.open(f, "w+") then
    file.write(json)
    file.close()
   end
   print("[ DEBUG ] "..json)
   return "true"
 else
  return "false"
 end
end


gpio.mode(rg,gpio.INPUT,gpio.PULLUP)
s={}
if file.open("setting.json", "r") and gpio.read(rg)==1
	then
		local ok, json = pcall(sjson.decode,file.read('\n'))
		s = ok and json or {}
		file.close()
end
if s.wifi_id == nil
	then								
		s={		
		md=0,				-- mode,0 normal (default config), 1 normal, 2 regenerate fulllist.html, 3 regenerate fulllist.html and clear counters,
							-- 4 generate exportag.html, 5 normal mode but keep s.token, 6 clear all counters, 7 delete all tags
		msg=3,				--	 display "default settings" msg on index.html, 3 defaul, 2 failure, 1 success
		ss1=0,				-- RC522 SDA(SS) pin	(avalable GPIO are: 0,8,1,2,9,10 last two are uart pins)
		ss2=8,				--  ( > 12 means not used reader 2 disabled)		
		bg=2,				--	(>12=disabled)buzzer gpio
		dg=1,				-- door gpio (GPIO suitable for door/buzzer are: 1,2,9)
		dov=gpio.HIGH,		--	door open value
		dcv=gpio.LOW,		--	door close value
		ob=3,				--	open button GPIO ( >12 disabled
		odt=5,				--	open door time (in seconds)
		cnt=1, 				--	tag usage count (1 enabled, 0 - disabled, 2 learning mode with counting, 3 learning mode without counting)
							--	in learning mode, device create record for every unknown tag (grand access too)
		mu=100,				--	Usage limit for learning mode registered TAGs, not interface configurable yet
		wa=1,				--	grant access thru password entered in web interface via wifi (1 enabled, other disabled)
--		wifi_id = "RC8",
		wifi_id = "r-control.eu",
		wifi_pass = "88888888",
		wifi_mode = "AP",
		wifi_phy = wifi.PHYMODE_N,
		nm="RC-RFID",		-- system name
		mqtt_port = "",
		mqtt_pass = "",
		mqtt_server = "",
		mqtt = "OFF",
		mqtt_login = "",
		mqtt_time = "",
		auth="ON",
		auth_login="admin",
		auth_pass="adm1n"
		}
end
gpio.mode(s.dg,gpio.OUTPUT)
gpio.write(s.dg,s.dcv)
s.md=tonumber(s.md)
if s.md < 2			-- only in normal mode regenerate token, otherwise keep old one to preserve user logged in
	then
		s.token=node.random(10001,99999)
end
-- end system defaults

if s.ob <13 and s.ob >0		-- set button open routine
	then
		gpio.mode(s.ob,gpio.INT,gpio.PULLUP)
		gpio.trig(s.ob,"down", function (level)
			dofile("obtn4.lc")
		end)

end

if s.bg >12
	then
		function buzz(a)
		end
	else
		gpio.mode(s.bg,gpio.OUTPUT)
		gpio.write(s.bg,gpio.LOW)
		function buzz(a)
			gpio.write(s.bg,a)
		end
end

if s.md==0		--	beep if system is with default config
	then
		print ("[ FUNCTIONS ] Default config loaded!")	
		buzz(1)
		tmr.delay(700000)
		buzz(0)
		tmr.delay(350000)
end
