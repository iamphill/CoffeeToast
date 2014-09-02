# CoffeeToast

Everybody likes toast right? Android got it right with the way it was implemented, a simple box positioned at the bottom of the window that would display some content to the user. Yet people of the web still haven't got this right. Until now! This plugins matches the Android implementation to make a nice & clean toast box for some content!

_n.b. Its called **Coffee**Toast because its made with CoffeeScript who'd of thought?!_

## Usage

Include the JavaScript file on your webpage.

```html
<script src="../dist/js/CoffeeToast.js"></script>
```

And then create some new toast!

```javascript
document.addEventListener("DOMContentLoaded", function () {
  var toast = new CoffeeToast("Well done! Task is done!", CoffeeToast.Bottom);

  setTimeout(function () {
    toast.show();
  }, 2000);
});
```

The CoffeeToast class takes 2 arguments, the first being the text you want to display and the second being the location. By default, it'll be positioned at the bottom. But changed the second argument to position it somewhere else!

The available positions are and are pretty self explanatory.

```
CoffeeToast.Top
CoffeeToast.Right
CoffeeToast.Bottom
CoffeeToast.Left
```

To show the created toast, run the show method. The `show` method can take 2 arguments. The first argument is the length of time to show the toast box and the second is whether to remove it from the DOM after it is hidden. By default the time is 1500ms and remove on hidden is false.

```javascript
toast.show();
toast.show(CoffeeToast.Fast);
toast.show(CoffeToast.Slow, true);
```

There are two pre-configured speeds available.

```
CoffeeToast.Fast // 2500
CoffeeToast.Slow // 4000
```

Toasts will automatically hide when the timer has run out or when the user clicks on the element. However, you can remove it yourself with the `hide` method. This method takes one argument and that is whether to remove the toast when hidden. This is set to false by default.

```javascript
toast.hide();
toast.hide(true);
```

## Browser Support

It has been tested in all major browser and also in IE9+. IE9 doesn't do any fancy fading (Silly old browser!)
