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

  if $ensure == present {
    $directory_ensure  = directory
    $directory_recurse = false
    $directory_force   = false
  } else {
    $directory_ensure  = absent
    $directory_recurse = true
    $directory_force   = true
  }

  file { '/etc/mackerel-agent/conf.d':
    ensure  => $directory_ensure,
    recurse => $directory_recurse,
    force   => $directory_force,
    require => Package['mackerel-agent']
  }

  file { 'mackerel-agent.conf':
    ensure  => $ensure,
    path    => '/etc/mackerel-agent/mackerel-agent.conf',
    content => template('mackerel_agent/mackerel-agent.conf.erb'),
    notify  => Class['mackerel_agent::service']
  }
}
