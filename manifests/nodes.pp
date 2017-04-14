node 'puppetagent-vagrant.topgolfusa.com' {

  $wikisitename = 'test'
  $wikimetanamespace = 'Test'
  $wikiserver = 'http://192.168.1.202'
  $wikidbserver = 'localhost'
  $wikidbname = 'my_wiki'
  $wikidbuser = 'root'
  $wikidbpassword = 'training'
  $wikiupgradekey = 'f83d424825a76b80'

  class { 'linux':}
  class { 'mediawiki':}

}

# install admin tools
class linux {

  $admintools = ['git','nano','screen']

  $ntpservice = $::osfamily ? {
    'redhat'  => 'ntpd',
    'debian'  => 'ntp',
    default   => 'ntp',
  }

  $ntppackage = $::osfamily ? {
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
