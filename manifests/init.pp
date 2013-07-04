# == Class: ldap_auth
#
# Set up ldap authentication
#
# === Parameters:
#
# [*enable*]
#   Flag indicating we should actually setup ldap authentication.
#   This can be used in hiera for example to enable/disable ldap authentication
#   while still including ldap_auth in your 'default' role.
#
# [*server*]
#   Name/IP of the ldap server to use. This is a required parameter!
#
# [*base*]
#   Base DN to use.
#
# [*binddn*]
#   DN to use while binding to the ldap server. Undefined by default.
#
# [*bindpw*]
#   Password to use while binding to the ldap server. Undefined by default.
#
# [*ssl*]
#   Enable ssl while connecting to the ldap server.
#   This can be either a boolean value which translates in 'on' or 'off' or a
#   string (start_tls).
#   Defaults to false.
#
# [*filter*]
#   LDAP search filters to use. This is only used by nslcd.
#   Defaults to an empty array.
#
# === Advanced Parameters:
#
# [*packages*]
#   Override the packages to install for this operatingsystem.
#   Defaults to OS specific.
#
# [*nslcd_service*]
#   Override the name of the nslcd service.
#   Defaults to 'nslcd'.
#
# [*nslcd_group*]
#   Override the group the nslcd service is running as.
#   Defaults to 'ldap'.
#
class ldap_auth (
  $enable         = true,
  $server         = $::ldap_auth::params::server,
  $base           = $::ldap_auth::params::base,
  $binddn         = $::ldap_auth::params::binddn,
  $bindpw         = $::ldap_auth::params::bindpw,
  $ssl            = $::ldap_auth::params::ssl,
  $filter         = $::ldap_auth::params::filter,
  $packages       = $::ldap_auth::params::_packages,
  $nslcd_service  = $::ldap_auth::params::nslcd_service,
  $nslcd_group    = $::ldap_auth::params::nslcd_group,
) inherits ldap_auth::params {

  if $enable == true or $enable == 'true' {
    include ldap_auth::install
    include ldap_auth::config
  }

}
