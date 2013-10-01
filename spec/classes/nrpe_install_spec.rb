require 'spec_helper'

describe 'nrpe::install' do

  let (:params) do
    {'nagios_plugins' => ['nagios-plugin-ssh']}
  end

  it 'includes class nrpe::params' do
    should include_class('nrpe::params')
  end

  context 'RedHat Based Distros' do

    let(:facts) do
      {:osfamily => 'RedHat',}
    end

    it 'install nrpe package' do
      should contain_package('nrpe') 
    end

    it 'contains nagios-plugin-ssh plugin' do
      should contain_package('nagios-plugin-ssh').with({
        'ensure' => 'installed',
        'require' => 'Package[nrpe]',
      })
    end
  
  end

  context 'Debian Base Distros' do

    let(:facts) do
      {:osfamily => 'Debian',}
    end

    it 'install nagios-nrpe-server package' do
      should contain_package('nagios-nrpe-server') 
    end

    it 'contains nagios-plugin-ssh plugin' do
      should contain_package('nagios-plugin-ssh').with({
        'ensure' => 'installed',
        'require' => 'Package[nagios-nrpe-server]',
      })
    end
  
  end
end
