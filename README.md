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

# Done so far:

* Fixed various web server memory leaks
* Backend (for reading/updating/editing/grant access to tags)
* Buzzer support
* Dual RFID readers support
* Grant access by button
* Learning mode (automated records creation for new tags)
* Counting of tag usage, limits, deny access if go above limit
* FrontEND - settings, add/edit/delete tag
* Added tag list creation is separate boot mode
* Added export tag (JSON format) in separate boot mode
* Added user authentication (for access) via login screen.
* Added amound calculation based on tag usage (lists)

# TODO:

* testing.
* possible wireless CFG problem, investigate
* MQTT logging
* find a way to import tags thru web interface

# Short installation instructions:

use nodemcu with following support :
adc,bit,file,gpio,net,node,sjson,spi,tmr,uart,wifi

Download all files, upload them to ESP, start compile.lua and reboot
Use google chrome to translate it in your language.
default wireless password is "88888888"

# Known issues:

* When switch from wireless client to AP mode, do not initialize with proper SSID/PASSWORD (until reboot twice)

# Limitations:

* Due to nodemcu file.list function, scripts are capable of generate tag lists/export json file for around 200-250 tags. Increasing it cause out of memory error that cannot be avoided unless someone rewrite nodemcu file module. However system still work, add/edit/delete tags but cannot generate list.
* Web server cannot handle more than 2 connection at same time (out of memory) so make sure you use only one browser window to access web interface.


### Pin Layout

Primary MFRC522 reader:

| Signal        | MFRC522       | WeMos D1 mini  | NodeMcu | Generic      |
|---------------|:-------------:|:--------------:| :------:|:------------:|
| RST/Reset     | RST           | NONE           | NONE    | NONE         |
| SPI SS        | SDA [3]       | D8 [2]         | D8 [2]  | GPIO-15 [2]  |
| SPI MOSI      | MOSI          | D7             | D7      | GPIO-13      |
| SPI MISO      | MISO          | D6             | D6      | GPIO-12      |
| SPI SCK       | SCK           | D5             | D5      | GPIO-14      |
| SPI IRQ       | NONE          | NONE           | NONE    | GPIO-14      |

Secondary RFID reader:

| Signal        | MFRC522       | WeMos D1 mini  | NodeMcu | Generic      |
|---------------|:-------------:|:--------------:| :------:|:------------:|
| RST/Reset     | RST           | NONE           | NONE    | NONE         |
| SPI SS        | SDA [3]       | D0             | D0      | GPIO-16      |
| SPI MOSI      | MOSI          | D7             | D7      | GPIO-13      |
| SPI MISO      | MISO          | D6             | D6      | GPIO-12      |
| SPI SCK       | SCK           | D5             | D5      | GPIO-14      |
| SPI IRQ       | NONE          | NONE           | NONE    | GPIO-14      |

reset button on GPIO 0
Grant access button on GPIO 1,2,9,10
buzzer: GPIO 1,2,9
Relay: 1,2,9




# FINAL notes
I switch that project for my private and commercial use. Code listed here is good for a start for someone who want to achieve good, cheap standalone RFID system.


![Image description](https://raw.githubusercontent.com/nedoskiv/RC-RFID/master/rc-rfid_bb.jpg)
