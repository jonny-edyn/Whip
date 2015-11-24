###
  Sets up masonry and infinite scroll for common bills
###
class Whip.InfiniteBricks
  constructor: (@el) ->
    # intialize some stuff

  render: ->
    # do some stuff
    @el.masonry
      itemSelector : '.masonary_sizing'
    @el.infinitescroll {
      navSelector: 'nav.pagination'
      nextSelector: 'nav.pagination a[rel=next]'
      itemSelector: '.masonary_sizing'
      debug: true
    }, (newElements) ->
      $newElems = $(newElements)
      $('#hold_common_bills').masonry 'appended', $newElems

$(document).on "page:change", ->
  return unless $("body.bills.index").length > 0 || $("body.issues.find_issues").length > 0
  bricks = new Whip.InfiniteBricks $('#hold_common_bills')
  bricks.render()