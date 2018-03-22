return function(fn,tc,uc,wuc,tmp)
if file.open(fn, "a")
	then
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
end