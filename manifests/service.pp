# == Class: nrpe::service
#
# Class in charge of configuring the nrpe service
class nrpe::service {

  service {'nrpe' :
    ensure      => running,
    enable      => true,
    hasrestart  => true,
    hasstatus   => true,
  }

}
