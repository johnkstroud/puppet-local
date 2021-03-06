# Class: mediawiki
# ===========================
#
# Full description of class mediawiki here.
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `sample parameter`
# Explanation of what this parameter affects and what it defaults to.
# e.g. "Specify one or more upstream ntp servers as an array."
#
# Variables
# ----------
#
# Here you should define a list of variables that this module would require.
#
# * `sample variable`
#  Explanation of how this variable affects the function of this class and if
#  it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#  External Node Classifier as a comma separated list of hostnames." (Note,
#  global variables should be avoided in favor of class parameters as
#  of Puppet 2.6.)
#
# Examples
# --------
#
# @example
#    class { 'mediawiki':
#      servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#    }
#
# Authors
# -------
#
# Author Name <author@domain.com>
#
# Copyright
# ---------
#
# Copyright 2017 Your name here, unless otherwise noted.
#
class mediawiki {

  $wikisitename = hiera('mediawiki::wikisitename')
  $wikimetanamespace = hiera('mediawiki::wikimetanamespace')
  $wikiserver = hiera('mediawiki::wikiserver')
  $wikidbserver = hiera('mediawiki::wikidbserver')
  $wikidbname = hiera('mediawiki::wikidbname')
  $wikidbuser = hiera('mediawiki::wikidbuser')
  $wikidbpassword = hiera('mediawiki::wikidbpassword')
  $wikiupgradekey = hiera('mediawiki::wikiupgradekey')

  $phpmysql = $::osfamily ? {
    'redhat'  => 'php-mysql',
    'debian'  => 'php5-mysql',
    default   => 'php-mysql',
  }

  package { $phpmysql:
    ensure => 'present',
  }

  class { '::apache':
    docroot    => '/var/www/html',
    mpm_module => 'prefork',
    subscribe  => Package[$phpmysql],
  }

  class { '::apache::mod::php':}

  file { '/var/www/html/index.html':
    ensure => 'absent',
  }

  # file { '/etc/apache2/sites-enabled/15-default.conf':
  #  ensure => 'absent',
  # }

  vcsrepo { '/var/www/html':
    ensure   => present,
    provider => git,
    source   => 'https://github.com/wikimedia/mediawiki.git',
    revision => 'REL1_23',
    force    => true,
    user     => 'root',
    group    => 'root',
    owner    => 'root',
    # revision => 'master',
    # require  =>  Class['::apache']
  }

  File['/var/www/html/index.html'] -> Vcsrepo['/var/www/html']

  class { '::mysql::server':
    root_password => 'training',
  }

  file { 'LocalSettings.php':
    ensure  => 'file',
    path    => '/var/www/html/LocalSettings.php',
    content => template('mediawiki/LocalSettings.erb'),
  }

}
