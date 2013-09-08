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

  class  {'schkovich::nodejs':
    stage => last,
  }

}
