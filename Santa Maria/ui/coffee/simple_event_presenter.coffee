class SimpleEventPresenter extends BasePresenter
  onCreate: () ->
    @bus = Caravel.get("SimpleEvent")
    @receiver = $('.js-receiver')
    @emitter = $('.js-emitter')

    @addHoldEffect @emitter

    @bus.register "Received", () =>
      console.log(performance.now() - @d1)
      @pulse(@receiver)
      @d1 = performance.now()

    @emitter.on 'tapend', () =>
      @d1 = performance.now()
      @bus.post("Send")