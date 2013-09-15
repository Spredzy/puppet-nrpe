# == Class: nrpe::params
#
# Parameters based on Linux Distributions
#
class nrpe::params {

  case $::osfamily {
    'RedHat': {
      $package = ['nrpe']
    }
    'Debian': {
      $package = ['nagios-nrpe-server']
    }
    default: {
      $package = ['nrpe']
    }
  }

}
