class Dashing.Timelinevertical extends Dashing.Widget

  ready: ->
    @renderTimeline(@get('events'))

  onData: (data) ->
    # Handle incoming data
    # You can access the html node of this widget with `@node` E8F770 616161
    # Example: $(@node).fadeOut().fadeIn() will make the node flash each time data comes in.
    if data.events
        @renderTimeline(data.events)

  renderTimeline: (events) ->
    TimeKnots.draw(".timelinevertical", events, {horizontalLayout: false, color: "#222222", height: 600, width:300, showLabels: true, labelFormat:"%H:%M"});
