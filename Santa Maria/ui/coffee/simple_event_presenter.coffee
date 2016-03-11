class SimpleEventPresenter extends BasePresenter
  onCreate: () ->
    @bus = Caravel.get("SimpleEvent")
    @receiver = $('.js-receiver')
    @emitter = $('.js-emitter')

    @emitter.on 'tapstart', () => @emitter.addClass('active')

    @bus.register "Received", () =>
      @receiver.addClass 'active'
      setTimeout (() => @receiver.removeClass('active')), 300

    @emitter.on 'tapend', () =>
      @emitter.removeClass('active')
      @bus.post("Send")