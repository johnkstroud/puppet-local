class topgolf::apt::nodejs {
	apt::source { 'nodejs':
		comment     =>  'Chris Lea Nodejs repository',
		location    =>  'http://ppa.launchpad.net/chris-lea/node.js/ubuntu',
		repos       =>  'main',
		include_src =>  true,
		key		      =>	'C7917B12',
	}
}
