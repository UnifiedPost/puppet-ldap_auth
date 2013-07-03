# == Class: ldap_auth::config::debian
#
# Configures ldap authentication on debian
#
# === Todo:
#
# TODO: Fully support debian
# TODO: Change context for augeas stuff a bit (Use lens and proper context in onlyif)
#
class ldap_auth::config::debian {

  augeas{'pam_mkhomedir.so':
    context => '/files/etc/pam.d/common-session/100',
    changes => [
      'set type session',
      'set control required',
      'set module pam_mkhomedir.so',
      'set argument[1] umask=0022',
    ],
    onlyif  => 'get /files/etc/pam.d/common-session/*[module = "pam_mkhomedir.so"]/type != session',
  }

}
