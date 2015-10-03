require 'spec_helper'

describe 'lxc::networking::containers', :type => :class do
  context 'with default parameters' do
    let(:facts) do
      {
        :operatingsystem => 'Ubuntu',
        :lsbdistcodename => 'trusty',
      }
    end

    it 'will fail cause it is a private class' do
      expect{ should compile }.to raise_error
    end
  end
end
