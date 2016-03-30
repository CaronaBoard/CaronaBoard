<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="description" content="You app for smart urban transport">
		<meta name="keywords" content="Transport, ride, urban, car, share">
		<meta name="author" content="Hege Refsnes">
		<link rel="stylesheet" type="text/css" href="index.css">
	</head>
	<body>
		<div id="page-wrap">
			<div id="header">
				<div id="topbar">
					<div id="title">
					<h1>Carona Board</h1>
					<h2>Seu carro não precisa levar apenas você</h2>
					</div>
					<div id="main_menu">
						<div id="button_offer"><a href="http://goo.gl/forms/ohEbgkMa9i">DOU CARONA!</a></div>
					</div>
				</div>
			</div>
		<div id="how_to">
			<ol>
				<li>Encontre uma rota que passe perto do seu destino</li>
				<li>Clique no botão "Quero Carona"</li>
				<li>Preencha o pedido de carona e envie o pedido</li>
				<li><strong>Pronto!</strong> Seu colega oferecendo carona para a rota selecionada irá receber sua mensagem</li>
			</ol>
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
						<td><div id="button_carona"><a href="aeroporto.php">VER TRAJETO</a></div></td>
					</tr>
					<tr>
						<td><strong>Antonio de Carvalho</strong></td>
						<td>
				            <ol>
				            	<li>Origem: Tecnopuc</li>
				            	<li>Destino: Antonio de Carvalho</li>
							</ol>
							<p class="depende">(*)Rota flexível? falar c/ motorista</p>
							</td>
						<td>Seg a Sex</td>
						<td>19:00 / 20:00</td>
						<td>Fulano da Silva</td>
						<td><div id="button_carona"><a href="antonio_carvalho.php">VER TRAJETO</a></div></td>
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
						<td>Siclano Silva</td>
						<td><div id="button_carona"><a href="auxiliadora.php">VER TRAJETO</a></div></td>
					</tr>
					<tr>
						<td><strong>Bela Vista</strong>								
						</td>
						<td>
							<ol>
						    	<li>Origem: Tecnopuc</li>
						        <li>Destino: Carlos Trein via Carlos Gomes</li>
							</ol>
							<p class="depende">(*)Rota flexível? falar c/ motorista</p>
						</td>
						<td>Seg a Sex</td>
						<td>19:00</td>
						<td>Fulana Silva</td>
						<td><div id="button_carona"><a href="bela_vista.php">VER TRAJETO</a></div></td>
					</tr>
					<tr>
						<td><strong>Bom fim</strong>
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
						<td><div id="button_carona"><a href="bomfim.php">VER TRAJETO</a></div></td>
					</tr>
					<tr>
						<td><strong>Canoas</strong></td>
						<td>
							<ol>
						    	<li>Origem: Tecnopuc</li>
						        <li>Destino: Canoas</li>
							</ol>
							<p class="depende">(*)Rota flexível? falar c/ motorista</p>
						</td>
						<td>Ter a Qui</td>
						<td>Sob Consulta</td>
						<td>Siclano Silva</td>
						<td><div id="button_carona"><a href="canoas.php">VER TRAJETO</a></div></td>
					</tr>
					<tr>
						<td><strong>Cavalhada</strong></td>
						<td>
							<ol>
							    <li>Origem: Tecnopuc</li>
							    <li>Destino: Cavalhada, passando pelo Praia de Belas</li>
							</ol>
							<p class="depende">(*)Rota flexível? Não</p>
						</td>
						<td>Ter a Sex</td>
						<td>19:00</td>
						<td>Beltrano da Silva</td>
						<td><div id="button_carona"><a href="cavalhada.php">VER TRAJETO</a></div></td>
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
						<td><div id="button_carona"><a href="lami.php">VER TRAJETO</a></div></td>
					</tr>
					<tr>
						<td><strong>Lima e Silva</strong></td>
						<td>
							<ol>
						    	<li>Origem: Tecnopuc</li>
						        <li>Destino: Lima e Silva</li>
							</ol>
							<p class="depende">(*)Rota flexível? falar c/ motorista</p>
						</td>
						<td>Seg a Sex</td>
						<td>18:00 / 19:00</td>
						<td>Siclana Silva</td>
						<td><div id="button_carona"><a href="lima_e_silva.php">VER TRAJETO</a></div></td>
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
						<td><div id="button_carona"><a href="menino_deus.php">VER TRAJETO</a></div></td>
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
						<td><div id="button_carona"><a href="nonoai.php">VER TRAJETO</a></div></td>
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
						<td><div id="button_carona"><a href="oscar_pereira.php">QUERO CARONA!</a></div></td>
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