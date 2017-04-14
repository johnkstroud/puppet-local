node 'puppetagent-vagrant.topgolfusa.com' {
  heira_include('classes')
  # class { 'linux':}
  # class { 'mediawiki':}
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
