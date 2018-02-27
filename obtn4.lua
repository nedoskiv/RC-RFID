			gpio.write(s.dg,s.dov)
			print ("[ INFO ] Relay switched by BUTTON")
			tmr.alarm(4, s.odt*1000, tmr.ALARM_SINGLE, function() 					-- schedule wifi checkup after 10 seconds
				gpio.write(s.dg,s.dcv)
				print ("[ INFO ] Relay to normal after BUTTON usage")
				end )