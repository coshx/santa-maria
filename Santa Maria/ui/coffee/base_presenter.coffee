class BasePresenter
  constructor: () ->
    $(document).ready () => @onCreate()

  onCreate: () ->

  addHoldEffect: (e) ->
    e.on 'tapstart', () => e.addClass('active')
    e.on 'tapend', () => e.removeClass('active')

  pulse: (e) ->
    e.addClass 'active'
    setTimeout (() => e.removeClass('active')), 300