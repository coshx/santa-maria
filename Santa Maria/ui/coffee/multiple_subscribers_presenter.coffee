class MultipleSubscribersPresenter extends BasePresenter
  onCreate: () ->
    @bus = Caravel.get("MultipleSubscribers")
    @receiver1 = $('.js-receiver-1')
    @receiver2 = $('.js-receiver-2')
    @receiver3 = $('.js-receiver-3')
    @emitter = $('.js-emitter')

    @emitter.on 'tapstart', () => @emitter.addClass('active')

    @bus.register "Received", () =>
      @receiver1.addClass 'active'
      setTimeout (() => @receiver1.removeClass('active')), 300

    @bus.register "Received", () =>
      @receiver2.addClass 'active'
      setTimeout (() => @receiver2.removeClass('active')), 300

    @bus.register "Received", () =>
      @receiver3.addClass 'active'
      setTimeout (() => @receiver3.removeClass('active')), 300

    @emitter.on 'tapend', () =>
      @emitter.removeClass('active')
      @bus.post("Send")