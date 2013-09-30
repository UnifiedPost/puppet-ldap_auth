# == Class: ldap_auth::config::redhat::common
#
# Helper class to split up configuration for redhat (and co).
# This class should never be called directly.
#
# === Todo:
#
# TODO: tls_cacertdir parameter
# TODO: pam_password parameter
#
class ldap_auth::config::redhat::common {

  require ldap_auth::config
  $base   = $::ldap_auth::config::base
  $server = $::ldap_auth::config::server
  $ssl    = $::ldap_auth::config::ssl


  file {'/etc/pam_ldap.conf':
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('ldap_auth/pam_ldap.conf.erb'),
    require => Package[$::ldap_auth::packages],
  }

  if $::operatingsystemrelease =~ /^6/ {
    File['/etc/pam_ldap.conf'] {
      notify => Service[$::ldap_auth::nslcd_service],
    }
  }

  augeas{'redhat-nsswitch.conf':
    incl    => '/etc/nsswitch.conf',
    lens    => 'Nsswitch.lns',
    changes => [
      'set database[. = "passwd"]/service[1] files',
      'set database[. = "passwd"]/service[2] ldap',
      'set database[. = "shadow"]/service[1] files',
      'set database[. = "shadow"]/service[2] ldap',
      'set database[. = "group" ]/service[1] files',
      'set database[. = "group" ]/service[2] ldap',
      'set database[. = "netgroup" ]/service[1] files',
      'set database[. = "netgroup" ]/service[2] ldap',
      'set database[. = "automount" ]/service[1] files',
      'set database[. = "automount" ]/service[2] ldap',
    ],
    require => Package[$::ldap_auth::packages],
  }

}
