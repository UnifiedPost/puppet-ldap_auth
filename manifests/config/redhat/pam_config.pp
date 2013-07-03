define ldap_auth::config::redhat::pam_config() {

  Augeas {
    lens => 'Pam.lns',
    incl => "/etc/pam.d/${name}",
  }

  augeas {"ldap_auth::config-pam-${name}_auth":
    changes => [
      'ins 01 before *[type = "auth"][module = "pam_deny.so"]',
      'set 01/type auth',
      'set 01/control sufficient',
      'set 01/module pam_ldap.so',
      'set 01/argument use_first_pass',
    ],
    onlyif => 'get *[type = "auth"][module = "pam_ldap.so"][argument = "use_first_pass"]/type != auth',
  }

  augeas {"ldap_auth::config-pam-${name}_account_broken_shadow":
    changes => [
      'set *[type = "account"][control = "required"][module = "pam_unix.so"]/argument broken_shadow',
    ],
  }

  augeas {"ldap_auth::config-pam-${name}_account":
    changes => [
      'ins 01 before *[type = "account"][control = "required"][module = "pam_permit.so"]',
      'set 01/type account',
      'set 01/control "[default=bad success=ok user_unknown=ignore]"',
      'set 01/module pam_ldap.so',
    ],
    onlyif => 'get *[type = "account"][control = "[default=bad success=ok user_unknown=ignore]"][module = "pam_ldap.so"]/type != account',
  }

  augeas {"ldap_auth::config-pam-${name}_password":
    changes => [
      'ins 01 before *[type = "password"][control = "required"][module = "pam_deny.so"]',
      'set 01/type password',
      'set 01/control sufficient',
      'set 01/module pam_ldap.so',
      'set 01/argument use_authtok',
    ],
    onlyif => 'get *[type = "password"][control = "sufficient"][module = "pam_ldap.so"][argument = "use_authtok"]/type != password',
  }

  augeas {"ldap_auth::config-pam-${name}_session_pam_mkhomedir":
    changes => [
      'ins 01 after *[type = "session"][control = "required"][module = "pam_limits.so"]',
      'set 01/type session',
      'set 01/control optional',
      'set 01/module pam_mkhomedir.so',
    ],
    onlyif => 'get *[type = "session"][control = "optional"][module = "pam_mkhomedir.so"]/type != session',
  }

  augeas {"ldap_auth::config-pam-${name}_session_pam_ldap":
    changes => [
      'ins 01 after *[type = "session"][last()]',
      'set 01/type session',
      'set 01/control optional',
      'set 01/module pam_ldap.so',
    ],
    onlyif => 'get *[type = "session"][control = "optional"][module = "pam_ldap.so"]/type != session',
  }
}
