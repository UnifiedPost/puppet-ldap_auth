class ldap_auth::install (
  $packages = $::ldap_auth::packages,
) inherits ldap_auth {

  package {$packages:
    ensure => 'installed',
  }

}
