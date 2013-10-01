# == Class: nrpe::config
#
# Class in charge of configuration the nrpe configuration file
# /etc/nagios/nrpe.cfg using augeas. It also uses nrpe_command type provided
# by augeas provider
class nrpe::config (
  $properties = $nrpe::properties,
  $checks = $nrpe::checks,
){

  $changes = build_change_array($properties)
  $check_commands = build_command_hash($checks)

  if (!empty($checks)) {
    create_resources('nrpe_command',
                      $check_commands,
                      {'ensure' => present,
                      'before'  => Augeas['nrpe']})
    }

    if (!empty($changes)) {
      augeas {'nrpe' :
        context => '/files/etc/nagios/nrpe.cfg',
        changes => $changes,
      }
    }

}
