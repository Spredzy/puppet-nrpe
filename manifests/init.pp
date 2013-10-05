# == Class: nrpe
#
# Yet Another NRPE Puppet Module. But this one uses all the power of
# augeas/augeasproviders
#
# === Parameters
#
# Document parameters here.
#
# [*properties*]
#   List of property to set on /etc/nagios/nrpe.cfg
#   ex. properties => {'server_port' => '3667', 'dont_blame_nrpe' => '1'}
#
# [*nagios_plugins*]
#   List of nagios plugins one wants to install on its system
#   ex. nagios_plugins => ['nagios-plugins-ping', 'nagios-plugins-http']
#
# [*checks*]
#   List if checks one wants its system to realized
#   ex. checks => {'check_http' =>
#                   '/usr/lib64/nagios/check_http -I 192.168.100.122'}
#
# === Example
#
#  class { nrpe:
#    properties => {'server_port'     => '3667',
#                   'dont_blame_nrpe' => '1'},
#    nagios_plugins => ['nagios-plugins-ping', 'nagios-plugins-http'],
#    checks =>
#      {'check_http' =>
#        '/usr/lib64/nagios/check_http -I 192.168.100.122',
#       'check_ping' =>
#        '/usr/lib64/nagios/check_ping -H 127.0.0.1 -w 100.0,20% -c 200.0,80%'}
#  }
#
# === Authors
#
#  Yanis Guenane  <yguenane@gmail.com>
#
# === Copyright
#
# Copyright 2013 Yanis Guenane
#
class nrpe (
  $properties = {},
  $nagios_plugins = [],
  $checks = {},
  ) {

  require augeasproviders
  require stdlib
  if $::osfamily == 'RedHat' {
    require epel
    require augeas
  }

  validate_hash($checks)
  validate_hash($properties)
  validate_array($nagios_plugins)

  class{'nrpe::install' :
    nagios_plugins  =>  $nagios_plugins,
    require         =>  [Class['epel'], Class['augeas'],
                          Class['augeasproviders'], Class['stdlib']],
  } ->
  class{'nrpe::config' :
    properties => $properties,
    checks     => $checks,
  } ~>
  class{'nrpe::service' : } ->
  Class['nrpe']

}
