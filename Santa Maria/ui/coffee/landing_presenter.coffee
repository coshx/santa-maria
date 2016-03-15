class LandingPresenter extends BasePresenter
  onCreate: () ->
    super
    @bus = Caravel.get("Landing")

    $('.js-slideshow').on 'click', () => @bus.post("Slideshow")

    $('.js-time-benchmark').on 'click', () => @bus.post("TimeBenchmark")

    $('.js-responsiveness-benchmark').on 'click', () => @bus.post("ResponsivenessBenchmark")