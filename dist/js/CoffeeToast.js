(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  this.CoffeeToast = (function() {
    CoffeeToast.Top = "top";

    CoffeeToast.Right = "right";

    CoffeeToast.Bottom = "bottom";

    CoffeeToast.Left = "left";

    CoffeeToast.Slow = 4000;

    CoffeeToast.Fast = 2500;

    CoffeeToast.prototype._timer = "";

    CoffeeToast.prototype._spacing = 15;

    function CoffeeToast(text, position) {
      this.text = text;
      this.position = position != null ? position : "bottom";
      this.hide = __bind(this.hide, this);
      if (this.text.length > 70) {
        this.text = "" + (this.text.substring(0, 70)) + "...";
      }
      this.createHoldingBox();
      this.addTextBox();
      this.addClickEvent();
    }

    CoffeeToast.prototype.createHoldingBox = function() {
      var div;
      div = document.createElement("div");
      div.className = "coffee-toast coffee-toast-shown coffee-toast-" + this.position;
      div = this.addCss(div, {
        background: "black",
        background: "rgba(0, 0, 0, 0.8)",
        maxWidth: "200px",
        minWidth: "60px",
        padding: "7px 12px",
        display: "inline-block",
        color: "#fff",
        fontFamily: "Arial, sans-serif",
        position: "fixed",
        boxShadow: "0px 2px 4px rgba(0, 0, 0, 0.4)",
        fontSize: "13px",
        borderRadius: "3px",
        cursor: "pointer",
        textAlign: "center",
        lineHeight: "1.5em",
        opacity: "0",
        webkitTransition: "all 0.17s ease-in",
        mozTransition: "all 0.17s ease-in",
        oTransition: "all 0.17s ease-in",
        transition: "all 0.17s ease-in"
      });
      return this.holdingBox = div;
    };

    CoffeeToast.prototype.positionHoldingBox = function() {
      var bottom, css, els, lastEl, top;
      css = {};
      switch (this.position) {
        case "left":
          top = -(this.holdingBox.offsetHeight / 2);
          els = document.querySelectorAll(".coffee-toast-left");
          lastEl = els[els.length - 2];
          if (lastEl) {
            top = parseInt(lastEl.style.marginTop) + lastEl.offsetHeight + this._spacing;
          }
          css = {
            left: "15px",
            top: "50%",
            marginTop: "" + top + "px"
          };
          break;
        case "right":
          top = -(this.holdingBox.offsetHeight / 2);
          els = document.querySelectorAll(".coffee-toast-right");
          lastEl = els[els.length - 2];
          if (lastEl) {
            top = parseInt(lastEl.style.marginTop) + lastEl.offsetHeight + this._spacing;
          }
          css = {
            right: "15px",
            top: "50%",
            marginTop: "" + top + "px"
          };
          break;
        case "top":
          top = 40;
          els = document.querySelectorAll(".coffee-toast-top");
          lastEl = els[els.length - 2];
          if (lastEl) {
            top = (lastEl.offsetTop + lastEl.offsetHeight) + this._spacing;
          }
          css = {
            top: "" + top + "px",
            left: "50%",
            marginLeft: "-" + (this.holdingBox.offsetWidth / 2) + "px"
          };
          break;
        case "bottom":
          bottom = 60;
          els = document.querySelectorAll(".coffee-toast-bottom");
          lastEl = els[els.length - 2];
          if (lastEl) {
            bottom = (parseInt(lastEl.style.bottom) + lastEl.offsetHeight) + this._spacing;
          }
          css = {
            bottom: "" + bottom + "px",
            left: "50%",
            marginLeft: "-" + (this.holdingBox.offsetWidth / 2) + "px"
          };
      }
      return this.addCss(this.holdingBox, css);
    };

    CoffeeToast.prototype.addTextBox = function() {
      var span;
      span = document.createElement("span");
      span.className = "coffee-toast coffee-toast-text";
      span.textContent = this.text;
      return this.holdingBox.appendChild(span);
    };

    CoffeeToast.prototype.show = function(time, remove) {
      if (time == null) {
        time = 1500;
      }
      if (remove == null) {
        remove = false;
      }
      document.body.appendChild(this.holdingBox);
      this.positionHoldingBox();
      this.addCss(this.holdingBox, {
        opacity: "1"
      });
      clearTimeout(this._timer);
      this._timer = setTimeout((function(_this) {
        return function() {
          return _this.hide(remove);
        };
      })(this), time + 200);
      return this;
    };

    CoffeeToast.prototype.hide = function(remove) {
      var el, els, i;
      if (remove == null) {
        remove = false;
      }
      clearTimeout(this._timer);
      this.addCss(this.holdingBox, {
        opacity: "0"
      });
      els = document.querySelectorAll(".coffee-toast-" + this.position);
      switch (this.position) {
        case "bottom":
          for (i in els) {
            el = els[i];
            if (typeof el === "object") {
              if (parseInt(el.style.bottom) > parseInt(this.holdingBox.style.bottom)) {
                el.style.bottom = "" + ((parseInt(el.style.bottom) - this.holdingBox.offsetHeight) - this._spacing) + "px";
              }
            }
          }
          break;
        case "top":
          for (i in els) {
            el = els[i];
            if (typeof el === "object") {
              if (parseInt(el.style.top) > parseInt(this.holdingBox.style.top)) {
                el.style.top = "" + ((parseInt(el.style.top) - this.holdingBox.offsetHeight) - this._spacing) + "px";
              }
            }
          }
      }
      if (remove === true) {
        return setTimeout((function(_this) {
          return function() {
            return _this.holdingBox.parentNode.removeChild(_this.holdingBox);
          };
        })(this), 400);
      } else {
        return this;
      }
    };

    CoffeeToast.prototype.addClickEvent = function() {
      return this.holdingBox.addEventListener("click", this.hide, true);
    };

    CoffeeToast.prototype.addCss = function(el, css) {
      var key, val;
      for (key in css) {
        val = css[key];
        el.style[key] = val;
      }
      return el;
    };

    return CoffeeToast;

  })();

}).call(this);
