import React      from 'react';
import {shallow}  from 'enzyme';
import {expect}   from 'chai';
import Header     from './Header.jsx';

describe('Header', () => {
  let wrapper;

  beforeEach(() => {
    wrapper = shallow(<Header/>);
  });

  it('should render with correct id', () => {
    expect(wrapper.find('#header')).to.have.length(1);
  });

  it('should render a title section', () => {
    expect(wrapper.find('#title')).to.have.length(1);
  });

  it('should render carona board logo', () => {
    expect(wrapper.find('img')).to.have.length(1);
    expect(wrapper.find('img').props().style).to.not.eql(undefined);
    expect(wrapper.find('img').props().src).to.not.eql(undefined);
  });

  it('should render carona board title text', () => {
    expect(wrapper.find('h1').text()).to.eql('Carona Board');
    expect(wrapper.find('h2').text()).to.eql('Seu carro não precisa levar apenas você');
  });

  it('should render carona button', () => {
    expect(wrapper.find('#button_offer')).to.have.length(1);
  });

  it('should have href link', () => {
    expect(wrapper.find('#button_offer a').props().href).to.not.eql(undefined);
  });


});
