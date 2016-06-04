# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# swipePage = ->
  # $('section').append($('a'));
  # $('body').addClass("loaded")
  # $('section').attr("aria-selected", true)
  # true
# $(document).ready swipePage
# $(document).on 'page:load', swipePage
#
$ ->
  $(document).on 'ajax:success', 'a[data-remote]', (e, data, status, xhr) ->
    $('section').text(data)
    $('section').addClass(data)
  # $("a[data-remote]").on "ajax:success", (e, data, status, xhr) ->
  #   alert "data"
# $ ->
#   $('a').bind('ajax:success', function(){
#     alert("Success!");
#   });

# $ ->
#   $.ajaxSetup
#     cache: false
#
#   addBottomLinks()
#   $(window).on 'scroll', addBottomLinks
#
  # $(document).on 'ajax:success', 'a[data-remote]', (e, data, status, xhr) ->
  #   $('section').removeClass()
  #   $('section').addClass(data)
#
#   $(document).on 'keypress', (e) ->
#     did = $(".present").attr('data-id')
#     return if typeof did == "undefined"
#
#     slide = parseInt($(".present").attr('data-slide'), 10)
#     count = parseInt($(".present").attr('data-count'), 10)
#
#     if e.which is 32 or e.keyCode is 39 or e.keyCode is 40 or e.keyCode is 34
#       if slide < count - 1
#         window.location.href = "/presentations/#{did}/#{slide+1}/show"
#     if e.keyCode is 37 or e.keyCode is 38 or e.keyCode is 33
#       if slide > 0
#         window.location.href = "/presentations/#{did}/#{slide-1}/show"
#     if e.which is 110 or e.which is 78
#         $("#next-slide").removeClass('next-slide')
#
#   setInterval (->
#     elem = $(".stud-next-slide")
#     presentation = elem.data('presentation-id')
#     return if typeof presentation == "undefined"
#     slide = elem.data('slide')
#     $.ajax "/reload",
#       data:
#         id: presentation
#         slide: slide
#       success: (data, textStatus, jqXHR) ->
#          if data['text'] == 'yes'
#            $(".stud-next-slide").removeClass('stud-next-slide')
#      ), 10000
#
# addBottomLinks = ->
#   if $(window).scrollTop() > 0
#     $('.slide-bottom').removeAttr('style')
