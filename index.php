<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="description" content="You app for smart urban transport">
		<meta name="keywords" content="Transport, ride, urban, car, share">
		<meta name="author" content="Hege Refsnes">
		<link rel="stylesheet" type="text/css" href="index.css">
		<link href="dist/lity.css" rel="stylesheet">
		<script src="vendor/jquery.js"></script>
		<script src="dist/lity.js"></script>
		<script src="http://cdn.jquerytools.org/1.2.6/full/jquery.tools.min.js"></script>
	</head>
	<body>
		<div id="page-wrap">
			<div id="header">
			<div id="title">
			<h1>Carona Board</h1>
			<h2>Seu carro não precisa levar apenas você</h2>
			<a href="//maps.google.com/maps?q=1600+Amphitheatre+Parkway,+Mountain+View,+CA" data-lity>Google Maps</a>

			<ol>
				<li>Encontre uma rota que passe perto do seu destino</li>
				<li>Clique no botão "Quero Carona"</li>
				<li>Preencha o pedido de carona e envie o pedido</li>
				<li><strong>Pronto!</strong> Seu colega oferecendo carona para a rota selecionada irá receber sua mensagem</li>
			</ol>
			</div>
			<div id="dar_carona">
			<h4>AVISO: PRECISAMOS DE DOADORES DE CARONA PARA ZONA NORTE!</h4>
			<h3>Voce quer dar carona? </h3> <a class="cadastro" href="http://goo.gl/forms/ohEbgkMa9i" target="_blank">Se cadastre aqui</a>
			</div>
			</div>
			<table>
					<thead>
						<tr>
							<th>Rota</th>
							<th>Trajeto</th>
							<th>Quando</th>
							<th>Horário</th>
							<th>Motorista</th>
							<th></th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><strong>Aeroporto</strong></td>
				            <td>
				            	<ol>
				            		<li>Origem: Tecnopuc</li>
				            		<li>Destino: Estação Trensurb Bairro Anchieta</li>
				            	</ol>
				            	<p class="depende">(*)Rota flexível? falar c/ motorista</p>
							</td>
							<td>Seg a Sex</td>
							<td>19:00</td>
							<td>Fulana Silva</td>
							<td><div id="button_carona"><a href="http://goo.gl/forms/TQAKwXzAg3" target="_blank">QUERO CARONA!</a></div></td>
						</tr>
						<tr>
							<td><strong>Auxiliadora</strong></td>
				            <td>
				            	<ol>
				            		<li>Origem: Tecnopuc</li>
				            		<li>Destino: Carlos Gomas, 24 de Outubro</li>
				            	</ol>
				            	<p class="depende">(*)Rota flexível? falar c/ motorista</p>
							</td>
							<td>Seg a Sex</td>
							<td>18:00 - 19:00</td>
							<td>Silva</td>
							<td><div id="button_carona"><a href="http://goo.gl/forms/87JyMW0t67" target="_blank">QUERO CARONA!</a></div></td>
						</tr>
						<tr>
							<td><strong>Bela Vista  </strong>								
								<a href="https://www.google.com.br/maps/dir/TECNOPUC+-+Partenon,+Porto+Alegre+-+RS/Carlos+Trein+Filho+-+Bela+Vista,+Porto+Alegre+-+RS/@-30.0481431,-51.1852474,15z/am=t/data=!3m1!4b1!4m24!4m23!1m15!1m1!1s0x951977fd79a847e5:0xa0f279b1e3f4bf0c!2m2!1d-51.1708715!2d-30.0605766!3m4!1m2!1d-51.1699103!2d-30.0607584!3s0x95199d57c24395d1:0xcf307595038b8b1e!3m4!1m2!1d-51.169518!2d-30.0577733!3s0x951977fd2fdee359:0xadfb535019ff0522!1m5!1m1!1s0x9519782f3fcd7331:0x6cfe95fc3c8daf7a!2m2!1d-51.185946!2d-30.034618!3e0?hl=en" data-lity>Ver mapa</a>
							</td>
							<td>
								<ol id="passos">
							    	<li>Origem: Tecnopuc</li>
							        <li>Destino: Bela Vista/Auxiliadora, Carlos Trein/Praça da Encol</li>
								</ol>
								<p class="depende">(*)Rota flexível? falar c/ motorista</p>
							</td>
							<td>Seg a Sex</td>
							<td>19:00</td>
							<td>Fulana Silva</td>
							<td><div id="button_carona"><a href="http://goo.gl/forms/wNlXVAzL6N" target="_blank">QUERO CARONA!</a></div></td>
						</tr>
						<tr>
							<td><strong>Bom fim  </strong>
								<a href="https://www.google.com.br/maps/dir/TECNOPUC+-+Partenon,+Porto+Alegre+-+RS/R.+Castro+Alves+-+Rio+Branco,+Porto+Alegre+-+RS,+90430-131/@-30.0466386,-51.1943547,15z/am=t/data=!3m1!4b1!4m19!4m18!1m10!1m1!1s0x951977fd79a847e5:0xa0f279b1e3f4bf0c!2m2!1d-51.1708715!2d-30.0605766!3m4!1m2!1d-51.168213!2d-30.0587225!3s0x951977e2b41b3051:0x88311f0f21437f8c!1m5!1m1!1s0x951979b4c2779f2b:0xc8efd031a2567be5!2m2!1d-51.2032468!2d-30.0312229!3e0?hl=en" data-lity>Ver mapa</a>
							</td>
							<td>
								<ol>
							    	<li>Origem: Tecnopuc</li>
									<li>Destino: Castro Alves</li>
								</ol>
								<p class="sim">(*)Rota flexível? Sim</p>
							</td>
							<td>Seg a Sex</td>
							<td>19:00 a 20:00</td>
							<td>Fulano Silva</td>
							<td><div id="button_carona"><a href="http://goo.gl/forms/Jt7rddWqFn" target="_blank">QUERO CARONA!</a></div></td>
						</tr>
						<tr>
							<td><strong>Canoas</strong></td>
							<td>
								<ol id="passos">
							    	<li>Origem: Tecnopuc</li>
							        <li>Destino: Canoas</li>
								</ol>
								<p class="depende">(*)Rota flexível? falar c/ motorista</p>
							</td>
							<td>Ter a Qui</td>
							<td>Sob Consulta</td>
							<td>Siclano</td>
							<td><div id="button_carona"><a href="http://goo.gl/forms/o9oLoISHlK" target="_blank">QUERO CARONA!</a></div></td>
						</tr>
						<tr>
							<td><strong>Cavalhada</strong></td>
							<td>
								<ol id="passos">
							    	<li>Origem: Tecnopuc</li>
							        <li>Destino: Cavalhada, passando pelo Praia de Belas</li>
								</ol>
								<p class="depende">(*)Rota flexível? Não</p>
							</td>
							<td>Ter a Sex</td>
							<td>19:00</td>
							<td>Beltrano da Silva</td>
							<td><div id="button_carona"><a href="http://goo.gl/forms/yIVHABCEkV" target="_blank">QUERO CARONA!</a></div></td>
						</tr>
						<tr>
							<td><strong>Cidade Baixa</strong></td>
							<td>
								<ol id="passos">
							    	<li>Origem: Tecnopuc</li>
							        <li>Destino: Lima e Silva / República</li>
								</ol>
								<p class="depende">(*)Rota flexível? falar c/ motorista</p>
							</td>
							<td>Seg a Sex</td>
							<td>18:00 a 19:00</td>
							<td>Siclana Silva & Beltrana da Silva</td>
							<td><div id="button_carona"><a href="http://goo.gl/forms/3zFqZS1SvR" target="_blank">QUERO CARONA!</a></div></td>
						</tr>
						<tr>
							<td><strong>Lami</strong></td>
							<td>
				            	<ol>
				            		<li>Origem: Tecnopuc</li>
				            		<li>Destino: Lami, via Oscar Pereria ou Lomba do Pinheiro</li>
								</ol>
								<p class="depende">(*)Rota flexível? falar c/ motorista</p>
							</td>
							<td>Seg a Sex</td>
							<td>Ida para PUC(8h00) - Volta, depende do dia (consultar)</td>
							<td>Siclana Silva</td>
							<td><div id="button_carona"><a href="http://goo.gl/forms/h8wRZf9hje" target="_blank">QUERO CARONA!</a></div></td>
						</tr>
						<tr>
							<td><strong>Menino Deus</strong></td>
							<td>
				            	<ol>
				            		<li>Origem: Tecnopuc</li>
				            		<li>Destino: Menino Deus, via Ipiranga até Érico</li>
								</ol>
								<p class="sim">(*)Rota flexível? Sim</p>
							</td>
							<td>Seg a Sex</td>
							<td>19:00 / 19:30</td>
							<td>Fulano da Silva</td>
							<td><div id="button_carona"><a href="http://goo.gl/forms/rPfxpSo5Vs" target="_blank">QUERO CARONA!</a></div></td>
						</tr>
						<tr>
							<td><strong>Nonoai</strong></td>
							<td>
				            	<ol>
				            		<li>Origem: Tecnopuc</li>
				            		<li>Destino: Nonoai via orfanatrófio</li>
								</ol>
								<p class="depende">(*)Rota flexível? falar c/ motorista</p>
							</td>
							<td>Seg a Sex</td>
							<td>19:00</td>
							<td>Siclano Silva</td>
							<td><div id="button_carona"><a href="http://goo.gl/forms/dbR9YM963H" target="_blank">QUERO CARONA!</a></div></td>
						</tr>
						<tr>
							<td><strong>Oscar Pereira</strong></td>
							<td>
				            	<ol>
				            		<li>Origem: Tecnopuc</li>
				            		<li>Destino: oscar Pereira via Azenha ou Bento</li>
								</ol>
								<p class="depende">(*)Rota flexível? falar c/ motorista</p>
							</td>
							<td>Seg a Sex</td>
							<td>19:00 a 20:00</td>
							<td>Beltrano Silva</td>
							<td><div id="button_carona"><a href="http://goo.gl/forms/hyGj1rx26x" target="_blank">QUERO CARONA!</a></div></td>
						</tr>
						<tr>
							<td><strong>Petrópolis</strong></td>
							<td>
				            	<ol>
				            		<li>Origem: Tecnopuc</li>
				            		<li>Destino: Rua Lavras</li>
								</ol>
								<p class="depende">(*)Rota flexível? falar c/ motorista</p>
							</td>
							<td>Seg a Sex</td>
							<td>9:00</td>
							<td>Fulano Silva</td>
							<td><div id="button_carona"><a href="http://goo.gl/forms/dF11ctBlBT" target="_blank">QUERO CARONA!</a></div></td>
						</tr>
						<tr>
							<td><strong>Santo Antônio (perto colégio La Salle)</strong></td>
							<td>
				            	<ol>
				            		<li>Origem: Tecnopuc</li>
				            		<li>Destino: Santo Antônio via Bento</li>
								</ol>
								<p class="depende">(*)Rota flexível? falar c/ motorista</p>
							</td>
							<td>Seg a Sex</td>
							<td>Sob consulta</td>
							<td>Fulano Silva & Siclano Silva</td>
							<td><div id="button_carona"><a href="http://goo.gl/forms/yezpR5lzGY" target="_blank">QUERO CARONA!</a></div></td>
						</tr>
						<tr>
							<td><strong>Sogipa</strong></td>
							<td>
				            	<ol>
				            		<li>Origem: Tecnopuc</li>
				            		<li>Destino: Sogipa, via C.Fisher, Perimetral e Assis Brasil</li>
								</ol>
								<p class="depende">(*)Rota flexível? falar c/ motorista</p>
							</td>
							<td>Seg & Qua</td>
							<td>19:00</td>
							<td>Fulana Silva</td>
							<td><div id="button_carona"><a href="http://goo.gl/forms/iKCKMbnNX3" target="_blank">QUERO CARONA!</a></div></td>
						</tr>
					</tbody> 
				</table>
			<p></p>
			<div id="feedback">
			<h3>Nos ajude a melhorar!</h3> <a class="cadastro" href="http://goo.gl/forms/GYVDfZuhWg" target="_blank">Deixe aqui sua opinião/sugestão</a>
			</div>
		</div>
	</body>
<html>