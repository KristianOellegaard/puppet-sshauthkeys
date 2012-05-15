define sshauthkeys::helper ($user,$ensure='present') {
        $ssh_keys = hiera_hash('ssh_keys')
        $name2=regsubst($name,"-${user}\$","")
	if has_key($ssh_keys["${name2}"], "ensure") {
		$ensurekey = $ssh_keys["${name2}"]["ensure"]
	} else {
		$ensurekey = $ensure
	}
        ssh_authorized_key { "puppet: ${name2} ${user}":
          ensure => $ensurekey,
          type => $ssh_keys["${name2}"]["type"],
          key => $ssh_keys["${name2}"]["key"],
          user => "${user}"
        }
}

