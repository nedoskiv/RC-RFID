						
rdr=1						--	value which RC522 is readed currently

rg=3				-- reset GPIO will be configured as input_pullup after system GPIO initialization to make idiotproof setup
gpio.mode(rg,gpio.INPUT,gpio.PULLUP)
if file.open("setting.json", "r") and gpio.read(rg)==1
	then
		local ok, json = pcall(sjson.decode,file.read('\n'))
		s = ok and json or {}
		file.close()
	else
		print ("Load defaults")
		s={
		ss1=0,				-- RC522 SDA(SS) pin	(avalable GPIO are: 0,8,1,2,9,10 last two are uart pins)
		ss2=8,				--  ( > 12 means not used reader 2 disabled)		(GPIO suitable for door/buzzer are: 1,2,9)
		bg=2,				--	(>12=disabled)buzzer gpio
		dg=1,				-- door gpio
		dov=gpio.HIGH,		--	door open value
		dcv=gpio.LOW,		--	door close value
		ob=13,				--	open button GPIO ( >12 disabled
		odt=5,				--	open door time (in seconds)
		cnt=1, 				--	tag usage count (1 enabled, other disabled)
		wopn=1,				--	open door by entering tag password via wifi (1 enabled, other disabled)
--		wifi_id = "RC8",
		wifi_id = "r-control.eu",
		wifi_pass = "88888888",
		wifi_mode = "ST",
		wifi_phy = wifi.PHYMODE_N,
		identity="RC-RFID",
		mqtt_port = "",
		mqtt_pass = "",
		mqtt_server = "",
		mqtt = "OFF",
		mqtt_login = "",
		mqtt_time = "",
		auth="ON",
		auth_login="admin",
		auth_pass="0000"
		}
end
s.token=node.random(10001,99999)

-- end system defaults

if s.ob >12
	then
		function obtn()
			return gpio.HIGH
		end
	else
		gpio.mode(s.ob,gpio.INPUT,gpio.PULLUP)
		function obtn()
			return (gpio.read(s.ob))
		end
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
   if file.open(f, "w") then
    file.write(json)
    file.close()
   end
   print(json)
   return "true"
 else
  return "false"
 end
end

