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
				ui=tostring(ui)
				if string.len(ui) <10
					then
						return ("[ TAG4 ] too short: "..ui.." - "..rdr)
				end
				print ("[ TAG4_DEBUG ] "..ui.." - "..rdr)
				lt=ui					--	set global last tag variable
				local u=frj("T_"..ui)	-- n - name
										-- e - 1 RFID enabled , 2 disabled, 3 WEB enabled, 4 RFID and WEB enabled									--									--
										-- u - usage counter by RFID		
										-- mu - usage limit		
										--	wu - usege counter by web	
										--

										
				if u ~= false
					then
						u.e=tonumber(u.e)
						u.u=tonumber(u.u)
						u.wu=tonumber(u.wu)
						u.mu=tonumber(u.mu)
						if u.u == nil  or u.mu == nil or u.e== nil or u.n == nil	-- failsafe if read zero file
							then
								print ("[ TAG4 ] Invalid data:" ..ui.." - "..rdr)
								u={u=0, mu=100,p="none", wu=0,e=2,n="ERROR"}
						end						
						if (u.e ==1 or u.e==4)	-- TAG is enabled for proper usage
							then
								if (s.cnt == 1 or s.cnt==2) and (u.u+u.wu) >=u.mu	
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
												print ("[ TAG4 ] Counter increase to "..u.u.."/"..u.wu.." for TAG "..ui.." " ..u.n)
										end
										return ("[ TAG4 ] Access allowed for TAG "..ui.." " ..u.n)
								end
							
							else	-- TAG disabled, deny access
								deny()
								return ("[ TAG4 ] Access Denied for TAG ".. ui.." " ..u.n)
						end
					else
						if s.cnt==2 or s.cnt ==3		-- learning mode enabled and call come from RFID, add record for the tag
							then
								u=nil
								local u = 	{
											n = "Обуч.Режим "..ui,
											u = 1,
											wu = 0,
											p = "none",
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
 