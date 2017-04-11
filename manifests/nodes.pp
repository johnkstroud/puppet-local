node 'puppetagent-vagrant.topgolfusa.com' {
  class { 'linux':}

}

class linux {

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

  package { 'ntp':
    ensure => 'installed',
  }

  service { $ntpservice:
    ensure => running,
    enable => true,
  }
}
# node 'wikitest' {

# }
