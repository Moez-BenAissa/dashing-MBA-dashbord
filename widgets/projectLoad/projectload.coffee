class Dashing.Projectload extends Dashing.Widget

  constructor: ->
    super
    @observe 'value', (value) ->
      $(@node).find(".meter").val(value).trigger('change')

  ready: ->
    meter = $(@node).find(".meter")
    meter.attr("data-bgcolor", meter.css("background-color"))
    meter.attr("data-fgcolor", meter.css("color"))
    meter.knob()

  onData: (data) ->
    node  = $(@node)
    value = parseInt data.project_load
    light = parseInt node.data "light"
    heavy = parseInt node.data "heavy"
    level = switch
      when value <= light  then 0
      when value >= heavy then 4
      else
        bucketSize = (heavy -  light ) / 3 # Total number of colours in middle
        Math.ceil (value -  light ) / bucketSize

    backgroundClass = "hotness#{level}"
    lastClass = @get "lastClass"
    node.toggleClass "#{lastClass} #{backgroundClass}"
    @set "lastClass", backgroundClass
