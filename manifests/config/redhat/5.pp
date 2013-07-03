# == Class: ldap_auth::config::redhat::5
#
# Helper class to split up configuration for redhat (and co).
# This class should never be called directly.
#
# === Todo:
#
# TODO: Service nscd -> parameter?
#
class ldap_auth::config::redhat::5 {

  require ldap_auth::config

  # Used in templates.
  $server = $::ldap_auth::config::server
  $base   = $::ldap_auth::config::base
  $binddn = $::ldap_auth::config::binddn
  $bindpw = $::ldap_auth::config::bindpw
  $ssl    = $::ldap_auth::config::ssl


  File{
    owner => 'root',
    group => 'root',
  }

  file{'/etc/ldap.conf':
    mode    => '0644',
    content => template('ldap_auth/ldap.conf.erb'),
  }

  file{'/etc/ldap.secret':
    mode    => '0600',
    content => "${bindpw}\n",
  }

  service {'nscd':
    ensure => 'stopped',
  }

  ldap_auth::config::redhat::pam_config { 'system-auth': }
}
