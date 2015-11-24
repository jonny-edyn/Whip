###
  Sets Active Nav Class
###
class Whip.ActiveNav
  constructor: (@el) ->
    @pathname = $(location).prop('pathname').split('/')[1]
    @best_distance = 999
    @best_match = false
    @overlap_penalty = 999

  filterEach: ->
    @el.each (index, element) =>
      if $(element).attr('href').indexOf(@pathname) >= 0
        @overlap_penalty = @pathname.replace($(element).attr('href'), '').length
        if @overlap_penalty < @best_distance
          @best_distance = @overlap_penalty
          @best_match = element

  render: ->
    $(@best_match).closest('.nav-parent-item').addClass('active')

  renderAdmin: ->
    adminMatch = (link for link in @el when link.href == window.location.href)
    $(adminMatch).parent().addClass('active')

$(document).on "page:change", ->
  mainNav = new Whip.ActiveNav $("#top-navbar ul.nav a")
  mainNav.filterEach()
  mainNav.render()
  adminNav = new Whip.ActiveNav $("#admin-sidebar ul.nav a")
  adminNav.renderAdmin()