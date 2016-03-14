class TwoBusesPresenter extends BasePresenter
  onCreate: () ->
    @bus1 = Caravel.get("TwoBuses-1")
    @bus2 = Caravel.get("TwoBuses-2")

    @emitter1 = $('.js-emitter-1')
    @emitter2 = $('.js-emitter-2')
    @receiver1 = $('.js-receiver-1')
    @receiver2 = $('.js-receiver-2')

    @bus1.register "Received", () => @pulse(@receiver1)

    @bus2.register "Received", () => @pulse(@receiver2)

    @addHoldEffect(@emitter1)
    @addHoldEffect(@emitter2)

    @emitter1.on 'tapend', () => @bus1.post("Send")

    @emitter2.on 'tapend', () => @bus2.post("Send")