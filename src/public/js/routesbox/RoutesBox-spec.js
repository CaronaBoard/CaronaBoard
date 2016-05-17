import React      from 'react';
import {shallow}  from 'enzyme';
import {expect}   from 'chai';
import RoutesBox  from './RoutesBox.jsx';

describe('RoutesBox', () => {
  let wrapper;

  beforeEach(() => {
    wrapper = shallow(<RoutesBox/>);
  });

  it('should render RoutesTable component', () => {
    expect(wrapper.find('RoutesTable')).to.have.length(1);
  });

  it('should render FeedbackBox component', () => {
    expect(wrapper.find('FeedbackBox')).to.have.length(1);
  });
});
