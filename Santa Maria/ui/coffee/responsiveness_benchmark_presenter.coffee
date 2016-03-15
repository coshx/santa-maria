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

    @postEventNumber()

  postEventNumber: () ->
    n = parseInt(@eventNumberRange.val())
    clearTimeout(@delayTimer) if @delayTimer?
    @delayTimer = setTimeout (() => @bus.post('EventNumber', n)), 300
