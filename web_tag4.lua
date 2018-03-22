local function opn()
		gpio.write(s.dg,s.dov)
		tmr.alarm(4, s.odt*1000, tmr.ALARM_SINGLE, function() 
			gpio.write(s.dg,s.dcv)
			print ("[ WEB_TAG4 ] Relay to normal after TAG usage")
		end )
end
local function deny()
	buzz(1)
	tmr.delay(250000)
	buzz(0)
end
return function(tab)
				if tonumber(s.auth)~=2		-- web login not allowed
					then
						print ("[ WEB_TAG4 ] WEB auth disabled")
						return "false"
				end
				local ui,np=string.gsub(tostring(tab.login),"3","C")
				ui,np=string.gsub(ui,"7","3")
				ui,np=string.gsub(ui,"0","7")
				ui,np=string.gsub(ui,"2","0")
				ui,np=string.gsub(ui,"F","2")
				ui,np=string.gsub(ui,"1","F")
				ui,np=string.gsub(ui,"A","1")
				ui,np=string.gsub(ui,"Z","A")
				
				if string.len(ui) <10
					then
						print ("[ WEB_TAG4 ] too short: "..ui)
						return ("false")
				end
				print ("[ WEB_TAG4_DEBUG ] "..ui.." - "..rdr)
				lt=ui					--	set global last tag variable
				local u=frj("T_"..ui)	-- n - name
										-- e - 1 RFID enabled , 2 disabled, 3 WEB enabled, 4 RFID and WEB enabled								--									--
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
								print ("[ WEB_TAG4 ] Invalid data:" ..ui.." - "..rdr)
								u={u=0, mu=100,p="none", wu=0,e=2,n="ERROR"}
								return ("false")
						end						
						if (u.e ==3 or u.e==4)	-- TAG is enabled for proper usage
							then
								if (s.cnt == 1 or s.cnt==2) and (u.u+u.wu) >=u.mu	
									then	-- counter system active and limit was exceeded, deny access
										deny()
										print ("[ WEB_TAG4 ] Limit exceed for TAG "..ui.." " ..u.n)
										return "false"
									else	--  Counting system inactive or tag is in limits, grand access
										if u.p ~= tab.pass
											then
												deny()
												print ("[ WEB_TAG4 ] Wrong password for TAG "..ui.." " ..u.n)
												return "false"
										end
										opn()
										buzz(1)
										tmr.delay(50000)
										buzz(0)
										if s.cnt == 1 or s.cnt==2	-- counter system active, increase counter
											then
												u.wu=u.wu+1
												fwoj ("T_"..ui,u)
												print ("[ WEB_TAG4 ] Counter increase to "..u.u.."/"..u.wu.." for TAG "..ui.." " ..u.n)
										end
										print ("[ WEB_TAG4 ] Access allowed for TAG "..ui.." " ..u.n)
										return "access"
								end
							
							else	-- TAG disabled, deny access
								deny()
								print ("[ WEB_TAG4 ] Access Denied for TAG ".. ui.." " ..u.n)
								return "false"
						end
					else

						deny()
						print ("[ WEB_TAG4 ] Unknown TAG ".. ui)
						return("false")

				end
		end
 