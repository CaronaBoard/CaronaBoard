import React      from 'react';
import {shallow}  from 'enzyme';
import {expect}   from 'chai';
import App        from './App.jsx';

describe('App', () => {
  let wrapper;

  beforeEach(() => {
    wrapper = shallow(<App/>)
  });

  it('should render with correct id', () => {
    expect(wrapper.props().id).to.eql('app-main');
  });

  it('should render Header component', () => {
    expect(wrapper.find('Header')).to.have.length(1);
  });

  it('should render RoutesBox component', () => {
    expect(wrapper.find('RoutesBox')).to.have.length(1);
  });

});
