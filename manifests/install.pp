# == Class: nrpe::install
#
# Class in charge of the installation of the nrpe package itself and the
# desired nagios plugins
class nrpe::install (
  $nagios_plugins = $nrpe::nagios_plugins,
  ) {

  include nrpe::params

  package{$nrpe::params::package :
    ensure => installed,
  }

  if(!empty($nagios_plugins)) {
    package {$nagios_plugins :
      ensure  => installed,
      require => Package[$nrpe::params::package],
    }
  }

}
