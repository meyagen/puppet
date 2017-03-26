node default {

  # test puppet
  include cron-puppet
  include create-test-file
  
  # update apt-get
  include update-apt

  # setup postgres
  class { 'postgresql::globals':
    version             => '9.5',
    manage_package_repo => true,
  }

  class { 'postgresql::server': }

  postgresql::server::role { 'kickstarter':
    password_hash => postgresql_password('kickstarter', 'k!ckst@rt3r'),
    createdb => true,
  }

  postgresql::server::database_grant { 'kickstarter':
    privilege => 'ALL',
    db        => 'kickstarter',
    role      => 'kickstarter',
  }

  postgresql::server::db { 'kickstarter':
    user     => 'kickstarter',
    password => postgresql_password('kickstarter', 'k!ckst@rt3r'),
  }

  postgresql::server::pg_hba_rule { 'local access to kickstarter':
    type        => 'local',
    database    => 'kickstarter',
    user        => 'kickstarter',
    auth_method => 'md5',
  }

  # setup rbenv and ruby
  class { 'rbenv':
    latest => true,
  }

  rbenv::plugin { 'rbenv/ruby-build': }

  rbenv::build { '2.3.1':
    global => true,
  }

  rbenv::gem { 'rails':
    ruby_version => '2.3.1',
  }

  # clone project repo
  vcsrepo { '/var/www/idea-kickstarter':
    ensure   => latest,
    provider => git,
    source   => 'https://github.com/meyagen/idea-kickstarter.git',
    revision => 'master',
  }

  # setup project
  include kickstarter
  include nginx
}
