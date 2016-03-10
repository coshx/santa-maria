class SimpleEventPresenter extends BasePresenter
  onCreate: () ->
    @receiver = $('.js-receiver')
    $('.js-emitter').on 'click', () =>
      @receiver.addClass 'active'
      setTimeout (() => @receiver.removeClass('active')), 300