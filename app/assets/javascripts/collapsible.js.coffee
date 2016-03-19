(($) ->

  $.fn.collapsible = (options) ->
    defaults = accordion: undefined
    options = $.extend(defaults, options)
    @each ->
      $this = $(this)
      $panel_headers = $(this).find('> li > .collapsible-header')
      collapsible_type = $this.data('collapsible')
      accordionOpen = (object) ->
        $panel_headers = $this.find('> li > .collapsible-header')
        if object.hasClass('active')
          object.parent().addClass 'active'
        else
          object.parent().removeClass 'active'
        if object.parent().hasClass('active')
          object.siblings('.collapsible-body').stop(true, false).slideDown
            duration: 350
            easing: 'easeOutQuart'
            queue: false
            complete: ->
              $(this).css 'height', ''
              return
        else
          object.siblings('.collapsible-body').stop(true, false).slideUp
            duration: 350
            easing: 'easeOutQuart'
            queue: false
            complete: ->
              $(this).css 'height', ''
              return
        $panel_headers.not(object).removeClass('active').parent().removeClass 'active'
        $panel_headers.not(object).parent().children('.collapsible-body').stop(true, false).slideUp
          duration: 350
          easing: 'easeOutQuart'
          queue: false
          complete: ->
            $(this).css 'height', ''
            return
        return

      expandableOpen = (object) ->
        if object.hasClass('active')
          object.parent().addClass 'active'
        else
          object.parent().removeClass 'active'
        if object.parent().hasClass('active')
          object.siblings('.collapsible-body').stop(true, false).slideDown
            duration: 350
            easing: 'easeOutQuart'
            queue: false
            complete: ->
              $(this).css 'height', ''
              return
        else
          object.siblings('.collapsible-body').stop(true, false).slideUp
            duration: 350
            easing: 'easeOutQuart'
            queue: false
            complete: ->
              $(this).css 'height', ''
              return
        return

      isChildrenOfPanelHeader = (object) ->
        panelHeader = getPanelHeader(object)
        panelHeader.length > 0

      getPanelHeader = (object) ->
        object.closest 'li > .collapsible-header'

      $this.off 'click.collapse', '> li > .collapsible-header'
      $panel_headers.off 'click.collapse'

      # Add click handler to only direct collapsible header children
      $this.on 'click.collapse', '> li > .collapsible-header', (e) ->
        `var $panel_headers`
        $header = $(this)
        element = $(e.target)
        if isChildrenOfPanelHeader(element)
          element = getPanelHeader(element)
        element.toggleClass 'active'
        if options.accordion or collapsible_type == 'accordion' or collapsible_type == undefined
          # Handle Accordion
          accordionOpen element
        else
          # Handle Expandables
          expandableOpen element
          if $header.hasClass('active')
            expandableOpen $header
        return
      # Open first active
      $panel_headers = $this.find('> li > .collapsible-header')
      if options.accordion or collapsible_type == 'accordion' or collapsible_type == undefined
        # Handle Accordion
        accordionOpen $panel_headers.filter('.active').first()
      else
        # Handle Expandables
        $panel_headers.filter('.active').each ->
          expandableOpen $(this)
          return
      return

  $(document).on 'turbolinks:load', ->
    $('.collapsible').collapsible()
    return
  return
) jQuery
# t: current time, b: begInnIng value, c: change In value, d: duration
jQuery.easing['jswing'] = jQuery.easing['swing']
jQuery.extend jQuery.easing,
  def: 'easeOutQuad'
  swing: (x, t, b, c, d) ->
    #alert(jQuery.easing.default);
    jQuery.easing[jQuery.easing.def] x, t, b, c, d
  easeInQuad: (x, t, b, c, d) ->
    c * (t /= d) * t + b
  easeOutQuad: (x, t, b, c, d) ->
    -c * (t /= d) * (t - 2) + b
  easeInOutQuad: (x, t, b, c, d) ->
    if (t /= d / 2) < 1
      return c / 2 * t * t + b
    -c / 2 * (--t * (t - 2) - 1) + b
  easeInCubic: (x, t, b, c, d) ->
    c * (t /= d) * t * t + b
  easeOutCubic: (x, t, b, c, d) ->
    c * ((t = t / d - 1) * t * t + 1) + b
  easeInOutCubic: (x, t, b, c, d) ->
    if (t /= d / 2) < 1
      return c / 2 * t * t * t + b
    c / 2 * ((t -= 2) * t * t + 2) + b
  easeInQuart: (x, t, b, c, d) ->
    c * (t /= d) * t * t * t + b
  easeOutQuart: (x, t, b, c, d) ->
    -c * ((t = t / d - 1) * t * t * t - 1) + b
  easeInOutQuart: (x, t, b, c, d) ->
    if (t /= d / 2) < 1
      return c / 2 * t * t * t * t + b
    -c / 2 * ((t -= 2) * t * t * t - 2) + b
  easeInQuint: (x, t, b, c, d) ->
    c * (t /= d) * t * t * t * t + b
  easeOutQuint: (x, t, b, c, d) ->
    c * ((t = t / d - 1) * t * t * t * t + 1) + b
  easeInOutQuint: (x, t, b, c, d) ->
    if (t /= d / 2) < 1
      return c / 2 * t * t * t * t * t + b
    c / 2 * ((t -= 2) * t * t * t * t + 2) + b
  easeInSine: (x, t, b, c, d) ->
    -c * Math.cos(t / d * Math.PI / 2) + c + b
  easeOutSine: (x, t, b, c, d) ->
    c * Math.sin(t / d * Math.PI / 2) + b
  easeInOutSine: (x, t, b, c, d) ->
    -c / 2 * (Math.cos(Math.PI * t / d) - 1) + b
  easeInExpo: (x, t, b, c, d) ->
    if t == 0 then b else c * 2 ** (10 * (t / d - 1)) + b
  easeOutExpo: (x, t, b, c, d) ->
    if t == d then b + c else c * (-2 ** (-10 * t / d) + 1) + b
  easeInOutExpo: (x, t, b, c, d) ->
    if t == 0
      return b
    if t == d
      return b + c
    if (t /= d / 2) < 1
      return c / 2 * 2 ** (10 * (t - 1)) + b
    c / 2 * (-2 ** (-10 * --t) + 2) + b
  easeInCirc: (x, t, b, c, d) ->
    -c * (Math.sqrt(1 - ((t /= d) * t)) - 1) + b
  easeOutCirc: (x, t, b, c, d) ->
    c * Math.sqrt(1 - ((t = t / d - 1) * t)) + b
  easeInOutCirc: (x, t, b, c, d) ->
    if (t /= d / 2) < 1
      return -c / 2 * (Math.sqrt(1 - (t * t)) - 1) + b
    c / 2 * (Math.sqrt(1 - ((t -= 2) * t)) + 1) + b
  easeInElastic: (x, t, b, c, d) ->
    `var s`
    `var s`
    s = 1.70158
    p = 0
    a = c
    if t == 0
      return b
    if (t /= d) == 1
      return b + c
    if !p
      p = d * .3
    if a < Math.abs(c)
      a = c
      s = p / 4
    else
      s = p / (2 * Math.PI) * Math.asin(c / a)
    -(a * 2 ** (10 * (t -= 1)) * Math.sin((t * d - s) * 2 * Math.PI / p)) + b
  easeOutElastic: (x, t, b, c, d) ->
    `var s`
    `var s`
    s = 1.70158
    p = 0
    a = c
    if t == 0
      return b
    if (t /= d) == 1
      return b + c
    if !p
      p = d * .3
    if a < Math.abs(c)
      a = c
      s = p / 4
    else
      s = p / (2 * Math.PI) * Math.asin(c / a)
    a * 2 ** (-10 * t) * Math.sin((t * d - s) * 2 * Math.PI / p) + c + b
  easeInOutElastic: (x, t, b, c, d) ->
    `var s`
    `var s`
    s = 1.70158
    p = 0
    a = c
    if t == 0
      return b
    if (t /= d / 2) == 2
      return b + c
    if !p
      p = d * .3 * 1.5
    if a < Math.abs(c)
      a = c
      s = p / 4
    else
      s = p / (2 * Math.PI) * Math.asin(c / a)
    if t < 1
      return -.5 * a * 2 ** (10 * (t -= 1)) * Math.sin((t * d - s) * 2 * Math.PI / p) + b
    a * 2 ** (-10 * (t -= 1)) * Math.sin((t * d - s) * 2 * Math.PI / p) * .5 + c + b
  easeInBack: (x, t, b, c, d, s) ->
    if s == undefined
      s = 1.70158
    c * (t /= d) * t * ((s + 1) * t - s) + b
  easeOutBack: (x, t, b, c, d, s) ->
    if s == undefined
      s = 1.70158
    c * ((t = t / d - 1) * t * ((s + 1) * t + s) + 1) + b
  easeInOutBack: (x, t, b, c, d, s) ->
    if s == undefined
      s = 1.70158
    if (t /= d / 2) < 1
      return c / 2 * t * t * (((s *= 1.525) + 1) * t - s) + b
    c / 2 * ((t -= 2) * t * (((s *= 1.525) + 1) * t + s) + 2) + b
  easeInBounce: (x, t, b, c, d) ->
    c - jQuery.easing.easeOutBounce(x, d - t, 0, c, d) + b
  easeOutBounce: (x, t, b, c, d) ->
    if (t /= d) < 1 / 2.75
      c * 7.5625 * t * t + b
    else if t < 2 / 2.75
      c * (7.5625 * (t -= 1.5 / 2.75) * t + .75) + b
    else if t < 2.5 / 2.75
      c * (7.5625 * (t -= 2.25 / 2.75) * t + .9375) + b
    else
      c * (7.5625 * (t -= 2.625 / 2.75) * t + .984375) + b
  easeInOutBounce: (x, t, b, c, d) ->
    if t < d / 2
      return jQuery.easing.easeInBounce(x, t * 2, 0, c, d) * .5 + b
    jQuery.easing.easeOutBounce(x, t * 2 - d, 0, c, d) * .5 + c * .5 + b
