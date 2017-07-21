class Dashing.Number extends Dashing.Widget
  @accessor 'current', Dashing.AnimatedValue

  @accessor 'difference-rate', ->
    "#{@get('difference')}%"
    # if @get('last')
    #   last = parseInt(@get('last'))
    #   current = parseInt(@get('current'))
    #   if last != 0
    #     diff = Math.abs(Math.round((current - last) / last * 100))
    #     "#{diff}%"
    # else
    #   ""

  @accessor 'arrow', ->
    # if @get('last')
    #   if parseInt(@get('current')) > parseInt(@get('last')) then 'fa fa-arrow-up' else 'fa fa-arrow-down'
      if @get('difference')
        if parseInt(@get('difference')) > 0 then 'fa fa-arrow-up' else 'fa fa-arrow-down'


  @accessor 'widget-container', ->
    if @get('current')
      if parseInt(@get('current')) < 10 then 'green-screen' else
        if parseInt(@get('current')) < 20 then 'orange-screen' else 'red-screen'


  onData: (data) ->
    if data.status
      # clear existing "status-*" classes
      $(@get('node')).attr 'class', (i,c) ->
        c.replace /\bstatus-\S+/g, ''
      # add new class
      $(@get('node')).addClass "status-#{data.status}"
