###
  Sets up slider for trending bills
###
class Whip.Slider
  constructor: (@el) ->
    # intialize some stuff

  render: ->
    # do some stuff
    @el.slick
      accessibility: true
      adaptiveHeight: true

$(document).on "page:change", ->
  slider = new Whip.Slider $(".trending_bills")
  slider.render()