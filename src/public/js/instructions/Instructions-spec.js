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
})
