require 'spec_helper'

describe 'nrpe' do

  context 'RedHat Based Distros' do

    let(:facts) do
      {:osfamily => 'RedHat',}
    end

    it 'includes class epel' do
      should include_class('epel')
    end

    it 'includes class augeas' do
      should include_class('augeas')
    end

  end

  context 'Debian Based Distros' do

    let(:facts) do
      {:osfamily => 'Debian',}
    end

    it 'DOES NOT include class epel' do
      should_not include_class('epel')
    end

    it 'DOES NOT includes class augeas' do
      should_not include_class('augeas')
    end

  end

  it 'includes class stdlib' do
    should include_class('stdlib')
  end


  it 'includes class augeasproviders' do
    should include_class('augeasproviders')
  end

  it 'contains class nrpe::install' do
    should contain_class('nrpe::install')
  end

  it 'contains class nrpe::config' do
    should contain_class('nrpe::config')
  end

  it 'contains class nrpe::service' do
    should contain_class('nrpe::service')
  end

  it 'contains class nrpe' do
    should contain_class('nrpe')
  end

end
