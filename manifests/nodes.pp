node 'puppetagent-vagrant.topgolfusa.com' {
  file { '/info.txt':
    ensure  => 'present',
    content => inline_template("Created by Puppet at <%= Time.now %>\n")
  }
}

# node 'wikitest' {

# }
