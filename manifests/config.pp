class ldap_auth::config {

  case $::osfamily {
    'RedHat': { include ldap_auth::config::redhat }
    'Debian': { include ldap_auth::config::debian }
    default:  {}
  }

  include ldap_auth::config::common

}
