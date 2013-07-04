# == Class: ldap_auth::config::redhat::6
#
# Helper class to split up configuration for redhat (and co).
# This class should never be called directly.
#
# === Todo:
#
# TODO: Move init of the nslcd service to somewhere else.
#       Service is not configuration.
# TODO: Do not hardcode the gid for nslcd
# TODO: Support ssl in nslcd configuration
# TODO: Support rootpwmoddn parameter
# TODO: Support rootpwmodpw
#
class ldap_auth::config::redhat::6 {

  require ldap_auth::config
  $server = $::ldap_auth::config::server
  $base   = $::ldap_auth::config::base
  $ssl    = $::ldap_auth::config::ssl
  $binddn = $::ldap_auth::config::binddn
  $bindpw = $::ldap_auth::config::bindpw
  $filter = $::ldap_auth::config::filter



  file {'/etc/nslcd.conf':
    owner   => 'root',
    group   => $::ldap_auth::nslcd_group,
    mode    => '0640',
    content => template('ldap_auth/nslcd.conf.erb'),
    require => Package[$::ldap_auth::packages],
    notify  => Service[$::ldap_auth::nslcd_service],
  }

  service {$::ldap_auth::nslcd_service:
    ensure  => 'running',
    alias   => 'nslcd',
    require => File['/etc/nslcd.conf'],
  }

  augeas{'authconfig':
    context => '/files/etc/authconfig',
    changes => [
      'set /files/etc/sysconfig/authconfig/USELDAPAUTH yes',
      'set /files/etc/sysconfig/authconfig/USELDAP yes',
      'set /files/etc/sysconfig/authconfig/USEMKHOMEDIR yes',
    ]
  }


  ldap_auth::config::redhat::pam_config { ['password-auth', 'system-auth']: }

}
