node 'puppetagent-vagrant.topgolfusa.com' {
  class { 'linux':}
  class { 'mediawiki':}

  vcsrepo { '/var/www/html':
    ensure   => latest,
    provider => git,
    source   => 'git://github.com/wikimedia/mediawiki.git',
    revision => 'REL1_23',
  }

}

class linux {

  $admintools = ['git','nano','screen']

  $ntpservice = $osfamily ? {
    'redhat'  => 'ntpd',
    'debian'  => 'ntp',
    default   => 'ntp',
  }

  $ntppackage = $osfamily ? {
    'redhad' => 'ntpd',
    'devian' => 'ntp',
    default   => 'ntp',
  }

  file { '/info.txt':
    ensure  => 'present',
    content => inline_template("Created by Puppet at <%= Time.now %>\n"),
  }

  package { $admintools:
    ensure => 'installed',
  }

  service { $ntpservice:
    ensure => running,
    enable => true,
  }
}
# node 'wikitest' {

# }
