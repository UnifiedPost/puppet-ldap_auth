class ldap_auth (
  $enable         = true,
  $server         = $::ldap_auth::params::server,
  $base           = $::ldap_auth::params::base,
  $binddn         = $::ldap_auth::params::binddn,
  $bindpw         = $::ldap_auth::params::bindpw,
  $ssl            = $::ldap_auth::params::ssl,
  $filter         = $::ldap_auth::params::filter,
  $packages       = $::ldap_auth::params::_packages,
  $nslcd_service  = $::ldap_auth::params::_nslcd_service,
) inherits ldap_auth::params {

  if $enable == true or $enable == 'true' {
    include ldap_auth::install
    include ldap_auth::config
  }

}
