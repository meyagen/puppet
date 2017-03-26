class kickstarter {
  exec { 'install-gems':
    cwd     => '/var/www/idea-kickstarter',
    command => '/usr/local/rbenv/shims/bundle install',
  }

  exec { 'setup-db':
    cwd     => '/var/www/idea-kickstarter',
    command => '/usr/local/rbenv/shims/rake db:setup',
  }
}

