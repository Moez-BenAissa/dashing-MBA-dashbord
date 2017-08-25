class Dashing.Timelinehorizontal extends Dashing.Widget

  ready: ->
    @renderTimeline(@get('events'))

  onData: (data) ->
    # Handle incoming data
    # You can access the html node of this widget with `@node` E8F770 616161
    # Example: $(@node).fadeOut().fadeIn() will make the node flash each time data comes in.
    if data.events
        @renderTimeline(data.events)

  renderTimeline: (events) ->
    TimeKnots.draw(".timelinehorizontal", events, {horizontalLayout: true, color: "#222222", height: 280, width:1400, showLabels: true, labelFormat:"%H:%M"});
