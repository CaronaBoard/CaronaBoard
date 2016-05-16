import React, {Component} from 'react';

class RoutesTable extends Component {
  constructor(props) {
    super(props);
  }

  render() {
    return (
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
          <td><div id="button_carona"><a href="http://goo.gl/forms/R5f1MI6WV2" target="_blank">QUERO CARONA</a></div></td>
        </tr>
        </tbody>
      </table>
    );
  }
}

export default RoutesTable;
