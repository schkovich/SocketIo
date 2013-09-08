stage { 'first':
  before => Stage['main'],
}

stage { 'last': }

Stage['main'] -> Stage['last']

node 'socketio.schkovich.local' {

  class {'ssh':
    stage => first,
  }


  class { 'setcaps':
    stage => first
  }

  class {'nodejs':
    stage => first,
  }
  ->
  exec { "set_capability":
    # Open ports bellow 1024
    command => "/sbin/setcap cap_net_bind_service=+ep /usr/bin/nodejs",
    provider => shell,
  }

}
