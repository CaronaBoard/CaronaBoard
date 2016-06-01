import React        from 'react';
import {shallow}    from 'enzyme';
import {expect}     from 'chai';
import FeedbackBox  from './FeedbackBox.jsx';

describe('FeedbackBox', () => {
  let wrapper;

  beforeEach(() => {
    wrapper = shallow(<FeedbackBox/>);
  });

  it('should render with correct id', () => {
    expect(wrapper.props().id).to.eql('feedback');
  });

  it('should render feedback text', () => {
    expect(wrapper.text()).to.eql('Nos ajude a melhorar! Deixe aqui sua opinião/sugestão');
  });

  it('should render the correct link to google forms', () => {
    expect(wrapper.find('a').props().href).to.eql('http://goo.gl/forms/GYVDfZuhWg');
  });
});
