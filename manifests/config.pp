class ldap_auth::config (
  $server = $::ldap_auth::server,
  $base   = $::ldap_auth::base,
  $binddn = $::ldap_auth::binddn,
  $bindpw = $::ldap_auth::bindpw,
  $ssl    = $::ldap_auth::ssl,
  $filter = $::ldap_auth::filter,
) inherits ldap_auth {

  if $server == undef {
    fail('You must specify a server for ldap authentication to work.')
  }

  case $::osfamily {
    'RedHat': { include ldap_auth::config::redhat }
    'Debian': { include ldap_auth::config::debian }
    default:  {}
  }

  include ldap_auth::config::common

}
