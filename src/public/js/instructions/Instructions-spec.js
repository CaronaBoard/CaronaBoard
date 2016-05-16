import React        from 'react';
import {shallow}    from 'enzyme';
import {expect}     from 'chai';
import Instructions from './Instructions.jsx';

describe('Instructions', () => {
  let wrapper;

  beforeEach(() => {
    wrapper = shallow(<Instructions/>);
  });

  it('should render with correct id', () => {
    expect(wrapper.props().id).to.eql('how_to');
  });

  it('should render instructions text correctly', () => {
    const liElements = wrapper.find('ol li');
    expect(liElements.at(0).text()).to.eql('Encontre uma rota que passe perto do seu destino');
    expect(liElements.at(1).text()).to.eql('Clique no botão "Quero Carona"');
    expect(liElements.at(2).text()).to.eql('Preencha o pedido de carona e envie o pedido');
    expect(liElements.at(3).text()).to.eql('Pronto! Seu colega oferecendo carona para a rota selecionada irá receber sua mensagem');
  });
})
