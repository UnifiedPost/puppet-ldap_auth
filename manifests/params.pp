class ldap_auth::params (
  $packages      = undef,
  $server        = undef,
  $base          = undef,
  $binddn        = undef,
  $bindpw        = undef,
  $filter        = [],
  $nslcd_service = undef,
  $ssl           = false,
) {

  ########################
  ####    Packages    ####
  ########################

  $_packages = $packages ? {
    undef   => $::osfamily ? {
      'RedHat'  => $::operatingsystemrelease ? {
        default   => [ "nss-pam-ldapd.${::architecture}" ],
        /^5/      => [ "nss_ldap.${::architecture}" ],
      },
      'Debian'  => [ 'libnss-ldapd' , 'libpam-ldapd' ],
    },
    default => $packages,
  }

  ########################
  ####    Service     ####
  ########################

  $_nslcd_service = $nslcd_service ? {
    undef   => 'nslcd',
    default => $nslcd_service,
  }

}
