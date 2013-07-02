class ldap_auth::params (
  $packages      = undef,
  $server        = undef,
  $base          = undef,
  $binddn        = undef,
  $bindpw        = undef,
  $filter        = undef,
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
  ####     Config     ####
  ########################

  $_server = $server ? {
    undef   => 'localhost',
    default => $server,
  }

  $_base   = $base ? {
    undef   => '',
    default => $base,
  }

  $_binddn = $binddn ? {
    undef   => '',
    default => $binddn,
  }

  $_bindpw = $bindpw ? {
    undef   => '',
    default => $bindpw,
  }

  $_filter = $filter ? {
    undef   => '',
    default => $filter,
  }

  $_ssl = $ssl ? {
    true    => 'yes',
    default => 'no',
  }

  ########################
  ####    Service     ####
  ########################

  $_nslcd_service = $nslcd_service ? {
    undef   => 'nslcd',
    default => $nslcd_service,
  }

}
