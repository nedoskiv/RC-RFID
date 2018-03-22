
local function tofloatrup(num, zeros)
	local str=tostring(num)
	local slen=string.len(str) 
	if slen < zeros
		then
			for i=slen,zeros
				do
				str="0"..str
			end
	end

--	print (num,str)
	slen=string.len(str) 
--	print (slen,zeros)
	local parta=string.sub(str,1,(slen-zeros))
	if string.len(parta)==0 then parta="0" end
--	print ("a "..parta)
	local partb=string.sub(str,(slen-zeros+1),slen)
--	print ("b "..partb)
	local result=parta.."."..string.sub(partb,1,2)
--	print (result)
	local partc=string.sub(partb,3)
--	print ("c "..partc)
	if zeros>2 and tonumber(partc) >0
		then
--			print ("rounding")
			str=tostring(tonumber("9"..parta..string.sub(partb,1,2))+1)
			slen=string.len(str)
			parta=string.sub(str,2,(slen-2))
--			print ("a "..parta)
			partb=string.sub(str,(slen-1),slen)
--			print ("b "..partb)
--			print (parta.."."..partb)
			return parta.."."..partb, tonumber(parta..partb)
		else
			return result, tonumber(parta..string.sub(partb,1,2))
	end
end

local l = file.list();
local tc=0	
local uc=0
local wuc=0
local u={}
local buff=""
local tmp
local tmp1
local single
local suadd
print ("[ GEN_LIST ] Started.")
for k,v in pairs(l) do
  -- print("name:"..k)
 
  if #(k) > 6 and string.sub(k,1,2) == "T_"
    then
        tc=tc+1
		u={}
		u=frj(k)
		if u.u == nil  or u.mu == nil or u.e== nil or u.n == nil	-- failsafe if read zero file
			then
				print ("[ GEN_LIST ] Invalid data:" ..k)
				u={u=0, mu=100, wu=0,p="none",e=0,n="НЕВАЛИДНИ ДАННИ"}
		end


		uc=uc+u.u
		wuc=wuc+u.wu
  --      file.remove(k)
  end
end
local stat={}
stat=frj("listtitle")
stat.ts=tonumber(stat.ts)
stat.tu=uc+wuc
stat.addsum=0

single=(stat.ts*100000)/stat.tu

local fn ="fulllist.html"
s.msg=1
file.remove ("listtitlec")
if file.open(fn, "w+")
	then
		file.write([[<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<title>Списъци RC-RFID</title>
	<link href="style.css.gz" rel="stylesheet">
	<style>	
		.cont-flu {
			margin-top: 3em;
		}
th, td {
    padding: 15px!important;
}
	</style>
</head>
<body><input id="md" type="hidden"  value="2">
	<ul class="nav fix" id="myTopnav">
		<li><a id="distag" href="index.html">Информация</a></li>
		<li><a id="distag" href="settings.html">Настройки</a></li>
		<li><a href="#" class="brand">Управление на RFID</a></li>
		<li><a href="#" id="btn_restart">Рестарт</a></li>
		<li style="float:right;margin-right:10px;"><a href="#" id="btn_exit">Изход</a></li>
		<li style="float:right;margin-right:10px;"><a href="http://r-control.eu" target="_blank">R-Control</a></li>
		<li class="-icon"><a href="#" onclick="nav()">☰</a></li>
	</ul>
	<div id="Restart2" class="modal">
		<div class="m-cont">
			<span class="close" id="restart_c">&times;</span>
			<div class="m-body">
				<p>Желаете ли рестарт на устройството?</p>
			</div>
			<div class="m-foo">
				<button id="restart_m" class="success">Да</button>
				<button id="restart_c" class="danger">Не</button>
			</div>
		</div>
	</div>
	<div id="Restart1" class="modal">
		<div class="m-cont">
			<div class="m-body">
				<h3 style="text-align:center;">Устройството се рестартира, страницатa ще презареди след <span id="countdowntimer">15 </span> секунди</h3>
			</div>
		</div>
	</div>
	<div class="cont-flu">
		<div class="row">
			<div class="xs-12 sm-2 lg-2" style="min-width: 150px;">
				<h3>RFID</h3>
					<a class="side" id="distag" href="rfid.html" >Добавяне/Редактиране</a><br>
					<a class="side purple1" id="distag" href="rfidlist.html">Списъци</a><br>
					<a class="side" id="distag" href="rfidgenerate.html">Масови операции</a><br>
			</div>
						<div class="xs-12 sm-10 lg-9 ">
				&nbsp;<br><h2 style="text-align:center">]]..stat.lt..[[<br>Обща сума: ]]..stat.ts..[[</h2>
<table style='border: none' cellspacing='0' width='100%'>
<tr><td class="info">Име</td><td class="info">RFID</td><td class="info">Достъп</td><td class="info">Брояч</td><td class="info">Лимит</td><td class="info">Сума</td></tr>]])
		file.close()
	else
		s.msg=2
