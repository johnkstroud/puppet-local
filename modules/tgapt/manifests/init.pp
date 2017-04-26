#this is a class for apt configuration

class tgapt {
  # include 'apt::ubuntuapt'
  include apt

  file { '/etc/apt/sources.list.d/newrelic.list':
    ensure => present,
    source => 'puppet:///modules/tgapt/newrelic.list',
  }

  apt::key {'New Relic':
    ensure => present,
    id     => 'B60A3EC9BC013B9C23790EC8B31B29E5548C16BF',
    server => 'https://download.newrelic.com',
    source => 'https://download.newrelic.com/548C16BF.gpg',
  }

  file { '/etc/apt/sources.list.d/ubuntu-main.list':
    ensure => present,
    source => 'puppet:///modules/tgapt/ubuntu-main.list',
  }

}
