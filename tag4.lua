local function opn()
		gpio.write(s.dg,s.dov)
		tmr.alarm(4, s.odt*1000, tmr.ALARM_SINGLE, function() 
			gpio.write(s.dg,s.dcv)
			print ("[ TAG4 ] Relay to normal after TAG usage")
		end )
end
local function deny()
	buzz(1)
	tmr.delay(250000)
	buzz(0)
end
return function(ui)
				if string.len(ui) <10
					then
						return ("[ TAG4 ] too short: "..ui.." - "..rdr)
				end
				print ("[ TAG4_DEBUG ] "..ui.." - "..rdr)
				lt=ui					--	set global last tag variable
				local u=frj("T_"..ui)	-- n - name
										-- e - enabled 1, yes other no										--
										-- e - enabled 1, yes other no										--
										-- u - usage counter		
										-- mu - usage limit		
										--			
										--										--		
				if u ~= false
					then
						if u.u == nil  or u.mu == nil or u.e== nil or u.n == nil	-- failsafe if read zero file
							then
								print ("[ TAG4 ] Invalid data:" ..ui.." - "..rdr)
								u={u=0, mu=100, e=0,n="ERROR"}
						end						
						if tonumber(u.e) ==1		-- TAG is enabled
							then
								if (s.cnt == 1 or s.cnt==2) and tonumber(u.u) >= tonumber(u.mu)	
									then	-- counter system active and limit was exceeded, deny access
										deny()
										return ("[ TAG4 ] Limit exceed for TAG "..ui.." " ..u.n)
									else	--  Counting system inactive or tag is in limits, grand access
										opn()
										buzz(1)
										tmr.delay(50000)
										buzz(0)
										if s.cnt == 1 or s.cnt==2	-- counter system active, increase counter
											then
												u.u=u.u+1
												fwoj ("T_"..ui,u)
												print ("[ TAG4 ] Counter increase to "..u.u.." for TAG "..ui.." " ..u.n)
										end
										return ("[ TAG4 ] Access allowed for TAG "..ui.." " ..u.n)
								end
							
							else	-- TAG disabled, deny access
								deny()
								return ("[ TAG4 ] Disabled TAG ".. ui)
						end
					else
						if s.cnt==2 or s.cnt ==3		-- learning mode enabled, add record for the tag
							then
								u=nil
								local u = 	{
											n = "Обуч.Режим "..ui,
											u = 1,
											mu = s.mu,
											e = 1
											}
								fwoj ("T_"..ui,u)
								opn()
								buzz(1)
								tmr.delay(50000)
								buzz(0)
								tmr.delay(100000)
								buzz(1)
								tmr.delay(50000)
								buzz(0)
								tmr.delay(100000)
								buzz(1)
								tmr.delay(50000)
								buzz(0)
								return ("[ TAG4 ] Learning mode, record added, access granted for  ".. ui)
							else
								deny()
								return ("[ TAG4 ] Unknown TAG ".. ui)
						end
				end
		end
 