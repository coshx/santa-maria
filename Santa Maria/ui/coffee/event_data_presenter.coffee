class EventDataPresenter extends BasePresenter
  onCreate: () ->
    @bus = Caravel.get("EventData")

    @crossReceiver = $('.js-cross-receiver')
    @circleReceiver = $('.js-circle-receiver')
    @triangleReceiver = $('.js-triangle-receiver')
    @squareReceiver = $('.js-square-receiver')

    @crossEmitter = $('.js-cross-emitter')
    @circleEmitter = $('.js-circle-emitter')
    @triangleEmitter = $('.js-triangle-emitter')
    @squareEmitter = $('.js-square-emitter')

    @addHoldEffect(@crossEmitter)
    @addHoldEffect(@circleEmitter)
    @addHoldEffect(@triangleEmitter)
    @addHoldEffect(@squareEmitter)

    @bus.register "Cross", () => @pulse(@crossReceiver)
    @bus.register "Circle", () => @pulse(@circleReceiver)
    @bus.register "Triangle", () => @pulse(@triangleReceiver)
    @bus.register "Square", () => @pulse(@squareReceiver)

    @crossEmitter.on 'tapend', () => @bus.post("Cross", 42)
    @circleEmitter.on 'tapend', () => @bus.post("Circle", "Francis Ford Coppola")
    @triangleEmitter.on 'tapend', () => @bus.post("Triangle", [1, 2, 3, 5, 8])
    @squareEmitter.on 'tapend', () => @bus.post("Square", {"name": "Bob", age: 71})