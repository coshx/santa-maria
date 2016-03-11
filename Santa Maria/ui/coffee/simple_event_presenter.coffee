class SimpleEventPresenter extends BasePresenter
  onCreate: () ->
    @receiver = $('.js-receiver')
    @emitter = $('.js-emitter')

    @emitter.on 'tapstart', () => @emitter.addClass('active')

    @emitter.on 'tapend', () =>
      @emitter.removeClass('active')
      @receiver.addClass 'active'
      setTimeout (() => @receiver.removeClass('active')), 300