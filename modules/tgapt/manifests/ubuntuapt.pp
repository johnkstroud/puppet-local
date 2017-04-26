# /etc/puppet/modules/topgolf/manifests/apt/ubuntuapt.pp
class apt::ubuntuapt {


	#OLD CODE FROM EXAMPLE42 APT MODULE
	#class { 'apt':
	#	purge_sources_list      =>      true,
	#	purge_sources_list_d    =>      true,
	#}

	#file { '/etc/apt/sources.list.d/ubuntu.list':
	#	ensure => present,
	#	source =>  'puppet:///modules/topgolf/topgolf.list',
	#}

	#class {'apt':
	#  purge => {'sources.list' => true,'sources.list.d' => true},
	#}

	if $os['distro']['codename'] == 'trusty' {
		file { '/etc/apt/sources.list.d/ubuntu-main.list':
			ensure => present,
			source => 'puppet:///modules/apt/ubuntu-main.list',
		}
	}

	apt::key {'topgolf':
		ensure => present,
		id     => '2FF98EDA23D704957612CC2D783E4026D4CB57C9',
		server => 'http://puppetmaster.colo1.topgolf.com',
		source => 'http://puppetmaster.colo1.topgolf.com/public.gpg',
	}

	apt::source {'topgolf':
			comment     => 'TopGolf Enterprise Internal repository',
			location    => 'http://puppetmaster.colo1.topgolf.com/',
			release     => '',
			repos       => './',
			include_src => false,
			require     => Apt_key['topgolf'],
	}

  apt::key {'New Relic':
	  ensure => present,
	  id     => 'B60A3EC9BC013B9C23790EC8B31B29E5548C16BF',
	  server => 'https://download.newrelic.com',
	  source => 'https://download.newrelic.com/548C16BF.gpg',
  }

}
