require 'spec_helper'

describe 'nrpe::config' do

  let(:params) do
    {'properties' => {'dont_blame_nrpe' => '1'},
     'checks' => {'check_http' => '/usr/lib64/nagios/check_http -I 127.0.0.1'},
    }
  end

  it 'contains nagios-plugins-http nrpe_command' do
    should contain_nrpe_command('check_http').with({
      'ensure'  => 'present',
      'command' => '/usr/lib64/nagios/check_http -I 127.0.0.1',
#      'before'  => "Augeas['nrpe']",
    })
  end

    it 'set dont_blame_nrpe = 1' do
      should contain_augeas('nrpe').with({
        'context' => '/files/etc/nagios/nrpe.cfg',
        'changes'  => 'set dont_blame_nrpe 1',
      })
    end
end
