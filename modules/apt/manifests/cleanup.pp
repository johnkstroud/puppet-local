# class topgolf::apt::cleanup {
# 	exec {'remove old apt stuff':
# 			command	=>	'/usr/bin/touch /tmp/tony; /bin/rm /var/lib/apt/lists/*;/bin/rm /var/lib/apt/lists/partial/\*;/usr/bin/apt-get clean;/usr/bin/apt-get update',
# 			onlyif => '/usr/bin/test -e /var/lib/apt/lists/us.archive.ubuntu.com_ubuntu_dists_precise_Release',
# 		}
# }

class apt::cleanup {
	exec {'remove old apt stuff':
	command	=>	'/usr/bin/touch /tmp/tony; /bin/rm /var/lib/apt/lists/*;/bin/rm /var/lib/apt/lists/partial/\*;/usr/bin/apt-get clean;/usr/bin/apt-get update',
	onlyif => '/usr/bin/test -e /var/lib/apt/lists/us.archive.ubuntu.com_ubuntu_dists_precise_Release',
  }
}
