import React, {Component} from 'react';

class Instructions extends Component {
  constructor(props) {
    super(props);
  }

  render() {
    return (
      <div id="how_to">
        <ol>
          <li>Encontre uma rota que passe perto do seu destino</li>
          <li>Clique no botão "Quero Carona"</li>
          <li>Preencha o pedido de carona e envie o pedido</li>
          <li><strong>Pronto!</strong> Seu colega oferecendo carona para a rota selecionada irá receber sua mensagem</li>
        </ol>
      </div>
    );
  }
}

export default Instructions;
