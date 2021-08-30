# == Class: mackerel_agent::config
#
class mackerel_agent::config(
  $ensure             = present,
  $apikey             = undef,
  $roles              = undef,
  $host_status        = undef,
  $ignore_filesystems = undef,
  $metrics_plugins    = {},
  $check_plugins      = {}
) {

  if $ensure == absent or $ensure == purged {
    $directory_ensure = absent
  } else {
    $directory_ensure = directory
  }

  file { '/etc/mackerel-agent/conf.d':
    ensure  => $directory_ensure,
    require => Package['mackerel-agent']
  }

  file { 'mackerel-agent.conf':
    ensure  => $ensure,
    path    => '/etc/mackerel-agent/mackerel-agent.conf',
    content => template('mackerel_agent/mackerel-agent.conf.erb'),
    notify  => Class['mackerel_agent::service']
  }
}