end
tc=0
uc=0
wuc=0
for k,v in pairs(l) do
  -- print("name:"..k)
 
  if #(k) > 6 and string.sub(k,1,2) == "T_"
    then
        tc=tc+1
		u={}
		u=frj(k)
		if u.u == nil  or u.mu == nil or u.e== nil or u.n == nil	-- failsafe if read zero file
			then
				print ("[ GEN_LIST ] Invalid data:" ..k)
				u={u=0, mu=100, wu=0,p="none",e=0,n="НЕВАЛИДНИ ДАННИ"}
		end
		buff=buff..'<tr><td><a href="rfid.html?tag='..string.sub(k,3)..'" class="brand">'..u.n..'</a></td><td>'..string.sub(k,3)..'</td><td>'
		u.e=tonumber(u.e)
		if u.e==1
			then
				buff=buff.."RFID"
			elseif u.e==2
				then
					buff=buff.."НЕ"
			elseif u.e==3
				then
					buff=buff.."WEB"
			elseif u.e==4
				then
					buff=buff.."RFID+WEB"
		end
		buff=buff..'</td><td>'..u.u..'/'..u.wu..'</td><td>'..u.mu..'</td>'
		tmp1 = single*(u.u+u.wu)
		tmp,tmp1=tofloatrup(tmp1,5)
		stat.addsum=stat.addsum+tmp1
		buff=buff.."<td>"..tmp.."</td></tr>\n"
		if #(buff) > 1024
			then
				buzz(1)
				if file.open(fn, "a") 
					then
						file.write(buff)
						file.close()
					else
						s.msg=2
				end
				print ("[ GEN_LIST ] Write")
				buff=""
				buzz(0)
		end
		uc=uc+u.u
		wuc=wuc+u.wu
  --      file.remove(k)
  end

end
tmp,tmp1=tofloatrup(stat.addsum,2)
if file.open(fn, "a")
	then
		file.write(buff)
		buff=nil
		file.write([[<tr><td colspan='4' class='info' style='text-align:center;'>Тагове общо : ]]..tc..[[. Използвания общо (RFID/WEB): ]]..uc+wuc..[[ (]]..uc..[[/]]..wuc..[[)
</td><td style='text-align:right;' class='info'>Обща сума:</td><td class='info'>]]..tmp..[[</td></tr></table>
</div></div></div></div>
<script>
window.onload = function () {
	var restart2 = document.getElementById('Restart2');
	var restart1 = document.getElementById('Restart1');
	var loading = document.getElementById('Loading');
	var tagen = 1;
	var int;
	function send(page, data, callback) {
		var req = new XMLHttpRequest();
		req.open("POST", page, true);
		req.setRequestHeader('Content-Type', 'application/json');
		req.addEventListener("load", function () {
			if (req.status < 400) {
				callback(req.responseText);
			} else {
				callback(req.status);
			}
		});
		req.send(JSON.stringify(data));
	}
		function nav() {
			var x = document.getElementById("myTopnav");
			if (x.classList.contains("res")) {
				x.classList.remove('res');
			} else {
				x.classList.add('res');
			}
		}
	function id(val) {
		return document.getElementById(val).value
	}
	function check_sel(val) {
		var s = document.getElementById(val);
		for (var i = 0; i < s.options.length; i++) {
			if (s.options[i].selected) {
				return s.options[i].value
			}
		}
	}
	function logout() {
		document.cookie = "id=";
		location.href = '/login.html';
	}
		
	function reboot() {
		var data = {init: "reboot"};
		send("web_control.lc", data, function (res) {
			if (res == "true")
				{
					restart2.style.opacity = "0";
					restart2.style.display = "none";
					restart1.style.opacity = "1";
					restart1.style.display = "block";
				    var timeleft = 15;
					var downloadTimer = setInterval(function(){
					timeleft--;
					document.getElementById("countdowntimer").textContent = timeleft;
					if(timeleft <= 0){
						clearInterval(downloadTimer);
						location.href = "/";}
					},1000);

				}
		})
	}
	document.body.addEventListener("click", function (event) {
		var a = document.getElementById('list');
		//alert(event.target.id)
		if (event.target.id == "btn_nav") {
			nav();
		} else if (event.target.id == "btn_exit") {
			tg={};
			logout();
		} else if (event.target.id == "distag") {
			loading.style.opacity = "1";
			loading.style.display = "block";
			tg={};
		} else if (event.target.id == "btn_restart") {
			restart2.style.opacity = "1";
			restart2.style.display = "block";
		} else if (event.target.id == "restart_c") {
			restart2.style.opacity = "0";
			restart2.style.display = "none";
			tagen=1;
		} else if (event.target.id == "restart_m") {
			reboot()
		}  else {
			a.style.display = 'none';
		}
	});
};
</script></body></html>]])
		file.close()
	else
		s.msg=2
end
u={}
u.tt=tc
u.tu=uc
u.twu=wuc
fwoj("setting.json",s)
fwoj("listtitlec",u)
print ("[ GEN_LIST ] Finished")
