class LandingPresenter extends BasePresenter
  onCreate: () ->
    @bus = Caravel.get("Landing")

    $('.js-slideshow').on 'click', () => @bus.post("Slideshow")

    $('.js-duration-benchmark').on 'click', () => @bus.post("DurationBenchmark")