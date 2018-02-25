## ESP8266-LUA-MFRC522-access-control
RFID access control system based on cheap ESP8266 and MFRC522 writen in LUA on nodemcu

# Hardware:
Those are used by me:

[MFRC522](https://www.aliexpress.com/item/2PCS-MFRC-522-RC-522-Module-S50-RC522-Wireless-IC-RFID-Fudan-MFRC522-SPI-Writer-Reader/32847311032.html?ws_ab_test=searchweb0_0,searchweb201602_5_10152_10151_10065_10344_10068_10342_10343_10340_10341_10084_10083_10618_10630_10304_10307_10302_5711211_5722315_10313_10059_10534_100031_10103_10627_10626_10624_10623_10622_10621_10620_5711313_10142,searchweb201603_25,ppcSwitch_5&algo_expid=5781ac79-1a5f-4aab-ae26-798d1394cc6f-9&algo_pvid=5781ac79-1a5f-4aab-ae26-798d1394cc6f&priceBeautifyAB=0)

[Wemos D1 mini](https://www.aliexpress.com/item/1PCS-D1-mini-V2-Mini-NodeMcu-4M-bytes-Lua-WIFI-development-ESP8266-by-WeMos/32754697134.html?ws_ab_test=searchweb0_0%2Csearchweb201602_5_10152_10151_10065_10344_10068_10342_10343_10340_10341_10084_10083_10618_10630_10304_10307_10302_5711211_5722315_10313_10059_10534_100031_10103_10627_10626_10624_10623_10622_10621_10620_5711313_10142%2Csearchweb201603_25%2CppcSwitch_5&algo_expid=70d134ed-b2cf-4204-801a-484604cb7f80-0&algo_pvid=70d134ed-b2cf-4204-801a-484604cb7f80&priceBeautifyAB=0)

a few other components gonna be needed for hardware part of the project I will make fritzing schema and post it later.

# Web server:
This web server gonna be used for basic frontend interface:

[bondrogeen web server](https://github.com/bondrogeen/web-server)

# Goals:
* Standalone RFID control system. Usable on building entrances/exits, elevators, etc.
* Support dual RFID readers 
* Support usage TAG counters
* Support TAG usage limits
* Generate report for all tags
* Switching lights, depending on light intensity (LDR gonna be used)
* Door open button (if only one reader is used)
* TAG authentication via web page using password
* MQTT logging 

# Possible problems:

* Out of memory :)
