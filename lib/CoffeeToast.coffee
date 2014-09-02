class @CoffeeToast
  # Public: Different positions
  @Top: "top"
  @Right: "right"
  @Bottom: "bottom"
  @Left: "left"

  # Public: Timescales for hiding a toast element
  @Slow: 4000
  @Fast: 2500

  # Private: Timer for hiding elements
  _timer: ""

  # Private: Spacing between toast elements
  _spacing: 15

  # Public: Constructor method called on init
  #
  # @text - Text to display in toast (Limited to 70 chars)
  # @position - Position of the Toast (top, right, bottom, left)
  #
  # Returns itself
  constructor: (@text, @position = "bottom") ->
    # Truncate the text if more than 70 chars
    if @text.length > 70
      @text = "#{@text.substring(0, 70)}..."

    # Create the holding box
    @createHoldingBox()
    @addTextBox()

    # Add event listener
    @addClickEvent()

  # Internal: Create toast holding box
  createHoldingBox: ->
    # Create div
    div = document.createElement "div"
    div.className = "coffee-toast coffee-toast-shown coffee-toast-#{@position}"

    # Set some styles
    div = @addCss div,
      background: "black"
      background: "rgba(0, 0, 0, 0.8)"
      maxWidth: "200px"
      minWidth: "60px"
      padding: "7px 12px"
      display: "inline-block"
      color: "#fff"
      fontFamily: "Arial, sans-serif"
      position: "fixed"
      boxShadow: "0px 2px 4px rgba(0, 0, 0, 0.4)"
      fontSize: "13px"
      borderRadius: "3px"
      cursor: "pointer"
      textAlign: "center"
      lineHeight: "1.5em"
      opacity: "0"
      webkitTransition: "all 0.17s ease-in"
      mozTransition: "all 0.17s ease-in"
      oTransition: "all 0.17s ease-in"
      transition: "all 0.17s ease-in"

    @holdingBox = div

  # Internal: Position the holding box based on the position specified
  #           Uses position fixed to put in correct position and keep it there
  #           Available positions are:
  #             - Top
  #             - Right
  #             - Bottom
  #             - Left
  positionHoldingBox: ->
    css = {}

    # Decide what CSS to add
    switch @position
      when "left"
        # Move the top based on how many there are
        top = -(@holdingBox.offsetHeight / 2)

        # Get the last current tosat box at the bottom
        els = document.querySelectorAll(".coffee-toast-left")
        lastEl = els[els.length - 2]

        if lastEl
          top = parseInt(lastEl.style.marginTop) + lastEl.offsetHeight + @_spacing

        css =
          left: "15px"
          top: "50%"
          marginTop: "#{top}px"
      when "right"
        # Move the top based on how many there are
        top = -(@holdingBox.offsetHeight / 2)

        # Get the last current tosat box at the bottom
        els = document.querySelectorAll(".coffee-toast-right")
        lastEl = els[els.length - 2]

        if lastEl
          top = parseInt(lastEl.style.marginTop) + lastEl.offsetHeight + @_spacing

        css =
          right: "15px"
          top: "50%"
          marginTop: "#{top}px"
      when "top"
        # Move the top based on how many there are
        top = 40

        # Get the last current tosat box at the bottom
        els = document.querySelectorAll(".coffee-toast-top")
        lastEl = els[els.length - 2]

        if lastEl
          top = (lastEl.offsetTop + lastEl.offsetHeight) + @_spacing

        css =
          top: "#{top}px"
          left: "50%"
          marginLeft: "-#{(@holdingBox.offsetWidth / 2)}px"
      when "bottom"
        # Move the bottom based on how many there are
        bottom = 60

        # Get the last current tosat box at the bottom
        els = document.querySelectorAll(".coffee-toast-bottom")
        lastEl = els[els.length - 2]

        if lastEl
          bottom = (parseInt(lastEl.style.bottom) + lastEl.offsetHeight) + @_spacing

        css =
          bottom: "#{bottom}px"
          left: "50%"
          marginLeft: "-#{(@holdingBox.offsetWidth / 2)}px"


    # Add the CSS
    @addCss @holdingBox, css

  # Internal: Add text box
  addTextBox: ->
    # Create span tag for text
    span = document.createElement "span"
    span.className = "coffee-toast coffee-toast-text"
    span.textContent = @text

    @holdingBox.appendChild span

  # Public: Show the toast box
  #
  # time - How long it should be visible for. Default to 1500ms
  # remove - Should it be removed automatically?
  #
  # Returns itself for easy chaining!
  show: (time = 1500, remove = false) ->
    # Add to the body before showing
    document.body.appendChild @holdingBox

    # Position the element
    @positionHoldingBox()

    # Show element
    @addCss @holdingBox,
      opacity: "1"

    # Hide interval
    clearTimeout @_timer
    @_timer = setTimeout =>
      @hide remove
    , (time + 200)

    return @

  # Public: Hide the toast box!
  #
  # remove - Boolean to say whether it should be removed or not.
  #          Defaults to false
  #
  # Returns itself for easy chaining!
  hide: (remove = false) =>
    clearTimeout @_timer

    # Hide element
    @addCss @holdingBox,
      opacity: "0"

    # Are there more elements with this position?
    els = document.querySelectorAll(".coffee-toast-#{@position}")

    switch @position
      when "bottom"
        # Move all others down
        for i of els
          el = els[i]

          if typeof el is "object"
            if parseInt(el.style.bottom) > parseInt(@holdingBox.style.bottom)
              el.style.bottom = "#{(parseInt(el.style.bottom) - @holdingBox.offsetHeight) - @_spacing}px"
      when "top"
        # Move all others up
        for i of els
          el = els[i]

          if typeof el is "object"
            if parseInt(el.style.top) > parseInt(@holdingBox.style.top)
              el.style.top = "#{(parseInt(el.style.top) - @holdingBox.offsetHeight) - @_spacing}px"

    if remove is true
      # Holding box should be removed
      setTimeout =>
        @holdingBox.parentNode.removeChild @holdingBox
      , 400
    else
      return @

  # Internal: Add click event listener to the holding box
  addClickEvent: ->
    @holdingBox.addEventListener "click", @hide, true

  # Internal: Adds CSS to an element
  #
  # el - Element to add CSS to
  # css - CSS object. Key is CSS property
  #
  # Returns element
  addCss: (el, css) ->
    # Loop the CSS object
    for key, val of css
      el.style[key] = val

    return el
