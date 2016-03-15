<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="description" content="You app for smart urban transport">
		<meta name="keywords" content="Transport, ride, urban, car, share">
		<meta name="author" content="Hege Refsnes">
		<link rel="stylesheet" type="text/css" href="index.css">
		<script src="http://cdn.jquerytools.org/1.2.6/full/jquery.tools.min.js"></script>
	</head>
	<body>
		<div id="page-wrap">
			<div id="header">
			<div id="title">
			<h1>Carona Board</h1>
			<h2>Seu carro não precisa levar apenas você</h2>
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
							<td>Fulana</td>
							<td><div id="button_carona"><a href="http://goo.gl/forms/TQAKwXzAg3" target="_blank">QUERO CARONA!</a></div></td>
						</tr>
						<tr>
							<td><strong>Bom fim</strong></td>
							<td>
								<ol>
							    	<li>Origem: Tecnopuc</li>
									<li>Destino: Castro Alves</li>
								</ol>
								<p class="sim">(*)Rota flexível? Sim</p>
							</td>
							<td>Seg a Sex</td>
							<td>19:00 a 20:00</td>
							<td>Silva</td>
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
							<td><strong>Cidade Baixa</strong></td>
							<td>
								<ol id="passos">
							    	<li>Origem: Tecnopuc</li>
							        <li>Destino: Lima e Silva</li>
								</ol>
								<p class="depende">(*)Rota flexível? falar c/ motorista</p>
							</td>
							<td>Seg a Sex</td>
							<td>18:00 a 19:00</td>
							<td>Siclana</td>
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
							<td>Siclana</td>
							<td><div id="button_carona"><a href="http://goo.gl/forms/h8wRZf9hje" target="_blank">QUERO CARONA!</a></div></td>
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
							<td>Siclano</td>
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
							<td>Beltrano</td>
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
							<td>Fulano</td>
							<td><div id="button_carona"><a href="http://goo.gl/forms/dF11ctBlBT" target="_blank">QUERO CARONA!</a></div></td>
						</tr>
						<tr>
							<td><strong>Protásio Alves</strong></td>
							<td>
				            	<ol>
				            		<li>Origem: Tecnopuc</li>
				            		<li>Destino: Protásio Alves esquina com Carlos Gomes</li>
								</ol>
								<p class="depende">(*)Rota flexível? falar c/ motorista</p>
							</td>
							<td>Seg, Qua</td>
							<td>18:00 a 19:00</td>
							<td>Fulana</td>
							<td><div id="button_carona"><a href="http://goo.gl/forms/iKCKMbnNX3" target="_blank">QUERO CARONA!</a></div></td>
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
							<td>Fulano & Siclano</td>
							<td><div id="button_carona"><a href="http://goo.gl/forms/yezpR5lzGY" target="_blank">QUERO CARONA!</a></div></td>
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