class ResponsivenessBenchmarkPresenter extends BasePresenter
  onCreate: () ->
    @bus = Caravel.get("ResponsivenessBenchmark")

    @bus.register 'Event', (name, data) =>
      @bus.post(name, data)

    @eventNumberRange = $('.js-event-number')
    @eventNumberValue = $('.js-event-number-label')

    @eventComplexityRange = $('.js-event-complexity')
    @eventComplexityValue = $('.js-event-complexity-label')

    @eventNumberRange.on 'change input', () =>
      @eventNumberValue.text @eventNumberRange.val()
      @postEventNumber()

    @eventComplexityRange.on 'change input', () =>
      @eventComplexityValue.text @eventComplexityRange.val()
      @postEventComplexity()

    @postEventNumber()
    @postEventComplexity()

  postEventNumber: () ->
    n = parseInt(@eventNumberRange.val())
    clearTimeout(@postEventNumberTimer) if @postEventNumberTimer?
    @postEventNumberTimer = setTimeout (() => @bus.post('EventNumber', n)), 500

  postEventComplexity: () ->
    n = parseInt(@eventComplexityRange.val())
    clearTimeout(@postEventComplexityTimer) if @postEventComplexityTimer?
    @postEventComplexityTimer = setTimeout (() => @bus.post("EventComplexity", n)), 500
