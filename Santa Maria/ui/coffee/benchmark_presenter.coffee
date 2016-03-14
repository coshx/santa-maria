class BenchmarkPresenter extends BasePresenter

  class Watcher
    constructor: (bus, streamSize, maxGraph, barSelector, dataRange = []) ->
      @bus = bus
      @streamSize = streamSize
      @maxGraph = maxGraph
      @watchers = []
      @cursor = 0
      @barSelector = barSelector
      @dataRange = dataRange
      @whenDone = null

      for i in [0...@streamSize]
        do (i) =>
          @bus.register "Event-#{i}", () =>
            @watchers[i].end = performance.now()
            @cursor++
            if @cursor is @streamSize
              @updateBar()
              @watchers = []
              @cursor = 0
              @whenDone()

    updateBar: () ->
      avg = 0
      avg += (e.end - e.start) for e in @watchers
      avg /= @streamSize
      h = Math.round(avg / @maxGraph * 100)
      bar = $(@barSelector)

      if h < 50
        bar.removeClass 'medium high extreme'
      else if h >= 50 && h < 70
        bar.removeClass 'high extreme'
        bar.addClass 'medium'
      else if h >= 70 && h < 90
        bar.removeClass 'medium extreme'
        bar.addClass 'high'
      else if h >= 90
        bar.removeClass 'medium high'
        bar.addClass 'extreme'

      bar.css 'height', "#{h}%"
      bar.find('.js-value').text Math.round(avg)

    run: (whenDone) ->
      @whenDone = whenDone
      for i in [0...@streamSize]
        do (i) =>
          @watchers[i] =
            "start": performance.now()
            "end": performance.now()

          eventName = "Event-#{i}"
          if @dataRange.length > 0
            index = Math.floor(Math.random() * @dataRange.length)
            @bus.post(eventName, @dataRange[index])
          else
            @bus.post(eventName)

  onCreate: () ->
    @bus = Caravel.get("Benchmark")

    @streamSize = 100
    @maxGraph = 150

    @currentWatcher = 0
    @watchers = [
      new Watcher(Caravel.get("NoData"), @streamSize, @maxGraph, ".js-no-data-bar"),
      new Watcher(Caravel.get("String"), @streamSize, @maxGraph, ".js-string-bar",
        ["Robert de Niro", "Gabriel Byrne", "Kevin Spacey"])
      new Watcher(Caravel.get("Array"), @streamSize, @maxGraph, ".js-array-bar", [[0..50], [50..100], [100..150]]),
      new Watcher(Caravel.get("Dictionary"), @streamSize, @maxGraph, ".js-dictionary-bar", DICTIONARIES)
      new Watcher(Caravel.get("Complex"), @streamSize, @maxGraph, ".js-complex-bar", COMPLEX_OBJECTS)
    ]

    @bus.register "Ready", () =>
      @watchers[@currentWatcher].run () => @whenDone()

    @bus.post("StreamSize", @streamSize)

  whenDone: () ->
    @currentWatcher = (@currentWatcher + 1) % @watchers.length
    setTimeout (() => @watchers[@currentWatcher].run(() => @whenDone())), 100

