
tmr.alarm(6, 100, tmr.ALARM_AUTO, function() 					-- auto relay switching
tmr.stop(6)

--- RFID part start
		if rdr==1 and s.ss2 ~= nil
			then
				rdr=2
				pin_ss =s.ss2
			else
				if rdr==2
					then
						rdr=1
						pin_ss =s.ss1
				end
		end
		local isTagNear, cardType = RC522.request()
		if isTagNear == true or obtn()==gpio.LOW
			then
		--		iw(2,1)
				err, serialNo = RC522.anticoll()
		--		iw(2,0)
		--		print("Tag Found: "..appendHex(serialNo).."  of type: "..appendHex(cardType))

		--		RC522.select_tag(serialNo)
		--		buf = {}
		--		buf[1] = 0x50  --MF1_HALT
		--		buf[2] = 0
		--		crc = RC522.calculate_crc(buf)
		--		table.insert(buf, crc[1])
		--		table.insert(buf, crc[2])
		--		err, back_data, back_length = RC522.card_write(mode_transrec, buf)
		--		RC522.clear_bitmask(0x08, 0x08)    -- Turn off encryption
		--		iw(2,0)


				local ui=appendHex(serialNo)
				
				-- TAG check routine begin

				-- TAG check routine end

--      tmr.start(6)    
		end



--- end RFID PART	

tmr.start(6)
end)			-- timer


	