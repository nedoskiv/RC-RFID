return function(fn,lt,ts)
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
				&nbsp;<br><h2 style="text-align:center">]]..lt..[[<br>Обща сума: ]]..ts..[[</h2>
<table style='border: none' cellspacing='0' width='100%'>
<tr><td class="info">Име</td><td class="info">RFID</td><td class="info">Достъп</td><td class="info">Брояч</td><td class="info">Лимит</td><td class="info">Сума</td></tr>]])
		file.close()
	else
		s.msg=2
end
end