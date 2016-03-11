class MultipleSubscribersPresenter extends BasePresenter
  onCreate: () ->
    @bus = Caravel.get("MultipleSubscribers")
    @receiver1 = $('.js-receiver-1')
    @receiver2 = $('.js-receiver-2')
    @receiver3 = $('.js-receiver-3')
    @emitter = $('.js-emitter')

    @addHoldEffect(@emitter)

    @bus.register "Received", () => @pulse(@receiver1)

    @bus.register "Received", () => @pulse(@receiver2)

    @bus.register "Received", () => @pulse(@receiver3)

    @emitter.on 'tapend', () => @bus.post("Send")