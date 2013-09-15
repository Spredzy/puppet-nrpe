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
#   ex. checks => {'check_http' => '/usr/lib64/nagios/check_http -I 192.168.100.122',
#                  'check_ping' => '/usr/lib64/nagios/check_ping -H 127.0.0.1 -w 100.0,20% -c 200.0,80%'}
#
# === Examples
#
#  class { nrpe:
#    properties => {'server_port'     => '3667',
#                   'dont_blame_nrpe' => '1'},
#    nagios_plugins => ['nagios-plugins-ping', 'nagios-plugins-http'],
#    checks => {'check_http' => '/usr/lib64/nagios/check_http -I 192.168.100.122',
#               'check_ping' => '/usr/lib64/nagios/check_ping -H 127.0.0.1 -w 100.0,20% -c 200.0,80%'},
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

  require stdlib
  require epel
  require augeasproviders

  validate_hash($checks)
  validate_hash($properties)
  validate_array($nagios_plugins)

  $changes = build_change_array($properties)
  $check_commands = build_command_hash($checks)

  package {'nrpe' :
    ensure => installed,
  }
  
  if(!empty($nagios_plugins)) {

    package {$nagios_plugins :
      ensure => installed,
      require => Package['nrpe'],
    }

  }

  if (!empty($checks)) {
    create_resources('nrpe_command', $check_commands, {'ensure' => present, 'require' => Package['nrpe'], 'before' => Augeas['nrpe']})
  }

  if (!empty($changes)) {

    augeas {'nrpe' :
      context => '/files/etc/nagios/nrpe.cfg',
      changes => $changes,
      notify  => Service['nrpe'],
    }

  }

  service {'nrpe' :
    ensure      => running,
    enable      => true,
    hasrestart  => true,
    hasstatus   => true,
  }

}
