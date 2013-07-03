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
    content => "${ldap_auth::params::_bindpw}\n",
  }

  service{'nscd':
    ensure => 'stopped',
  }

  ldap_auth::config::redhat::pam_config { 'system-auth': }
}
