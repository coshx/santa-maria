class TwoEventsPresenter extends BasePresenter
  onCreate: () ->
    @bus = Caravel.get "TwoEvents"
    @cursor = true

    @emitter = $('.js-emitter')
    @receiver1 = $('.js-receiver-1')
    @receiver2 = $('.js-receiver-2')

    @addHoldEffect(@emitter)

    @bus.register "C", () => @pulse(@receiver1)
    @bus.register "D", () => @pulse(@receiver2)

    @emitter.on 'tapend', () =>
      e = if @cursor then "A" else "B"
      @cursor = !@cursor
      @bus.post e