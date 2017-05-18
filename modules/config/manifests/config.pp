file { '/etc/puppet/puppet.conf':
  ensure  => file,
  content => template('config/puppet.erb'),
}
