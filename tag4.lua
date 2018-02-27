return function(ui)
				print ("[ DEBUG ] "..ui.." - "..rdr)
				lt=ui					--	set global last tag variable
				local u=frj("T_"..ui)	-- n - name
										-- e - enabled 1, yes other no										--
										-- u - usage counter		
										-- mu - usage limit		
										--			
										--										--		
				if u ~= false
					then
						if u.e ==1		-- TAG is enabled
							then
								if s.cnt == 1 and u.u >= u.mu	
									then	-- counter system active and limit was exceeded, deny access
										buzz(1)
										tmr.delay(250000)
										buzz(0)
										return ("[ INFO ] Limit exceed for TAG "..u.n)
									else	--  Counting system inactive or tag is in limits, grand access
										gpio.write(s.dg,s.dov)
										tmr.alarm(4, s.odt*1000, tmr.ALARM_SINGLE, function() 					-- schedule wifi checkup after 10 seconds
											gpio.write(s.dg,s.dcv)
											print ("[ INFO ] Relay to normal after TAG usage")
											end )
										buzz(1)
										tmr.delay(50000)
										buzz(0)
										if s.cnt == 1	-- counter system active, increase counter
											then
												u.u=u.u+1
												fwoj ("T_"..ui,u)
												print ("[ INFO ] Counter increase to "..u.u.." for TAG "..u.n)
										end
										return ("[ INFO ] Access allowed for TAG "..u.n)
								end
							
							else	-- TAG disabled, deny access
								buzz(1)
								tmr.delay(250000)
								buzz(0)
								return ("[ INFO ] Disabled TAG ".. ui)
						end
					else
						buzz(1)
						tmr.delay(250000)
						buzz(0)
						return ("[ INFO ] Unknown TAG ".. ui)
				end
		end
 