class SimpleEventPresenter extends BasePresenter
  onCreate: () ->
    @bus = Caravel.get("SimpleEvent")
    @receiver = $('.js-receiver')
    @emitter = $('.js-emitter')

    @addHoldEffect @emitter

    @bus.register "Received", () => @pulse(@receiver)

    @emitter.on 'tapend', () => @bus.post("Send")