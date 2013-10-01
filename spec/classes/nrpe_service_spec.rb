require 'spec_helper'

describe 'nrpe::service' do

    it 'contains nrpe service' do
      should contain_service('nrpe').with({
        'ensure'     => 'running',
        'enable'     => 'true',
        'hasrestart' => 'true',
        'hasstatus'  => 'true',
      })
    end

end
