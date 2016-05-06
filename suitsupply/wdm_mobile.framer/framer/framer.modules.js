require=(function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);var f=new Error("Cannot find module '"+o+"'");throw f.code="MODULE_NOT_FOUND",f}var l=n[o]={exports:{}};t[o][0].call(l.exports,function(e){var n=t[o][1][e];return s(n?n:e)},l,l.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({"TextLayer":[function(require,module,exports){
var TextLayer, convertTextLayers, convertToTextLayer,
  extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
  hasProp = {}.hasOwnProperty;

TextLayer = (function(superClass) {
  extend(TextLayer, superClass);

  function TextLayer(options) {
    if (options == null) {
      options = {};
    }
    this.doAutoSize = false;
    this.doAutoSizeHeight = false;
    if (options.backgroundColor == null) {
      options.backgroundColor = options.setup ? "hsla(60, 90%, 47%, .4)" : "transparent";
    }
    if (options.color == null) {
      options.color = "red";
    }
    if (options.lineHeight == null) {
      options.lineHeight = 1.25;
    }
    if (options.fontFamily == null) {
      options.fontFamily = "Helvetica";
    }
    if (options.fontSize == null) {
      options.fontSize = 20;
    }
    if (options.text == null) {
      options.text = "Use layer.text to add text";
    }
    TextLayer.__super__.constructor.call(this, options);
    this.style.whiteSpace = "pre-line";
    this.style.outline = "none";
  }

  TextLayer.prototype.setStyle = function(property, value, pxSuffix) {
    if (pxSuffix == null) {
      pxSuffix = false;
    }
    this.style[property] = pxSuffix ? value + "px" : value;
    this.emit("change:" + property, value);
    if (this.doAutoSize) {
      return this.calcSize();
    }
  };

  TextLayer.prototype.calcSize = function() {
    var constraints, size, sizeAffectingStyles;
    sizeAffectingStyles = {
      lineHeight: this.style["line-height"],
      fontSize: this.style["font-size"],
      fontWeight: this.style["font-weight"],
      paddingTop: this.style["padding-top"],
      paddingRight: this.style["padding-right"],
      paddingBottom: this.style["padding-bottom"],
      paddingLeft: this.style["padding-left"],
      textTransform: this.style["text-transform"],
      borderWidth: this.style["border-width"],
      letterSpacing: this.style["letter-spacing"],
      fontFamily: this.style["font-family"],
      fontStyle: this.style["font-style"],
      fontVariant: this.style["font-variant"]
    };
    constraints = {};
    if (this.doAutoSizeHeight) {
      constraints.width = this.width;
    }
    size = Utils.textSize(this.text, sizeAffectingStyles, constraints);
    if (this.style.textAlign === "right") {
      this.width = size.width;
      this.x = this.x - this.width;
    } else {
      this.width = size.width;
    }
    return this.height = size.height;
  };

  TextLayer.define("autoSize", {
    get: function() {
      return this.doAutoSize;
    },
    set: function(value) {
      this.doAutoSize = value;
      if (this.doAutoSize) {
        return this.calcSize();
      }
    }
  });

  TextLayer.define("autoSizeHeight", {
    set: function(value) {
      this.doAutoSize = value;
      this.doAutoSizeHeight = value;
      if (this.doAutoSize) {
        return this.calcSize();
      }
    }
  });

  TextLayer.define("contentEditable", {
    set: function(boolean) {
      this._element.contentEditable = boolean;
      this.ignoreEvents = !boolean;
      return this.on("input", function() {
        if (this.doAutoSize) {
          return this.calcSize();
        }
      });
    }
  });

  TextLayer.define("text", {
    get: function() {
      return this._element.textContent;
    },
    set: function(value) {
      this._element.textContent = value;
      this.emit("change:text", value);
      if (this.doAutoSize) {
        return this.calcSize();
      }
    }
  });

  TextLayer.define("fontFamily", {
    get: function() {
      return this.style.fontFamily;
    },
    set: function(value) {
      return this.setStyle("fontFamily", value);
    }
  });

  TextLayer.define("fontSize", {
    get: function() {
      return this.style.fontSize.replace("px", "");
    },
    set: function(value) {
      return this.setStyle("fontSize", value, true);
    }
  });

  TextLayer.define("lineHeight", {
    get: function() {
      return this.style.lineHeight;
    },
    set: function(value) {
      return this.setStyle("lineHeight", value);
    }
  });

  TextLayer.define("fontWeight", {
    get: function() {
      return this.style.fontWeight;
    },
    set: function(value) {
      return this.setStyle("fontWeight", value);
    }
  });

  TextLayer.define("fontStyle", {
    get: function() {
      return this.style.fontStyle;
    },
    set: function(value) {
      return this.setStyle("fontStyle", value);
    }
  });

  TextLayer.define("fontVariant", {
    get: function() {
      return this.style.fontVariant;
    },
    set: function(value) {
      return this.setStyle("fontVariant", value);
    }
  });

  TextLayer.define("padding", {
    set: function(value) {
      this.setStyle("paddingTop", value, true);
      this.setStyle("paddingRight", value, true);
      this.setStyle("paddingBottom", value, true);
      return this.setStyle("paddingLeft", value, true);
    }
  });

  TextLayer.define("paddingTop", {
    get: function() {
      return this.style.paddingTop.replace("px", "");
    },
    set: function(value) {
      return this.setStyle("paddingTop", value, true);
    }
  });

  TextLayer.define("paddingRight", {
    get: function() {
      return this.style.paddingRight.replace("px", "");
    },
    set: function(value) {
      return this.setStyle("paddingRight", value, true);
    }
  });

  TextLayer.define("paddingBottom", {
    get: function() {
      return this.style.paddingBottom.replace("px", "");
    },
    set: function(value) {
      return this.setStyle("paddingBottom", value, true);
    }
  });

  TextLayer.define("paddingLeft", {
    get: function() {
      return this.style.paddingLeft.replace("px", "");
    },
    set: function(value) {
      return this.setStyle("paddingLeft", value, true);
    }
  });

  TextLayer.define("textAlign", {
    set: function(value) {
      return this.setStyle("textAlign", value);
    }
  });

  TextLayer.define("textTransform", {
    get: function() {
      return this.style.textTransform;
    },
    set: function(value) {
      return this.setStyle("textTransform", value);
    }
  });

  TextLayer.define("letterSpacing", {
    get: function() {
      return this.style.letterSpacing.replace("px", "");
    },
    set: function(value) {
      return this.setStyle("letterSpacing", value, true);
    }
  });

  TextLayer.define("length", {
    get: function() {
      return this.text.length;
    }
  });

  return TextLayer;

})(Layer);

convertToTextLayer = function(layer) {
  var css, cssObj, importPath, t;
  t = new TextLayer({
    name: layer.name,
    frame: layer.frame,
    parent: layer.parent
  });
  cssObj = {};
  css = layer._info.metadata.css;
  css.forEach(function(rule) {
    var arr;
    if (_.contains(rule, '/*')) {
      return;
    }
    arr = rule.split(': ');
    return cssObj[arr[0]] = arr[1].replace(';', '');
  });
  t.style = cssObj;
  importPath = layer.__framerImportedFromPath;
  if (_.contains(importPath, '@2x')) {
    t.fontSize *= 2;
    t.lineHeight = (parseInt(t.lineHeight) * 2) + 'px';
    t.letterSpacing *= 2;
  }
  t.y -= (parseInt(t.lineHeight) - t.fontSize) / 2;
  t.y -= t.fontSize * 0.1;
  t.x -= t.fontSize * 0.08;
  t.width += t.fontSize * 0.5;
  t.text = layer._info.metadata.string;
  layer.destroy();
  return t;
};

Layer.prototype.convertToTextLayer = function() {
  return convertToTextLayer(this);
};

convertTextLayers = function(obj) {
  var layer, prop, results;
  results = [];
  for (prop in obj) {
    layer = obj[prop];
    if (layer._info.kind === "text") {
      results.push(obj[prop] = convertToTextLayer(layer));
    } else {
      results.push(void 0);
    }
  }
  return results;
};

Layer.prototype.frameAsTextLayer = function(properties) {
  var t;
  t = new TextLayer;
  t.frame = this.frame;
  t.superLayer = this.superLayer;
  _.extend(t, properties);
  this.destroy();
  return t;
};

exports.TextLayer = TextLayer;

exports.convertTextLayers = convertTextLayers;


},{}],"framerKit":[function(require,module,exports){

/*
  FramerKit for Framer
  https://github.com/raphdamico/framerKit

  Copyright (c) 2015, Raph D'Amico http://raphdamico.com (@raphdamico)
  MIT License

  Readme:
  https://github.com/raphdamico/framerKit

  License:
  https://github.com/raphdamico/framerKit/blob/master/LICENSE.md
 */

/*
	DEFAULT STYLES
	Note the screenwidth constant: this is probably one of the
	first things you want to change so it matches the device
	you're prototyping on.
 */
var Caret, Check, Cross, Drum, Switch, defaults, quantize;

defaults = {
  screenWidth: 750
};


/*
	MORE STYLES
 */

defaults.tableRowHeight = 88;

defaults.tableRowHorizontalPadding = 20;

defaults.tint = 'grey';

defaults.lineTint = "rgba(200,200,200,1)";

defaults.switchTint = '#1DC24B';

defaults.itemBackground = 'white';

defaults.listItemTextStyle = {
  fontSize: "32px",
  lineHeight: (defaults.tableRowHeight - 4) + "px",
  fontFamily: "Helvetica Neue",
  fontWeight: "200"
};

defaults.dividerItemTextStyle = {
  fontSize: "22px",
  lineHeight: (defaults.tableRowHeight - 4) + "px",
  fontFamily: "Helvetica Neue",
  fontWeight: "200",
  textTransform: 'uppercase'
};

defaults.pickerTextStyle = {
  fontSize: "42px",
  fontFamily: "Helvetica Neue",
  fontWeight: "200"
};

exports.defaults = defaults;


/*
	TABLE VIEW ELEMENTS
	(e.g. "Thumb" for the switch control)
 */

Switch = function(params) {
  var shrunkenBackgroundDiameter, switchButtonRadius;
  params = params || {};
  _.defaults(params, {
    switchTint: defaults.switchTint,
    screenWidth: defaults.screenWidth,
    tableRowHeight: defaults.tableRowHeight,
    switchContainerBorder: 4,
    switchContainerHeight: 54,
    switchContainerWidth: 94,
    borderColor: defaults.lineTint
  });
  this.selected = true;
  switchButtonRadius = params.switchContainerHeight / 2;
  shrunkenBackgroundDiameter = 2;
  this.switchButtonContainer = new Layer({
    x: 0,
    y: 0,
    clip: false,
    width: params.switchContainerWidth,
    height: params.switchContainerHeight,
    backgroundColor: "",
    opacity: 1
  });
  this.switchBackground = new Layer({
    x: switchButtonRadius - shrunkenBackgroundDiameter / 2,
    y: switchButtonRadius - shrunkenBackgroundDiameter / 2 - 4,
    width: params.switchContainerWidth - params.switchContainerHeight + shrunkenBackgroundDiameter,
    height: params.switchContainerHeight - params.switchContainerHeight + shrunkenBackgroundDiameter,
    borderRadius: params.switchContainerHeight,
    shadowSpread: switchButtonRadius - shrunkenBackgroundDiameter / 2 + params.switchContainerBorder,
    shadowColor: params.switchTint,
    backgroundColor: '',
    opacity: 1,
    superLayer: this.switchButtonContainer
  });
  this.switchButton = new Layer({
    x: params.switchContainerWidth - params.switchContainerHeight,
    y: -4,
    width: switchButtonRadius * 2,
    height: switchButtonRadius * 2,
    borderRadius: switchButtonRadius,
    shadowY: 3,
    shadowBlur: 5,
    shadowColor: 'rgba(0,0,0,0.3)',
    backgroundColor: "white",
    opacity: 1,
    superLayer: this.switchButtonContainer
  });
  this.switchBackground.states.add({
    deselected: {
      x: 0,
      y: -4,
      width: params.switchContainerWidth,
      height: params.switchContainerHeight,
      shadowSpread: params.switchContainerBorder,
      saturate: 0,
      brightness: 153,
      backgroundColor: ""
    }
  });
  this.switchBackground.states.animationOptions = {
    curve: "ease-in-out",
    time: 0.3
  };
  this.switchBackground.on(Events.AnimationEnd, (function(_this) {
    return function() {
      return Utils.delay(0, function() {
        if (_this.selected) {
          return _this.switchBackground.backgroundColor = params.switchTint;
        }
      });
    };
  })(this));
  this.switchBackground.on(Events.AnimationStart, (function(_this) {
    return function() {
      return _this.switchBackground.backgroundColor = '';
    };
  })(this));
  this.switchButton.states.add({
    deselected: {
      x: 0
    }
  });
  this.switchButton.states.animationOptions = {
    curve: "spring(400,25,0)"
  };
  this.switchButtonContainer.select = (function(_this) {
    return function() {
      _this.selected = true;
      _this.switchBackground.states["switch"]("default");
      return _this.switchButton.states["switch"]("default");
    };
  })(this);
  this.switchButtonContainer.deselect = (function(_this) {
    return function() {
      _this.selected = false;
      _this.switchBackground.states["switch"]("deselected");
      return _this.switchButton.states["switch"]("deselected");
    };
  })(this);
  if (this.selected === false) {
    this.switchBackground.states.switchInstant("deselected");
    this.switchButton.states.switchInstant("deselected");
  } else {
    this.switchBackground.backgroundColor = params.switchTint;
  }
  return this.switchButtonContainer;
};

Cross = function() {
  var color, cross, crossDownstroke, crossThickness, crossUpstroke;
  color = defaults.tint;
  crossThickness = 4;
  cross = new Layer({
    width: 30,
    height: 30,
    backgroundColor: 'none'
  });
  crossUpstroke = new Layer({
    height: crossThickness,
    width: 20,
    backgroundColor: color,
    originX: 1,
    superLayer: cross
  });
  crossUpstroke.y = 14;
  crossUpstroke.rotationZ = 45;
  crossDownstroke = new Layer({
    height: crossThickness,
    width: 20,
    originX: 1,
    backgroundColor: color,
    superLayer: cross
  });
  crossDownstroke.rotationZ = -45;
  cross.select = function() {
    return cross.animate({
      properties: {
        opacity: 1,
        scale: 1
      },
      curve: 'spring(400,15,0)'
    });
  };
  cross.deselect = function() {
    return cross.animate({
      properties: {
        opacity: 0,
        scale: 0.4
      },
      curve: 'spring(400,15,0)'
    });
  };
  return cross;
};

Caret = function() {
  var caret, caretDownstroke, caretThickness, caretUpstroke, color;
  color = defaults.tint;
  caretThickness = 4;
  caret = new Layer({
    width: 30,
    height: 30,
    backgroundColor: 'none'
  });
  caretUpstroke = new Layer({
    height: caretThickness,
    width: 18,
    backgroundColor: color,
    originX: 1,
    superLayer: caret
  });
  caretUpstroke.y = 14;
  caretUpstroke.rotationZ = 45;
  caretDownstroke = new Layer({
    height: caretThickness,
    width: 18,
    originX: 1,
    backgroundColor: color,
    superLayer: caret
  });
  caretDownstroke.y = 12;
  caretDownstroke.rotationZ = -45;
  caret.select = function() {
    return caret.animate({
      properties: {
        opacity: 1,
        scale: 1
      },
      curve: 'spring(400,15,0)'
    });
  };
  caret.deselect = function() {
    return caret.animate({
      properties: {
        opacity: 0,
        scale: 0.4
      },
      curve: 'spring(400,15,0)'
    });
  };
  return caret;
};

Check = function() {
  var check, checkDownstroke, checkThickness, checkUpstroke, color;
  color = defaults.tint;
  checkThickness = 4;
  check = new Layer({
    width: 30,
    height: 30,
    backgroundColor: 'none'
  });
  checkUpstroke = new Layer({
    height: checkThickness,
    width: 13,
    backgroundColor: color,
    originX: 1,
    superLayer: check
  });
  checkUpstroke.y = 16;
  checkUpstroke.rotationZ = 45;
  checkDownstroke = new Layer({
    height: checkThickness,
    width: 22,
    originX: 1,
    backgroundColor: color,
    superLayer: check
  });
  checkDownstroke.x = 4;
  checkDownstroke.rotationZ = -45;
  check.select = function() {
    return check.animate({
      properties: {
        opacity: 1,
        scale: 1
      },
      curve: 'spring(400,15,0)'
    });
  };
  check.deselect = function() {
    return check.animate({
      properties: {
        opacity: 0,
        scale: 0.4
      },
      curve: 'spring(400,15,0)'
    });
  };
  return check;
};


/*
	TABLE VIEW
	
	--------------------------------------
	TableViewRow		[Elements go here]
	--------------------------------------
 */

exports.TableViewRow = function(params) {
  var shrunkenBackgroundDiameter, switchButtonRadius, thingToSwitch;
  _.defaults(params, {
    name: 'Give me a name!',
    x: 0,
    y: 0,
    enabled: true,
    selected: true,
    icon: 'check',
    textColor: defaults.tint,
    switchTint: defaults.switchTint,
    firstItemInList: true,
    lastItemInList: true,
    screenWidth: defaults.screenWidth,
    tableRowHorizontalPadding: defaults.tableRowHorizontalPadding,
    tableRowHeight: defaults.tableRowHeight,
    borderColor: defaults.lineTint
  });
  switchButtonRadius = params.switchContainerHeight / 2;
  shrunkenBackgroundDiameter = 2;
  this.listItemContainer = new Layer({
    x: params.x,
    y: params.y,
    width: defaults.screenWidth,
    height: defaults.tableRowHeight,
    clip: false,
    backgroundColor: defaults.itemBackground
  });
  this.listItemContainer.style = {
    borderTop: params.firstItemInList ? "1px solid " + params.borderColor : "",
    borderBottom: params.lastItemInList ? "1px solid " + params.borderColor : ""
  };
  this.enabled = params.enabled;
  this.selected = params.selected;
  this.listItem = new Layer({
    x: params.tableRowHorizontalPadding,
    width: defaults.screenWidth,
    height: defaults.tableRowHeight,
    superLayer: this.listItemContainer,
    backgroundColor: 'none'
  });
  this.listItem.style = defaults.listItemTextStyle;
  this.listItem.style = {
    color: params.textColor,
    borderTop: params.firstItemInList ? "" : "1px solid " + params.borderColor
  };
  this.listItem.html = params.name;
  thingToSwitch = (function() {
    switch (false) {
      case params.icon !== 'check':
        return new Check();
      case params.icon !== 'cross':
        return new Cross();
      case params.icon !== 'caret':
        return new Caret();
      case params.icon !== 'switch':
        return new Switch();
    }
  })();
  thingToSwitch.superLayer = this.listItemContainer;
  thingToSwitch.x = defaults.screenWidth - thingToSwitch.width - defaults.tableRowHorizontalPadding;
  thingToSwitch.centerY(2);
  if (params.icon === 'switch') {
    thingToSwitch.on(Events.Click, (function(_this) {
      return function() {
        return _this.listItemContainer["switch"]();
      };
    })(this));
  } else {
    this.listItem.on(Events.Click, (function(_this) {
      return function() {
        return _this.listItemContainer["switch"]();
      };
    })(this));
  }
  this.listItemContainer["switch"] = (function(_this) {
    return function() {
      if (_this.selected) {
        return _this.listItemContainer.deselect();
      } else {
        return _this.listItemContainer.select();
      }
    };
  })(this);
  this.listItemContainer.select = (function(_this) {
    return function(options) {
      options = options || {
        supressEvents: false
      };
      if (_this.enabled) {
        thingToSwitch.select();
        _this.selected = true;
      }
      if (options.supressEvents === false) {
        return _this.listItemContainer.emit("DidChange", {
          selected: _this.selected
        });
      }
    };
  })(this);
  this.listItemContainer.deselect = (function(_this) {
    return function(options) {
      options = options || {
        supressEvents: false
      };
      if (_this.enabled) {
        thingToSwitch.deselect();
        _this.selected = false;
      }
      if (options.supressEvents === false) {
        return _this.listItemContainer.emit("DidChange", {
          selected: _this.selected
        });
      }
    };
  })(this);
  this.listItemContainer.updateLabel = (function(_this) {
    return function(newText) {
      return _this.listItem.html = newText;
    };
  })(this);
  this.listItemContainer.selected = (function(_this) {
    return function() {
      return _this.selected;
    };
  })(this);
  this.listItemContainer.updateLabel(params.name);
  return this.listItemContainer;
};

exports.TableView = function(params) {
  var attachDefaultValidation, attachRadioButtonValidation, buttonName, firstItemInList, i, j, lastItemInList, len, newButton, ref;
  params = params || {};
  _.defaults(params, {
    y: 0,
    width: defaults.screenWidth,
    items: ["It's just me!"],
    icon: 'check',
    validation: 'none'
  });
  this.buttonGroupContainer = new Layer({
    x: 0,
    y: params.y,
    width: params.width,
    height: defaults.tableRowHeight * params.items.length,
    backgroundColor: "none"
  });
  this.buttonArray = [];
  ref = params.items;
  for (i = j = 0, len = ref.length; j < len; i = ++j) {
    buttonName = ref[i];
    firstItemInList = i === 0 ? true : false;
    lastItemInList = i === (params.items.length - 1) ? true : false;
    newButton = new exports.TableViewRow({
      x: 0,
      y: i * defaults.tableRowHeight,
      name: buttonName,
      icon: params.icon,
      firstItemInList: firstItemInList,
      lastItemInList: lastItemInList
    });
    this.buttonArray.push(newButton);
    newButton.superLayer = this.buttonGroupContainer;
  }
  attachRadioButtonValidation = (function(_this) {
    return function(buttonArray) {
      var buttonClicked, buttonGroupContainer, indexOfButtonClicked, k, len1, results;
      buttonGroupContainer = _this.buttonGroupContainer;
      results = [];
      for (indexOfButtonClicked = k = 0, len1 = buttonArray.length; k < len1; indexOfButtonClicked = ++k) {
        buttonClicked = buttonArray[indexOfButtonClicked];
        buttonClicked.deselect({
          supressEvents: true
        });
        results.push((function(buttonClicked, indexOfButtonClicked) {
          return buttonClicked.on('DidChange', (function(_this) {
            return function(event) {
              var l, len2, otherButton, otherButtonIndex;
              for (otherButtonIndex = l = 0, len2 = buttonArray.length; l < len2; otherButtonIndex = ++l) {
                otherButton = buttonArray[otherButtonIndex];
                if (otherButtonIndex !== indexOfButtonClicked) {
                  otherButton.deselect({
                    suppressEvents: true
                  });
                }
              }
              return buttonGroupContainer.emit("DidChange", {
                selected: indexOfButtonClicked,
                numSelected: 1,
                buttons: buttonArray
              });
            };
          })(this));
        })(buttonClicked, indexOfButtonClicked));
      }
      return results;
    };
  })(this);
  attachDefaultValidation = (function(_this) {
    return function(buttonArray) {
      var buttonClicked, buttonGroupContainer, indexOfButtonClicked, k, len1, results;
      buttonGroupContainer = _this.buttonGroupContainer;
      results = [];
      for (indexOfButtonClicked = k = 0, len1 = buttonArray.length; k < len1; indexOfButtonClicked = ++k) {
        buttonClicked = buttonArray[indexOfButtonClicked];
        buttonClicked.deselect({
          supressEvents: true
        });
        results.push((function(buttonClicked, indexOfButtonClicked) {
          return buttonClicked.on('DidChange', (function(_this) {
            return function(event) {
              var button, l, len2, numSelected, tableViewStates;
              numSelected = 0;
              tableViewStates = [];
              for (l = 0, len2 = buttonArray.length; l < len2; l++) {
                button = buttonArray[l];
                tableViewStates.push(button.selected());
                if (button.selected()) {
                  numSelected++;
                }
              }
              return buttonGroupContainer.emit("DidChange", {
                selected: tableViewStates,
                numSelected: numSelected,
                buttons: buttonArray
              });
            };
          })(this));
        })(buttonClicked, indexOfButtonClicked));
      }
      return results;
    };
  })(this);
  if (params.validation === 'radio') {
    attachRadioButtonValidation(this.buttonArray);
  } else {
    attachDefaultValidation(this.buttonArray);
  }
  return this.buttonGroupContainer;
};


/*
	TABLE VIEW HEADER
	In iOS, this is typically attached to the table view, 
	but it's independent here so you can put it wherever you want.
 */

exports.TableViewHeader = function(params) {
  var listDivider;
  params = params || {};
  _.defaults(params, {
    text: 'I am a divider',
    x: 0,
    y: 0
  });
  listDivider = new Layer({
    x: params.x + defaults.tableRowHorizontalPadding,
    y: params.y,
    width: defaults.screenWidth,
    backgroundColor: 'none'
  });
  listDivider.html = params.text;
  listDivider.style = defaults.dividerItemTextStyle;
  listDivider.style = {
    color: defaults.tint
  };
  return listDivider;
};


/*
	PICKER
	In iOS, this is typically attached to the table view, 
	but it's independent here so you can put it wherever you want.
 */

quantize = function(input, stepSize) {
  return Math.floor(input / stepSize) * stepSize;
};

Drum = function(parentDrumLayer, drumName, listItems, params) {
  var drumContainerHeight, firstTouchAvailable, i, intervalToupdateDrumAppearance, j, len, li, listHeight, listItemLayer, listLayer, listMaxYPos, listMinYPos, stopDrum, updateDrumAppearance, updateDrumValues;
  this.parentDrumLayer = parentDrumLayer;
  params = params || {};
  _.defaults(params, {
    enabled: true,
    xPct: 0,
    widthPct: 1,
    textAlign: "center",
    textPadding: "0",
    textColor: defaults.tint
  });
  drumContainerHeight = defaults.tableRowHeight * 5;
  listItems = listItems;
  this.name = drumName;
  this.index = 0;
  this.val = listItems[this.index];
  this.velocity = 0;
  firstTouchAvailable = true;
  intervalToupdateDrumAppearance = 0;
  listMinYPos = -defaults.tableRowHeight / 2;
  listMaxYPos = -listItems.length * defaults.tableRowHeight + defaults.tableRowHeight / 2;
  listHeight = listItems.length * defaults.tableRowHeight + drumContainerHeight;
  this.drumContainer = new Layer({
    x: params.xPct * defaults.screenWidth,
    y: 0,
    width: params.widthPct * defaults.screenWidth,
    height: drumContainerHeight,
    backgroundColor: "none",
    superLayer: parentDrumLayer
  });
  listLayer = new Layer({
    x: 0,
    y: -defaults.tableRowHeight / 2,
    width: params.widthPct * defaults.screenWidth,
    height: listHeight,
    superLayer: this.drumContainer,
    backgroundColor: "none"
  });
  listLayer.draggable.enabled = params.enabled;
  listLayer.draggable.speedX = 0;
  for (i = j = 0, len = listItems.length; j < len; i = ++j) {
    li = listItems[i];
    listItemLayer = new Layer({
      x: 0,
      y: i * defaults.tableRowHeight + drumContainerHeight / 2,
      width: params.widthPct * defaults.screenWidth,
      height: defaults.tableRowHeight,
      superLayer: listLayer,
      backgroundColor: "none"
    });
    listItemLayer.html = li;
    listItemLayer.style = {
      color: params.textColor,
      fontFamily: defaults.pickerTextStyle.fontFamily,
      fontWeight: defaults.pickerTextStyle.fontWeight,
      fontSize: defaults.pickerTextStyle.fontSize,
      lineHeight: defaults.tableRowHeight + "px",
      textAlign: params.textAlign,
      padding: params.textPadding
    };
    listItemLayer.startY = i * defaults.tableRowHeight + drumContainerHeight / 2;
  }
  listLayer.on(Events.DragMove, (function(_this) {
    return function() {
      if (firstTouchAvailable) {
        _this.drumContainer.emit("DrumStartedMoving", {
          drum: drumName,
          index: _this.index,
          value: _this.val,
          velocity: 0
        });
        firstTouchAvailable = false;
      }
      return updateDrumAppearance();
    };
  })(this));
  listLayer.on(Events.DragEnd, (function(_this) {
    return function(e, f) {
      var bottomOverflow, distanceToTravel, finalPositionAfterMomentum, listHeightWithoutEndBuffer, newDistanceToTravel, overflowDampening, scrollVelocity, timeAfterDrag, topOverflow;
      firstTouchAvailable = true;
      scrollVelocity = listLayer.draggable.calculateVelocity().y;
      timeAfterDrag = (0.5 + Math.abs(scrollVelocity * 0.2)).toFixed(1);
      finalPositionAfterMomentum = quantize(listLayer.y + scrollVelocity * 400, defaults.tableRowHeight) + defaults.tableRowHeight / 2;
      distanceToTravel = finalPositionAfterMomentum - listLayer.y;
      listHeightWithoutEndBuffer = -listItems.length * defaults.tableRowHeight;
      bottomOverflow = Math.max(0, listHeightWithoutEndBuffer - finalPositionAfterMomentum);
      topOverflow = Math.max(0, finalPositionAfterMomentum);
      overflowDampening = 10;
      if (bottomOverflow > 0) {
        finalPositionAfterMomentum = listHeightWithoutEndBuffer - (bottomOverflow / overflowDampening);
        newDistanceToTravel = finalPositionAfterMomentum - listLayer.y;
        timeAfterDrag = timeAfterDrag * (newDistanceToTravel / distanceToTravel);
      }
      if (topOverflow > 0) {
        finalPositionAfterMomentum = 40 + (topOverflow / overflowDampening);
        newDistanceToTravel = finalPositionAfterMomentum - listLayer.y;
        timeAfterDrag = timeAfterDrag * (newDistanceToTravel / distanceToTravel);
      }
      listLayer.animate({
        properties: {
          y: finalPositionAfterMomentum
        },
        time: timeAfterDrag,
        curve: "ease-out"
      });
      return Utils.delay(timeAfterDrag, function() {
        return stopDrum();
      });
    };
  })(this));
  listLayer.on(Events.AnimationStart, function() {
    clearInterval(intervalToupdateDrumAppearance);
    return intervalToupdateDrumAppearance = Utils.interval(1 / 30, updateDrumAppearance);
  });
  listLayer.on(Events.AnimationEnd, (function(_this) {
    return function() {
      clearInterval(intervalToupdateDrumAppearance);
      return _this.drumContainer.emit("DrumFinishedChanging", {
        list: drumName,
        index: _this.index,
        value: _this.val
      });
    };
  })(this));
  updateDrumAppearance = (function(_this) {
    return function() {
      var cappedListPosition, distanceFromMiddle, focusItem, itemsInDrum, k, listPosition, ref, ref1;
      itemsInDrum = 4;
      listPosition = listLayer.y / -defaults.tableRowHeight - 0.5;
      cappedListPosition = Math.max(0, Math.min(listLayer.y / -defaults.tableRowHeight - 0.5, listItems.length - 1));
      focusItem = Math.round(cappedListPosition);
      distanceFromMiddle = Math.abs(focusItem - cappedListPosition);
      for (i = k = ref = focusItem - itemsInDrum, ref1 = focusItem + itemsInDrum; ref <= ref1 ? k <= ref1 : k >= ref1; i = ref <= ref1 ? ++k : --k) {
        if (i >= 0 && i < listItems.length) {
          listLayer.subLayers[i].opacity = 1 - Math.abs(listPosition - i) / 5 - (i !== focusItem ? 0.3 : 0);
          listLayer.subLayers[i].scaleY = 1 - Math.min(1, Math.abs(listPosition - i) / 4);
          listLayer.subLayers[i].y = listLayer.subLayers[i].startY - (i - listPosition) * Math.abs(i - listPosition) * 10;
        }
      }
      if (_this.index !== focusItem) {
        return updateDrumValues(focusItem);
      }
    };
  })(this);
  stopDrum = (function(_this) {
    return function() {
      if (listLayer.y > listMinYPos) {
        listLayer.animate({
          properties: {
            y: listMinYPos
          },
          curve: "spring(400,50,0)"
        });
      }
      if (listLayer.y < listMaxYPos) {
        return listLayer.animate({
          properties: {
            y: listMaxYPos
          },
          curve: "spring(400,50,0)"
        });
      }
    };
  })(this);
  updateDrumValues = (function(_this) {
    return function(newIndex) {
      _this.index = newIndex;
      _this.val = listItems[_this.index];
      return _this.drumContainer.emit("DrumDidChange", {
        list: drumName,
        index: _this.index,
        value: _this.val
      });
    };
  })(this);
  updateDrumAppearance();
  this.setIndex = (function(_this) {
    return function(index) {
      var yPositionForThisIndex;
      yPositionForThisIndex = -defaults.tableRowHeight / 2 - (index * defaults.tableRowHeight);
      return listLayer.animate({
        properties: {
          y: yPositionForThisIndex
        },
        time: 0.5,
        curve: "ease-out"
      });
    };
  })(this);
  this.setValue = (function(_this) {
    return function(val) {
      var index;
      index = listItems.indexOf(val);
      if (index !== -1) {
        return _this.setIndex(index);
      }
    };
  })(this);
  return this;
};


/*
	PICKER
	This contains the picker
 */

exports.Picker = function(params) {
  var drum, drumContainerHeight, j, len, newDrum, pickerDidChange, pickerFinishedChanging, pickerStartedMoving, ref;
  params = params || {};
  _.defaults(params, {
    x: 0,
    y: 0,
    width: defaults.screenWidth,
    defaultText: "",
    textColor: defaults.tint
  });
  drumContainerHeight = defaults.tableRowHeight * 5;
  this.pickerContainer = new Layer({
    x: params.x,
    y: params.y,
    width: params.width,
    height: drumContainerHeight + 88,
    backgroundColor: defaults.itemBackground
  });
  this.drum = new Layer({
    x: 0,
    y: 88,
    width: params.width,
    height: drumContainerHeight,
    backgroundColor: "none",
    superLayer: this.pickerContainer
  });
  this.selectedItem = new Layer({
    x: 0,
    y: drumContainerHeight / 2 - defaults.tableRowHeight / 2,
    width: params.width,
    height: defaults.tableRowHeight,
    backgroundColor: "none",
    superLayer: this.drum
  });
  this.pickerContainer.pickerHeader = new Layer({
    x: 0,
    y: 0,
    width: params.width,
    height: 88,
    backgroundColor: defaults.itemBackground,
    superLayer: this.pickerContainer
  });
  this.drum.style = {
    pointerEvents: "none",
    borderTop: "1px solid " + defaults.lineTint,
    borderBottom: "1px solid " + defaults.lineTint
  };
  this.selectedItem.style = {
    pointerEvents: "none",
    borderTop: "1px solid rgba(0,0,0,0.3)",
    borderBottom: "1px solid rgba(0,0,0,0.3)"
  };
  this.pickerContainer.pickerHeader.style = defaults.listItemTextStyle;
  this.pickerContainer.pickerHeader.style = {
    color: params.textColor,
    paddingLeft: "20px",
    borderTop: "1px solid " + defaults.lineTint
  };
  this.pickerContainer.pickerHeader.html = params.defaultText;
  this.pickerContainer.drums = [];
  this.pickerContainer.drumsByName = {};
  pickerStartedMoving = (function(_this) {
    return function() {
      var drum, drumValues, newValues;
      drumValues = {};
      newValues = (function() {
        var j, len, ref, results;
        ref = this.pickerContainer.drums;
        results = [];
        for (j = 0, len = ref.length; j < len; j++) {
          drum = ref[j];
          results.push(drumValues[drum.name] = {
            index: drum.index,
            val: drum.val,
            velocity: 0
          });
        }
        return results;
      }).call(_this);
      return _this.pickerContainer.emit("PickerStartedMoving");
    };
  })(this);
  pickerDidChange = (function(_this) {
    return function() {
      var drum, drumValues, newValues;
      drumValues = {};
      newValues = (function() {
        var j, len, ref, results;
        ref = this.pickerContainer.drums;
        results = [];
        for (j = 0, len = ref.length; j < len; j++) {
          drum = ref[j];
          results.push(drumValues[drum.name] = {
            index: drum.index,
            val: drum.val
          });
        }
        return results;
      }).call(_this);
      return _this.pickerContainer.emit("PickerDidChange", drumValues);
    };
  })(this);
  pickerFinishedChanging = (function(_this) {
    return function() {
      var drum, drumValues, newValues;
      drumValues = {};
      newValues = (function() {
        var j, len, ref, results;
        ref = this.pickerContainer.drums;
        results = [];
        for (j = 0, len = ref.length; j < len; j++) {
          drum = ref[j];
          results.push(drumValues[drum.name] = {
            index: drum.index,
            val: drum.val
          });
        }
        return results;
      }).call(_this);
      return _this.pickerContainer.emit("PickerFinishedChanging", drumValues);
    };
  })(this);
  if (params.drums && params.drums.length > 0) {
    ref = params.drums;
    for (j = 0, len = ref.length; j < len; j++) {
      drum = ref[j];
      newDrum = new Drum(this.drum, drum.name, drum.items, drum.params);
      this.pickerContainer.drums.push(newDrum);
      this.pickerContainer.drumsByName[drum.name] = newDrum;
      newDrum.drumContainer.on("DrumDidChange", pickerDidChange);
      newDrum.drumContainer.on("DrumFinishedChanging", pickerFinishedChanging);
      newDrum.drumContainer.on("DrumStartedMoving", pickerStartedMoving);
    }
  }
  return this.pickerContainer;
};


},{}],"myModule":[function(require,module,exports){
exports.myVar = "myVariable";

exports.myFunction = function() {
  return print("myFunction is running");
};

exports.myArray = [1, 2, 3];


},{}]},{},[])
//# sourceMappingURL=data:application/json;charset:utf-8;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbIm5vZGVfbW9kdWxlcy9icm93c2VyaWZ5L25vZGVfbW9kdWxlcy9icm93c2VyLXBhY2svX3ByZWx1ZGUuanMiLCIvVXNlcnMvZW5vbHRlbi9Db2RlL2xhYi9zdWl0c3VwcGx5L3dkbV9tb2JpbGUuZnJhbWVyL21vZHVsZXMvVGV4dExheWVyLmNvZmZlZSIsIi9Vc2Vycy9lbm9sdGVuL0NvZGUvbGFiL3N1aXRzdXBwbHkvd2RtX21vYmlsZS5mcmFtZXIvbW9kdWxlcy9mcmFtZXJLaXQuY29mZmVlIiwiL1VzZXJzL2Vub2x0ZW4vQ29kZS9sYWIvc3VpdHN1cHBseS93ZG1fbW9iaWxlLmZyYW1lci9tb2R1bGVzL215TW9kdWxlLmNvZmZlZSJdLCJuYW1lcyI6W10sIm1hcHBpbmdzIjoiQUFBQTtBQ0FBLElBQUEsZ0RBQUE7RUFBQTs7O0FBQU07OztFQUVRLG1CQUFDLE9BQUQ7O01BQUMsVUFBUTs7SUFDckIsSUFBQyxDQUFBLFVBQUQsR0FBYztJQUNkLElBQUMsQ0FBQSxnQkFBRCxHQUFvQjs7TUFDcEIsT0FBTyxDQUFDLGtCQUFzQixPQUFPLENBQUMsS0FBWCxHQUFzQix3QkFBdEIsR0FBb0Q7OztNQUMvRSxPQUFPLENBQUMsUUFBUzs7O01BQ2pCLE9BQU8sQ0FBQyxhQUFjOzs7TUFDdEIsT0FBTyxDQUFDLGFBQWM7OztNQUN0QixPQUFPLENBQUMsV0FBWTs7O01BQ3BCLE9BQU8sQ0FBQyxPQUFROztJQUNoQiwyQ0FBTSxPQUFOO0lBQ0EsSUFBQyxDQUFBLEtBQUssQ0FBQyxVQUFQLEdBQW9CO0lBQ3BCLElBQUMsQ0FBQSxLQUFLLENBQUMsT0FBUCxHQUFpQjtFQVhMOztzQkFhYixRQUFBLEdBQVUsU0FBQyxRQUFELEVBQVcsS0FBWCxFQUFrQixRQUFsQjs7TUFBa0IsV0FBVzs7SUFDdEMsSUFBQyxDQUFBLEtBQU0sQ0FBQSxRQUFBLENBQVAsR0FBc0IsUUFBSCxHQUFpQixLQUFBLEdBQU0sSUFBdkIsR0FBaUM7SUFDcEQsSUFBQyxDQUFBLElBQUQsQ0FBTSxT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QUdyQixPQUFPLENBQUMsT0FBUixHQUFrQixDQUFDLENBQUQsRUFBSSxDQUFKLEVBQU8sQ0FBUCIsImZpbGUiOiJnZW5lcmF0ZWQuanMiLCJzb3VyY2VSb290IjoiIiwic291cmNlc0NvbnRlbnQiOlsiKGZ1bmN0aW9uIGUodCxuLHIpe2Z1bmN0aW9uIHMobyx1KXtpZighbltvXSl7aWYoIXRbb10pe3ZhciBhPXR5cGVvZiByZXF1aXJlPT1cImZ1bmN0aW9uXCImJnJlcXVpcmU7aWYoIXUmJmEpcmV0dXJuIGEobywhMCk7aWYoaSlyZXR1cm4gaShvLCEwKTt2YXIgZj1uZXcgRXJyb3IoXCJDYW5ub3QgZmluZCBtb2R1bGUgJ1wiK28rXCInXCIpO3Rocm93IGYuY29kZT1cIk1PRFVMRV9OT1RfRk9VTkRcIixmfXZhciBsPW5bb109e2V4cG9ydHM6e319O3Rbb11bMF0uY2FsbChsLmV4cG9ydHMsZnVuY3Rpb24oZSl7dmFyIG49dFtvXVsxXVtlXTtyZXR1cm4gcyhuP246ZSl9LGwsbC5leHBvcnRzLGUsdCxuLHIpfXJldHVybiBuW29dLmV4cG9ydHN9dmFyIGk9dHlwZW9mIHJlcXVpcmU9PVwiZnVuY3Rpb25cIiYmcmVxdWlyZTtmb3IodmFyIG89MDtvPHIubGVuZ3RoO28rKylzKHJbb10pO3JldHVybiBzfSkiLCJjbGFzcyBUZXh0TGF5ZXIgZXh0ZW5kcyBMYXllclxuXHRcdFxuXHRjb25zdHJ1Y3RvcjogKG9wdGlvbnM9e30pIC0+XG5cdFx0QGRvQXV0b1NpemUgPSBmYWxzZVxuXHRcdEBkb0F1dG9TaXplSGVpZ2h0ID0gZmFsc2Vcblx0XHRvcHRpb25zLmJhY2tncm91bmRDb2xvciA/PSBpZiBvcHRpb25zLnNldHVwIHRoZW4gXCJoc2xhKDYwLCA5MCUsIDQ3JSwgLjQpXCIgZWxzZSBcInRyYW5zcGFyZW50XCJcblx0XHRvcHRpb25zLmNvbG9yID89IFwicmVkXCJcblx0XHRvcHRpb25zLmxpbmVIZWlnaHQgPz0gMS4yNVxuXHRcdG9wdGlvbnMuZm9udEZhbWlseSA/PSBcIkhlbHZldGljYVwiXG5cdFx0b3B0aW9ucy5mb250U2l6ZSA/PSAyMFxuXHRcdG9wdGlvbnMudGV4dCA/PSBcIlVzZSBsYXllci50ZXh0IHRvIGFkZCB0ZXh0XCJcblx0XHRzdXBlciBvcHRpb25zXG5cdFx0QHN0eWxlLndoaXRlU3BhY2UgPSBcInByZS1saW5lXCIgIyBhbGxvdyBcXG4gaW4gLnRleHRcblx0XHRAc3R5bGUub3V0bGluZSA9IFwibm9uZVwiICMgbm8gYm9yZGVyIHdoZW4gc2VsZWN0ZWRcblx0XHRcblx0c2V0U3R5bGU6IChwcm9wZXJ0eSwgdmFsdWUsIHB4U3VmZml4ID0gZmFsc2UpIC0+XG5cdFx0QHN0eWxlW3Byb3BlcnR5XSA9IGlmIHB4U3VmZml4IHRoZW4gdmFsdWUrXCJweFwiIGVsc2UgdmFsdWVcblx0XHRAZW1pdChcImNoYW5nZToje3Byb3BlcnR5fVwiLCB2YWx1ZSlcblx0XHRpZiBAZG9BdXRvU2l6ZSB0aGVuIEBjYWxjU2l6ZSgpXG5cdFx0XG5cdGNhbGNTaXplOiAtPlxuXHRcdHNpemVBZmZlY3RpbmdTdHlsZXMgPVxuXHRcdFx0bGluZUhlaWdodDogQHN0eWxlW1wibGluZS1oZWlnaHRcIl1cblx0XHRcdGZvbnRTaXplOiBAc3R5bGVbXCJmb250LXNpemVcIl1cblx0XHRcdGZvbnRXZWlnaHQ6IEBzdHlsZVtcImZvbnQtd2VpZ2h0XCJdXG5cdFx0XHRwYWRkaW5nVG9wOiBAc3R5bGVbXCJwYWRkaW5nLXRvcFwiXVxuXHRcdFx0cGFkZGluZ1JpZ2h0OiBAc3R5bGVbXCJwYWRkaW5nLXJpZ2h0XCJdXG5cdFx0XHRwYWRkaW5nQm90dG9tOiBAc3R5bGVbXCJwYWRkaW5nLWJvdHRvbVwiXVxuXHRcdFx0cGFkZGluZ0xlZnQ6IEBzdHlsZVtcInBhZGRpbmctbGVmdFwiXVxuXHRcdFx0dGV4dFRyYW5zZm9ybTogQHN0eWxlW1widGV4dC10cmFuc2Zvcm1cIl1cblx0XHRcdGJvcmRlcldpZHRoOiBAc3R5bGVbXCJib3JkZXItd2lkdGhcIl1cblx0XHRcdGxldHRlclNwYWNpbmc6IEBzdHlsZVtcImxldHRlci1zcGFjaW5nXCJdXG5cdFx0XHRmb250RmFtaWx5OiBAc3R5bGVbXCJmb250LWZhbWlseVwiXVxuXHRcdFx0Zm9udFN0eWxlOiBAc3R5bGVbXCJmb250LXN0eWxlXCJdXG5cdFx0XHRmb250VmFyaWFudDogQHN0eWxlW1wiZm9udC12YXJpYW50XCJdXG5cdFx0Y29uc3RyYWludHMgPSB7fVxuXHRcdGlmIEBkb0F1dG9TaXplSGVpZ2h0IHRoZW4gY29uc3RyYWludHMud2lkdGggPSBAd2lkdGhcblx0XHRzaXplID0gVXRpbHMudGV4dFNpemUgQHRleHQsIHNpemVBZmZlY3RpbmdTdHlsZXMsIGNvbnN0cmFpbnRzXG5cdFx0aWYgQHN0eWxlLnRleHRBbGlnbiBpcyBcInJpZ2h0XCJcblx0XHRcdEB3aWR0aCA9IHNpemUud2lkdGhcblx0XHRcdEB4ID0gQHgtQHdpZHRoXG5cdFx0ZWxzZVxuXHRcdFx0QHdpZHRoID0gc2l6ZS53aWR0aFxuXHRcdEBoZWlnaHQgPSBzaXplLmhlaWdodFxuXG5cdEBkZWZpbmUgXCJhdXRvU2l6ZVwiLFxuXHRcdGdldDogLT4gQGRvQXV0b1NpemVcblx0XHRzZXQ6ICh2YWx1ZSkgLT4gXG5cdFx0XHRAZG9BdXRvU2l6ZSA9IHZhbHVlXG5cdFx0XHRpZiBAZG9BdXRvU2l6ZSB0aGVuIEBjYWxjU2l6ZSgpXG5cdEBkZWZpbmUgXCJhdXRvU2l6ZUhlaWdodFwiLFxuXHRcdHNldDogKHZhbHVlKSAtPiBcblx0XHRcdEBkb0F1dG9TaXplID0gdmFsdWVcblx0XHRcdEBkb0F1dG9TaXplSGVpZ2h0ID0gdmFsdWVcblx0XHRcdGlmIEBkb0F1dG9TaXplIHRoZW4gQGNhbGNTaXplKClcblx0QGRlZmluZSBcImNvbnRlbnRFZGl0YWJsZVwiLFxuXHRcdHNldDogKGJvb2xlYW4pIC0+XG5cdFx0XHRAX2VsZW1lbnQuY29udGVudEVkaXRhYmxlID0gYm9vbGVhblxuXHRcdFx0QGlnbm9yZUV2ZW50cyA9ICFib29sZWFuXG5cdFx0XHRAb24gXCJpbnB1dFwiLCAtPiBAY2FsY1NpemUoKSBpZiBAZG9BdXRvU2l6ZVxuXHRAZGVmaW5lIFwidGV4dFwiLFxuXHRcdGdldDogLT4gQF9lbGVtZW50LnRleHRDb250ZW50XG5cdFx0c2V0OiAodmFsdWUpIC0+XG5cdFx0XHRAX2VsZW1lbnQudGV4dENvbnRlbnQgPSB2YWx1ZVxuXHRcdFx0QGVtaXQoXCJjaGFuZ2U6dGV4dFwiLCB2YWx1ZSlcblx0XHRcdGlmIEBkb0F1dG9TaXplIHRoZW4gQGNhbGNTaXplKClcblx0QGRlZmluZSBcImZvbnRGYW1pbHlcIiwgXG5cdFx0Z2V0OiAtPiBAc3R5bGUuZm9udEZhbWlseVxuXHRcdHNldDogKHZhbHVlKSAtPiBAc2V0U3R5bGUoXCJmb250RmFtaWx5XCIsIHZhbHVlKVxuXHRAZGVmaW5lIFwiZm9udFNpemVcIiwgXG5cdFx0Z2V0OiAtPiBAc3R5bGUuZm9udFNpemUucmVwbGFjZShcInB4XCIsXCJcIilcblx0XHRzZXQ6ICh2YWx1ZSkgLT4gQHNldFN0eWxlKFwiZm9udFNpemVcIiwgdmFsdWUsIHRydWUpXG5cdEBkZWZpbmUgXCJsaW5lSGVpZ2h0XCIsIFxuXHRcdGdldDogLT4gQHN0eWxlLmxpbmVIZWlnaHQgXG5cdFx0c2V0OiAodmFsdWUpIC0+IEBzZXRTdHlsZShcImxpbmVIZWlnaHRcIiwgdmFsdWUpXG5cdEBkZWZpbmUgXCJmb250V2VpZ2h0XCIsIFxuXHRcdGdldDogLT4gQHN0eWxlLmZvbnRXZWlnaHQgXG5cdFx0c2V0OiAodmFsdWUpIC0+IEBzZXRTdHlsZShcImZvbnRXZWlnaHRcIiwgdmFsdWUpXG5cdEBkZWZpbmUgXCJmb250U3R5bGVcIiwgXG5cdFx0Z2V0OiAtPiBAc3R5bGUuZm9udFN0eWxlXG5cdFx0c2V0OiAodmFsdWUpIC0+IEBzZXRTdHlsZShcImZvbnRTdHlsZVwiLCB2YWx1ZSlcblx0QGRlZmluZSBcImZvbnRWYXJpYW50XCIsIFxuXHRcdGdldDogLT4gQHN0eWxlLmZvbnRWYXJpYW50XG5cdFx0c2V0OiAodmFsdWUpIC0+IEBzZXRTdHlsZShcImZvbnRWYXJpYW50XCIsIHZhbHVlKVxuXHRAZGVmaW5lIFwicGFkZGluZ1wiLFxuXHRcdHNldDogKHZhbHVlKSAtPiBcblx0XHRcdEBzZXRTdHlsZShcInBhZGRpbmdUb3BcIiwgdmFsdWUsIHRydWUpXG5cdFx0XHRAc2V0U3R5bGUoXCJwYWRkaW5nUmlnaHRcIiwgdmFsdWUsIHRydWUpXG5cdFx0XHRAc2V0U3R5bGUoXCJwYWRkaW5nQm90dG9tXCIsIHZhbHVlLCB0cnVlKVxuXHRcdFx0QHNldFN0eWxlKFwicGFkZGluZ0xlZnRcIiwgdmFsdWUsIHRydWUpXG5cdEBkZWZpbmUgXCJwYWRkaW5nVG9wXCIsIFxuXHRcdGdldDogLT4gQHN0eWxlLnBhZGRpbmdUb3AucmVwbGFjZShcInB4XCIsXCJcIilcblx0XHRzZXQ6ICh2YWx1ZSkgLT4gQHNldFN0eWxlKFwicGFkZGluZ1RvcFwiLCB2YWx1ZSwgdHJ1ZSlcblx0QGRlZmluZSBcInBhZGRpbmdSaWdodFwiLCBcblx0XHRnZXQ6IC0+IEBzdHlsZS5wYWRkaW5nUmlnaHQucmVwbGFjZShcInB4XCIsXCJcIilcblx0XHRzZXQ6ICh2YWx1ZSkgLT4gQHNldFN0eWxlKFwicGFkZGluZ1JpZ2h0XCIsIHZhbHVlLCB0cnVlKVxuXHRAZGVmaW5lIFwicGFkZGluZ0JvdHRvbVwiLCBcblx0XHRnZXQ6IC0+IEBzdHlsZS5wYWRkaW5nQm90dG9tLnJlcGxhY2UoXCJweFwiLFwiXCIpXG5cdFx0c2V0OiAodmFsdWUpIC0+IEBzZXRTdHlsZShcInBhZGRpbmdCb3R0b21cIiwgdmFsdWUsIHRydWUpXG5cdEBkZWZpbmUgXCJwYWRkaW5nTGVmdFwiLFxuXHRcdGdldDogLT4gQHN0eWxlLnBhZGRpbmdMZWZ0LnJlcGxhY2UoXCJweFwiLFwiXCIpXG5cdFx0c2V0OiAodmFsdWUpIC0+IEBzZXRTdHlsZShcInBhZGRpbmdMZWZ0XCIsIHZhbHVlLCB0cnVlKVxuXHRAZGVmaW5lIFwidGV4dEFsaWduXCIsXG5cdFx0c2V0OiAodmFsdWUpIC0+IEBzZXRTdHlsZShcInRleHRBbGlnblwiLCB2YWx1ZSlcblx0QGRlZmluZSBcInRleHRUcmFuc2Zvcm1cIiwgXG5cdFx0Z2V0OiAtPiBAc3R5bGUudGV4dFRyYW5zZm9ybSBcblx0XHRzZXQ6ICh2YWx1ZSkgLT4gQHNldFN0eWxlKFwidGV4dFRyYW5zZm9ybVwiLCB2YWx1ZSlcblx0QGRlZmluZSBcImxldHRlclNwYWNpbmdcIiwgXG5cdFx0Z2V0OiAtPiBAc3R5bGUubGV0dGVyU3BhY2luZy5yZXBsYWNlKFwicHhcIixcIlwiKVxuXHRcdHNldDogKHZhbHVlKSAtPiBAc2V0U3R5bGUoXCJsZXR0ZXJTcGFjaW5nXCIsIHZhbHVlLCB0cnVlKVxuXHRAZGVmaW5lIFwibGVuZ3RoXCIsIFxuXHRcdGdldDogLT4gQHRleHQubGVuZ3RoXG5cbmNvbnZlcnRUb1RleHRMYXllciA9IChsYXllcikgLT5cblx0dCA9IG5ldyBUZXh0TGF5ZXJcblx0XHRuYW1lOiBsYXllci5uYW1lXG5cdFx0ZnJhbWU6IGxheWVyLmZyYW1lXG5cdFx0cGFyZW50OiBsYXllci5wYXJlbnRcblx0XG5cdGNzc09iaiA9IHt9XG5cdGNzcyA9IGxheWVyLl9pbmZvLm1ldGFkYXRhLmNzc1xuXHRjc3MuZm9yRWFjaCAocnVsZSkgLT5cblx0XHRyZXR1cm4gaWYgXy5jb250YWlucyBydWxlLCAnLyonXG5cdFx0YXJyID0gcnVsZS5zcGxpdCgnOiAnKVxuXHRcdGNzc09ialthcnJbMF1dID0gYXJyWzFdLnJlcGxhY2UoJzsnLCcnKVxuXHR0LnN0eWxlID0gY3NzT2JqXG5cdFxuXHRpbXBvcnRQYXRoID0gbGF5ZXIuX19mcmFtZXJJbXBvcnRlZEZyb21QYXRoXG5cdGlmIF8uY29udGFpbnMgaW1wb3J0UGF0aCwgJ0AyeCdcblx0XHR0LmZvbnRTaXplICo9IDJcblx0XHR0LmxpbmVIZWlnaHQgPSAocGFyc2VJbnQodC5saW5lSGVpZ2h0KSoyKSsncHgnXG5cdFx0dC5sZXR0ZXJTcGFjaW5nICo9IDJcblx0XHRcdFx0XHRcblx0dC55IC09IChwYXJzZUludCh0LmxpbmVIZWlnaHQpLXQuZm9udFNpemUpLzIgIyBjb21wZW5zYXRlIGZvciBob3cgQ1NTIGhhbmRsZXMgbGluZSBoZWlnaHRcblx0dC55IC09IHQuZm9udFNpemUgKiAwLjEgIyBza2V0Y2ggcGFkZGluZ1xuXHR0LnggLT0gdC5mb250U2l6ZSAqIDAuMDggIyBza2V0Y2ggcGFkZGluZ1xuXHR0LndpZHRoICs9IHQuZm9udFNpemUgKiAwLjUgIyBza2V0Y2ggcGFkZGluZ1xuXG5cdHQudGV4dCA9IGxheWVyLl9pbmZvLm1ldGFkYXRhLnN0cmluZ1xuXHRsYXllci5kZXN0cm95KClcblx0cmV0dXJuIHRcblxuTGF5ZXI6OmNvbnZlcnRUb1RleHRMYXllciA9IC0+IGNvbnZlcnRUb1RleHRMYXllcihAKVxuXG5jb252ZXJ0VGV4dExheWVycyA9IChvYmopIC0+XG5cdGZvciBwcm9wLGxheWVyIG9mIG9ialxuXHRcdGlmIGxheWVyLl9pbmZvLmtpbmQgaXMgXCJ0ZXh0XCJcblx0XHRcdG9ialtwcm9wXSA9IGNvbnZlcnRUb1RleHRMYXllcihsYXllcilcblxuIyBCYWNrd2FyZHMgY29tcGFiaWxpdHkuIFJlcGxhY2VkIGJ5IGNvbnZlcnRUb1RleHRMYXllcigpXG5MYXllcjo6ZnJhbWVBc1RleHRMYXllciA9IChwcm9wZXJ0aWVzKSAtPlxuICAgIHQgPSBuZXcgVGV4dExheWVyXG4gICAgdC5mcmFtZSA9IEBmcmFtZVxuICAgIHQuc3VwZXJMYXllciA9IEBzdXBlckxheWVyXG4gICAgXy5leHRlbmQgdCxwcm9wZXJ0aWVzXG4gICAgQGRlc3Ryb3koKVxuICAgIHRcblxuZXhwb3J0cy5UZXh0TGF5ZXIgPSBUZXh0TGF5ZXJcbmV4cG9ydHMuY29udmVydFRleHRMYXllcnMgPSBjb252ZXJ0VGV4dExheWVyc1xuIiwiIyMjXG4gIEZyYW1lcktpdCBmb3IgRnJhbWVyXG4gIGh0dHBzOi8vZ2l0aHViLmNvbS9yYXBoZGFtaWNvL2ZyYW1lcktpdFxuXG4gIENvcHlyaWdodCAoYykgMjAxNSwgUmFwaCBEJ0FtaWNvIGh0dHA6Ly9yYXBoZGFtaWNvLmNvbSAoQHJhcGhkYW1pY28pXG4gIE1JVCBMaWNlbnNlXG5cbiAgUmVhZG1lOlxuICBodHRwczovL2dpdGh1Yi5jb20vcmFwaGRhbWljby9mcmFtZXJLaXRcblxuICBMaWNlbnNlOlxuICBodHRwczovL2dpdGh1Yi5jb20vcmFwaGRhbWljby9mcmFtZXJLaXQvYmxvYi9tYXN0ZXIvTElDRU5TRS5tZFxuIyMjXG5cblxuXG5cbiMjI1xuXHRERUZBVUxUIFNUWUxFU1xuXHROb3RlIHRoZSBzY3JlZW53aWR0aCBjb25zdGFudDogdGhpcyBpcyBwcm9iYWJseSBvbmUgb2YgdGhlXG5cdGZpcnN0IHRoaW5ncyB5b3Ugd2FudCB0byBjaGFuZ2Ugc28gaXQgbWF0Y2hlcyB0aGUgZGV2aWNlXG5cdHlvdSdyZSBwcm90b3R5cGluZyBvbi5cbiMjI1xuZGVmYXVsdHMgPSB7XG5cdHNjcmVlbldpZHRoOiA3NTBcbn1cblxuIyMjXG5cdE1PUkUgU1RZTEVTXG4jIyNcbmRlZmF1bHRzLnRhYmxlUm93SGVpZ2h0ID0gODhcbmRlZmF1bHRzLnRhYmxlUm93SG9yaXpvbnRhbFBhZGRpbmcgPSAyMFxuZGVmYXVsdHMudGludCA9ICdncmV5J1xuZGVmYXVsdHMubGluZVRpbnQgPSBcInJnYmEoMjAwLDIwMCwyMDAsMSlcIlxuZGVmYXVsdHMuc3dpdGNoVGludCA9ICcjMURDMjRCJ1xuZGVmYXVsdHMuaXRlbUJhY2tncm91bmQgPSAnd2hpdGUnXG5kZWZhdWx0cy5saXN0SXRlbVRleHRTdHlsZSA9IHtcblx0Zm9udFNpemU6IFwiMzJweFwiXG5cdGxpbmVIZWlnaHQ6IChkZWZhdWx0cy50YWJsZVJvd0hlaWdodC00KStcInB4XCJcdFx0XG5cdGZvbnRGYW1pbHk6IFwiSGVsdmV0aWNhIE5ldWVcIlxuXHRmb250V2VpZ2h0OiBcIjIwMFwiXG59XG5kZWZhdWx0cy5kaXZpZGVySXRlbVRleHRTdHlsZSA9IHtcblx0Zm9udFNpemU6IFwiMjJweFwiXG5cdGxpbmVIZWlnaHQ6IChkZWZhdWx0cy50YWJsZVJvd0hlaWdodC00KStcInB4XCJcdFx0XG5cdGZvbnRGYW1pbHk6IFwiSGVsdmV0aWNhIE5ldWVcIlxuXHRmb250V2VpZ2h0OiBcIjIwMFwiXG5cdHRleHRUcmFuc2Zvcm06ICd1cHBlcmNhc2UnXG59XG5kZWZhdWx0cy5waWNrZXJUZXh0U3R5bGUgPSB7XG5cdGZvbnRTaXplOiBcdFx0XCI0MnB4XCJcblx0Zm9udEZhbWlseTogXHRcIkhlbHZldGljYSBOZXVlXCJcblx0Zm9udFdlaWdodDogXHRcIjIwMFwiXG59XG5leHBvcnRzLmRlZmF1bHRzID0gZGVmYXVsdHNcblxuXG4jIyNcblx0VEFCTEUgVklFVyBFTEVNRU5UU1xuXHQoZS5nLiBcIlRodW1iXCIgZm9yIHRoZSBzd2l0Y2ggY29udHJvbClcbiMjI1xuXG5Td2l0Y2ggPSAocGFyYW1zKSAtPlxuXHRwYXJhbXMgPSBwYXJhbXMgb3Ige31cblx0Xy5kZWZhdWx0cyBwYXJhbXMsIFxuXHRcdHN3aXRjaFRpbnQ6IGRlZmF1bHRzLnN3aXRjaFRpbnRcblx0XHRzY3JlZW5XaWR0aDogZGVmYXVsdHMuc2NyZWVuV2lkdGhcblx0XHR0YWJsZVJvd0hlaWdodDogZGVmYXVsdHMudGFibGVSb3dIZWlnaHRcblx0XHRzd2l0Y2hDb250YWluZXJCb3JkZXI6IDRcblx0XHRzd2l0Y2hDb250YWluZXJIZWlnaHQ6IDU0XG5cdFx0c3dpdGNoQ29udGFpbmVyV2lkdGg6IDk0XG5cdFx0Ym9yZGVyQ29sb3I6IGRlZmF1bHRzLmxpbmVUaW50ICMgR3JleSByb3VuZGVkIHBpbGwgJiBib3JkZXJzIGJldHdlZW4gY2VsbHNcblxuXHRAc2VsZWN0ZWQgPSB0cnVlXG5cdFxuXHQjIFNvbWUgb2YgdGhlIHZhbHVlcyBhcmUgYmFzZWQgb24gb3RoZXIgY29uc3RhbnRzLFxuXHQjIHNvIHlvdSBoYXZlIHRvIGNhbGN1bGF0ZSB0aGVtIGluIGEgc2Vjb25kIHBhc3Ncblx0c3dpdGNoQnV0dG9uUmFkaXVzID0gcGFyYW1zLnN3aXRjaENvbnRhaW5lckhlaWdodC8yXG5cdHNocnVua2VuQmFja2dyb3VuZERpYW1ldGVyID0gMlxuXHRcblx0IyBUaGlzIGlzIG91ciBmYW5jeSBhbmltYXRlZCBzd2l0Y2ggc3dpdGNoXG5cdCMgd2UgbmVlZCB0byBtYWtlIGEgcm91bmRlZCByZWN0YW5nbGUgd2l0aCBhIGNpcmNsZSBpbnNpZGUgaXQuXG5cdEBzd2l0Y2hCdXR0b25Db250YWluZXIgPSBuZXcgTGF5ZXJcblx0XHR4OiBcdFx0XHRcdFx0MFxuXHRcdHk6IFx0XHRcdFx0XHQwXG5cdFx0Y2xpcDogXHRcdFx0XHRmYWxzZSAjIENsaXBwaW5nIGh1cnRzIHRoZSBzdWJ0bGUgc2hhZG93IG9uIHRoZSBidXR0b25cblx0XHR3aWR0aDpcdFx0XHRcdHBhcmFtcy5zd2l0Y2hDb250YWluZXJXaWR0aCBcblx0XHRoZWlnaHQ6XHRcdFx0XHRwYXJhbXMuc3dpdGNoQ29udGFpbmVySGVpZ2h0XG5cdFx0YmFja2dyb3VuZENvbG9yOiBcdFwiXCJcblx0XHRvcGFjaXR5OiBcdFx0XHQxXG5cblx0QHN3aXRjaEJhY2tncm91bmQgPSBuZXcgTGF5ZXJcblx0XHR4Olx0XHRcdFx0XHRzd2l0Y2hCdXR0b25SYWRpdXMgLSBzaHJ1bmtlbkJhY2tncm91bmREaWFtZXRlci8yXG5cdFx0eTpcdFx0XHRcdFx0c3dpdGNoQnV0dG9uUmFkaXVzIC0gc2hydW5rZW5CYWNrZ3JvdW5kRGlhbWV0ZXIvMiAtIDRcblx0XHR3aWR0aDogXHRcdFx0XHRwYXJhbXMuc3dpdGNoQ29udGFpbmVyV2lkdGggLSBwYXJhbXMuc3dpdGNoQ29udGFpbmVySGVpZ2h0ICsgc2hydW5rZW5CYWNrZ3JvdW5kRGlhbWV0ZXJcblx0XHRoZWlnaHQ6IFx0XHRcdHBhcmFtcy5zd2l0Y2hDb250YWluZXJIZWlnaHQgLSBwYXJhbXMuc3dpdGNoQ29udGFpbmVySGVpZ2h0ICsgc2hydW5rZW5CYWNrZ3JvdW5kRGlhbWV0ZXJcblx0XHRib3JkZXJSYWRpdXM6IFx0XHRwYXJhbXMuc3dpdGNoQ29udGFpbmVySGVpZ2h0XG5cdFx0c2hhZG93U3ByZWFkOlx0XHRzd2l0Y2hCdXR0b25SYWRpdXMgLSBzaHJ1bmtlbkJhY2tncm91bmREaWFtZXRlci8yICsgcGFyYW1zLnN3aXRjaENvbnRhaW5lckJvcmRlclxuXHRcdHNoYWRvd0NvbG9yOiBcdFx0cGFyYW1zLnN3aXRjaFRpbnRcblx0XHRiYWNrZ3JvdW5kQ29sb3I6IFx0Jydcblx0XHRvcGFjaXR5OiBcdFx0XHQxXG5cdFx0c3VwZXJMYXllcjogXHRcdEBzd2l0Y2hCdXR0b25Db250YWluZXJcblx0XHRcblx0QHN3aXRjaEJ1dHRvbiA9IG5ldyBMYXllclxuXHRcdHg6IHBhcmFtcy5zd2l0Y2hDb250YWluZXJXaWR0aCAtIHBhcmFtcy5zd2l0Y2hDb250YWluZXJIZWlnaHRcblx0XHR5OiAtNFxuXHRcdHdpZHRoOlx0XHRcdFx0c3dpdGNoQnV0dG9uUmFkaXVzKjJcblx0XHRoZWlnaHQ6XHRcdFx0XHRzd2l0Y2hCdXR0b25SYWRpdXMqMlxuXHRcdGJvcmRlclJhZGl1czogXHRcdHN3aXRjaEJ1dHRvblJhZGl1c1xuXHRcdHNoYWRvd1k6XHRcdFx0M1xuXHRcdHNoYWRvd0JsdXI6IFx0XHQ1XG5cdFx0c2hhZG93Q29sb3I6IFx0XHQncmdiYSgwLDAsMCwwLjMpJ1xuXHRcdGJhY2tncm91bmRDb2xvcjogXHRcIndoaXRlXCJcblx0XHRvcGFjaXR5OiBcdFx0XHQxXG5cdFx0c3VwZXJMYXllcjogXHRcdEBzd2l0Y2hCdXR0b25Db250YWluZXJcblx0XG5cdCMgU0VUIFVQIEFOSU1BVElPTlNcblx0QHN3aXRjaEJhY2tncm91bmQuc3RhdGVzLmFkZFxuXHRcdGRlc2VsZWN0ZWQ6IFxuXHRcdFx0eDogXHRcdFx0XHQwXG5cdFx0XHR5OiBcdFx0XHRcdC00XG5cdFx0XHR3aWR0aDpcdFx0XHRwYXJhbXMuc3dpdGNoQ29udGFpbmVyV2lkdGhcblx0XHRcdGhlaWdodDpcdFx0XHRwYXJhbXMuc3dpdGNoQ29udGFpbmVySGVpZ2h0XG5cdFx0XHRzaGFkb3dTcHJlYWQ6IFx0cGFyYW1zLnN3aXRjaENvbnRhaW5lckJvcmRlclxuXHRcdFx0c2F0dXJhdGU6IFx0XHQwXG5cdFx0XHRicmlnaHRuZXNzOiBcdDE1M1xuXHRcdFx0YmFja2dyb3VuZENvbG9yOiBcIlwiXG5cdEBzd2l0Y2hCYWNrZ3JvdW5kLnN0YXRlcy5hbmltYXRpb25PcHRpb25zID1cblx0XHRjdXJ2ZTogXCJlYXNlLWluLW91dFwiXG5cdFx0dGltZTogMC4zIFxuXHRAc3dpdGNoQmFja2dyb3VuZC5vbiBFdmVudHMuQW5pbWF0aW9uRW5kLCA9PlxuXHRcdFV0aWxzLmRlbGF5IDAsID0+XG5cdCBcdFx0aWYgQHNlbGVjdGVkXG4gXHRcdFx0XHRAc3dpdGNoQmFja2dyb3VuZC5iYWNrZ3JvdW5kQ29sb3IgPSBwYXJhbXMuc3dpdGNoVGludFxuXG5cdEBzd2l0Y2hCYWNrZ3JvdW5kLm9uIEV2ZW50cy5BbmltYXRpb25TdGFydCwgPT5cblx0XHRAc3dpdGNoQmFja2dyb3VuZC5iYWNrZ3JvdW5kQ29sb3IgPSAnJ1xuXG5cdEBzd2l0Y2hCdXR0b24uc3RhdGVzLmFkZFxuXHRcdGRlc2VsZWN0ZWQ6IHt4OiAwfVxuXHRAc3dpdGNoQnV0dG9uLnN0YXRlcy5hbmltYXRpb25PcHRpb25zID1cblx0XHRjdXJ2ZTogXCJzcHJpbmcoNDAwLDI1LDApXCJcblx0XHRcblx0QHN3aXRjaEJ1dHRvbkNvbnRhaW5lci5zZWxlY3QgPSA9PlxuXHRcdEBzZWxlY3RlZCA9IHRydWVcblx0XHRAc3dpdGNoQmFja2dyb3VuZC5zdGF0ZXMuc3dpdGNoKFwiZGVmYXVsdFwiKVxuXHRcdEBzd2l0Y2hCdXR0b24uc3RhdGVzLnN3aXRjaChcImRlZmF1bHRcIilcblx0XHRcblx0QHN3aXRjaEJ1dHRvbkNvbnRhaW5lci5kZXNlbGVjdCA9ID0+XG5cdFx0QHNlbGVjdGVkID0gZmFsc2Vcblx0XHRAc3dpdGNoQmFja2dyb3VuZC5zdGF0ZXMuc3dpdGNoKFwiZGVzZWxlY3RlZFwiKVxuXHRcdEBzd2l0Y2hCdXR0b24uc3RhdGVzLnN3aXRjaChcImRlc2VsZWN0ZWRcIilcblxuXHRpZiBAc2VsZWN0ZWQgPT0gZmFsc2Vcblx0XHRAc3dpdGNoQmFja2dyb3VuZC5zdGF0ZXMuc3dpdGNoSW5zdGFudChcImRlc2VsZWN0ZWRcIilcblx0XHRAc3dpdGNoQnV0dG9uLnN0YXRlcy5zd2l0Y2hJbnN0YW50KFwiZGVzZWxlY3RlZFwiKVxuXHRlbHNlXG5cdFx0QHN3aXRjaEJhY2tncm91bmQuYmFja2dyb3VuZENvbG9yID0gcGFyYW1zLnN3aXRjaFRpbnRcblxuXHRyZXR1cm4gQHN3aXRjaEJ1dHRvbkNvbnRhaW5lclxuXHRcbkNyb3NzID0gLT5cblx0Y29sb3IgPSBkZWZhdWx0cy50aW50XG5cdGNyb3NzVGhpY2tuZXNzID0gNFxuXHRjcm9zcyA9IG5ldyBMYXllclxuXHRcdHdpZHRoOiAzMFx0XG5cdFx0aGVpZ2h0OiAzMFx0XG5cdFx0YmFja2dyb3VuZENvbG9yOiAnbm9uZSdcblx0Y3Jvc3NVcHN0cm9rZSA9IG5ldyBMYXllclxuXHRcdGhlaWdodDogY3Jvc3NUaGlja25lc3Ncblx0XHR3aWR0aDogMjBcblx0XHRiYWNrZ3JvdW5kQ29sb3I6IGNvbG9yXG5cdFx0b3JpZ2luWDogMVxuXHRcdHN1cGVyTGF5ZXI6IGNyb3NzXG5cdGNyb3NzVXBzdHJva2UueSA9IDE0XG5cdGNyb3NzVXBzdHJva2Uucm90YXRpb25aID0gNDVcblx0Y3Jvc3NEb3duc3Ryb2tlID0gbmV3IExheWVyXG5cdFx0aGVpZ2h0OiBjcm9zc1RoaWNrbmVzc1xuXHRcdHdpZHRoOiAyMFxuXHRcdG9yaWdpblg6IDFcblx0XHRiYWNrZ3JvdW5kQ29sb3I6IGNvbG9yXG5cdFx0c3VwZXJMYXllcjogY3Jvc3Ncblx0Y3Jvc3NEb3duc3Ryb2tlLnJvdGF0aW9uWiA9IC00NVxuXHRjcm9zcy5zZWxlY3QgPSAtPlxuXHRcdGNyb3NzLmFuaW1hdGVcblx0XHRcdHByb3BlcnRpZXM6XG5cdFx0XHRcdG9wYWNpdHk6IDFcblx0XHRcdFx0c2NhbGU6IDFcblx0XHRcdGN1cnZlOiAnc3ByaW5nKDQwMCwxNSwwKSdcblx0Y3Jvc3MuZGVzZWxlY3QgPSAtPlxuXHRcdGNyb3NzLmFuaW1hdGVcblx0XHRcdHByb3BlcnRpZXM6XG5cdFx0XHRcdG9wYWNpdHk6IDBcblx0XHRcdFx0c2NhbGU6IDAuNFxuXHRcdFx0Y3VydmU6ICdzcHJpbmcoNDAwLDE1LDApJ1x0XHRcblx0cmV0dXJuIGNyb3NzXG5cdFxuQ2FyZXQgPSAtPlxuXHRjb2xvciA9IGRlZmF1bHRzLnRpbnRcblx0Y2FyZXRUaGlja25lc3MgPSA0XG5cdGNhcmV0ID0gbmV3IExheWVyXG5cdFx0d2lkdGg6IDMwXG5cdFx0aGVpZ2h0OiAzMFxuXHRcdGJhY2tncm91bmRDb2xvcjogJ25vbmUnXHRcdFxuXHRjYXJldFVwc3Ryb2tlID0gbmV3IExheWVyXG5cdFx0aGVpZ2h0OiBjYXJldFRoaWNrbmVzc1xuXHRcdHdpZHRoOiAxOFxuXHRcdGJhY2tncm91bmRDb2xvcjogY29sb3Jcblx0XHRvcmlnaW5YOiAxXG5cdFx0c3VwZXJMYXllcjogY2FyZXRcblx0Y2FyZXRVcHN0cm9rZS55ID0gMTRcblx0Y2FyZXRVcHN0cm9rZS5yb3RhdGlvblogPSA0NVxuXHRjYXJldERvd25zdHJva2UgPSBuZXcgTGF5ZXJcblx0XHRoZWlnaHQ6IGNhcmV0VGhpY2tuZXNzXG5cdFx0d2lkdGg6IDE4XG5cdFx0b3JpZ2luWDogMVxuXHRcdGJhY2tncm91bmRDb2xvcjogY29sb3Jcblx0XHRzdXBlckxheWVyOiBjYXJldFxuXHRjYXJldERvd25zdHJva2UueSA9IDEyXHRcdFxuXHRjYXJldERvd25zdHJva2Uucm90YXRpb25aID0gLTQ1XG5cdGNhcmV0LnNlbGVjdCA9IC0+XG5cdFx0Y2FyZXQuYW5pbWF0ZVxuXHRcdFx0cHJvcGVydGllczpcblx0XHRcdFx0b3BhY2l0eTogMVxuXHRcdFx0XHRzY2FsZTogMVxuXHRcdFx0Y3VydmU6ICdzcHJpbmcoNDAwLDE1LDApJ1xuXHRjYXJldC5kZXNlbGVjdCA9IC0+XG5cdFx0Y2FyZXQuYW5pbWF0ZVxuXHRcdFx0cHJvcGVydGllczpcblx0XHRcdFx0b3BhY2l0eTogMFxuXHRcdFx0XHRzY2FsZTogMC40XG5cdFx0XHRjdXJ2ZTogJ3NwcmluZyg0MDAsMTUsMCknXHRcblx0cmV0dXJuIGNhcmV0XG5cdFxuQ2hlY2sgPSAtPlxuXHRjb2xvciA9IGRlZmF1bHRzLnRpbnRcblx0Y2hlY2tUaGlja25lc3MgPSA0XG5cdGNoZWNrID0gbmV3IExheWVyXG5cdFx0d2lkdGg6IDMwXG5cdFx0aGVpZ2h0OiAzMFxuXHRcdGJhY2tncm91bmRDb2xvcjogJ25vbmUnXG5cdGNoZWNrVXBzdHJva2UgPSBuZXcgTGF5ZXJcblx0XHRoZWlnaHQ6IGNoZWNrVGhpY2tuZXNzXG5cdFx0d2lkdGg6IDEzXG5cdFx0YmFja2dyb3VuZENvbG9yOiBjb2xvclxuXHRcdG9yaWdpblg6IDFcblx0XHRzdXBlckxheWVyOiBjaGVja1xuXHRjaGVja1Vwc3Ryb2tlLnkgPSAxNlxuXHRjaGVja1Vwc3Ryb2tlLnJvdGF0aW9uWiA9IDQ1XG5cdGNoZWNrRG93bnN0cm9rZSA9IG5ldyBMYXllclxuXHRcdGhlaWdodDogY2hlY2tUaGlja25lc3Ncblx0XHR3aWR0aDogMjJcblx0XHRvcmlnaW5YOiAxXG5cdFx0YmFja2dyb3VuZENvbG9yOiBjb2xvclxuXHRcdHN1cGVyTGF5ZXI6IGNoZWNrXHRcblx0Y2hlY2tEb3duc3Ryb2tlLnggPSA0XG5cdGNoZWNrRG93bnN0cm9rZS5yb3RhdGlvblogPSAtNDVcblx0Y2hlY2suc2VsZWN0ID0gLT5cblx0XHRjaGVjay5hbmltYXRlXG5cdFx0XHRwcm9wZXJ0aWVzOlxuXHRcdFx0XHRvcGFjaXR5OiAxXG5cdFx0XHRcdHNjYWxlOiAxXG5cdFx0XHRjdXJ2ZTogJ3NwcmluZyg0MDAsMTUsMCknXG5cdGNoZWNrLmRlc2VsZWN0ID0gLT5cblx0XHRjaGVjay5hbmltYXRlXG5cdFx0XHRwcm9wZXJ0aWVzOlxuXHRcdFx0XHRvcGFjaXR5OiAwXG5cdFx0XHRcdHNjYWxlOiAwLjRcblx0XHRcdGN1cnZlOiAnc3ByaW5nKDQwMCwxNSwwKSdcblx0cmV0dXJuIGNoZWNrXG5cblxuIyMjXG5cdFRBQkxFIFZJRVdcblx0XG5cdC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tXG5cdFRhYmxlVmlld1Jvd1x0XHRbRWxlbWVudHMgZ28gaGVyZV1cblx0LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS1cblxuIyMjXG5cbmV4cG9ydHMuVGFibGVWaWV3Um93ID0gKHBhcmFtcykgLT5cblx0XG5cdCMgVGhlIHRyaWNreSB0aGluZyBhYm91dCByZXVzYWJsZSBjb21wb25lbnRzIGlzIHJlbWVtYmVyaW5nXG5cdCMgaG93IHRvIHVzZSB0aGVtIChwYXJ0aWN1bGFybHkgaWYgdGhleSBoYXZlIGxvdHMgb2YgY3VzdG9taXphYmxlXG5cdCMgcGFyYW1ldGVycykuIFNldHRpbmcgc2Vuc2libGUgZGVmYXVsdHMgbWFrZXMgaXQgd2F5IGVhc2llciB0byBnZXRcblx0IyBzdGFydGVkIChhbmQgcmVtZW1iZXIgaG93IHRvIHVzZSB0aGUgdGhpbmcgeW91IG1hZGUpXG5cdF8uZGVmYXVsdHMgcGFyYW1zLCBcblx0XHRuYW1lOiAnR2l2ZSBtZSBhIG5hbWUhJ1xuXHRcdHg6IDBcblx0XHR5OiAwXG5cdFx0ZW5hYmxlZDogdHJ1ZVxuXHRcdHNlbGVjdGVkOiB0cnVlXG5cdFx0aWNvbjogJ2NoZWNrJ1xuXHRcdHRleHRDb2xvcjogZGVmYXVsdHMudGludFxuXHRcdHN3aXRjaFRpbnQ6IGRlZmF1bHRzLnN3aXRjaFRpbnRcblx0XHRmaXJzdEl0ZW1Jbkxpc3Q6IHRydWUgIyBjb3VsZCBiZSBmaXJzdCBvciBsYXN0XG5cdFx0bGFzdEl0ZW1Jbkxpc3Q6IHRydWUgIyBjb3VsZCBiZSBmaXJzdCBvciBsYXN0XG5cdFx0XG5cdFx0IyBDb25zdGFudHNcblx0XHRzY3JlZW5XaWR0aDogZGVmYXVsdHMuc2NyZWVuV2lkdGhcblx0XHR0YWJsZVJvd0hvcml6b250YWxQYWRkaW5nOiBkZWZhdWx0cy50YWJsZVJvd0hvcml6b250YWxQYWRkaW5nXG5cdFx0dGFibGVSb3dIZWlnaHQ6IGRlZmF1bHRzLnRhYmxlUm93SGVpZ2h0XG5cdFx0Ym9yZGVyQ29sb3I6IGRlZmF1bHRzLmxpbmVUaW50ICMgR3JleSByb3VuZGVkIHBpbGwgJiBib3JkZXJzIGJldHdlZW4gY2VsbHNcblxuXHQjIFNvbWUgb2YgdGhlIHZhbHVlcyBhcmUgYmFzZWQgb24gb3RoZXIgY29uc3RhbnRzLFxuXHQjIHNvIHlvdSBoYXZlIHRvIGNhbGN1bGF0ZSB0aGVtIGluIGEgc2Vjb25kIHBhc3Ncblx0c3dpdGNoQnV0dG9uUmFkaXVzID0gcGFyYW1zLnN3aXRjaENvbnRhaW5lckhlaWdodC8yXG5cdHNocnVua2VuQmFja2dyb3VuZERpYW1ldGVyID0gMlxuXHRcdFxuXHQjIFRoaXMgaXMgdGhlIHJvb3Qgb2JqZWN0IGZvciB0aGlzIGVudGlyZSBjb21wb25lbnQuXG5cdCMgV2Ugd2lsbCBhdHRhY2ggYWxsIG91ciBmdW5jdGlvbnMgZGlyZWN0bHkgdG8gdGhpcyBsYXllclxuXHRAbGlzdEl0ZW1Db250YWluZXIgPSBuZXcgTGF5ZXJcblx0XHR4OiBwYXJhbXMueFxuXHRcdHk6IHBhcmFtcy55XG5cdFx0d2lkdGg6IFx0ZGVmYXVsdHMuc2NyZWVuV2lkdGhcblx0XHRoZWlnaHQ6IGRlZmF1bHRzLnRhYmxlUm93SGVpZ2h0XG5cdFx0Y2xpcDogZmFsc2Vcblx0XHRiYWNrZ3JvdW5kQ29sb3I6IGRlZmF1bHRzLml0ZW1CYWNrZ3JvdW5kXG5cdEBsaXN0SXRlbUNvbnRhaW5lci5zdHlsZSA9IFxuXHRcdGJvcmRlclRvcDogXHRcdGlmIHBhcmFtcy5maXJzdEl0ZW1Jbkxpc3QgdGhlbiBcIjFweCBzb2xpZCBcIiArIHBhcmFtcy5ib3JkZXJDb2xvciBlbHNlIFwiXCJcblx0XHRib3JkZXJCb3R0b206IFx0aWYgcGFyYW1zLmxhc3RJdGVtSW5MaXN0IHRoZW4gXCIxcHggc29saWQgXCIgKyBwYXJhbXMuYm9yZGVyQ29sb3IgZWxzZSBcIlwiXG5cblx0IyBUaGVzZSB3aWxsIGJlIGFjY2Vzc2VkIHVzaW5nIGZ1bmN0aW9uc1xuXHRAZW5hYmxlZCA9IHBhcmFtcy5lbmFibGVkXG5cdEBzZWxlY3RlZCA9IHBhcmFtcy5zZWxlY3RlZFxuXHRcblx0QGxpc3RJdGVtID0gbmV3IExheWVyIFxuXHRcdHg6IHBhcmFtcy50YWJsZVJvd0hvcml6b250YWxQYWRkaW5nXG5cdFx0d2lkdGg6IFx0ZGVmYXVsdHMuc2NyZWVuV2lkdGhcblx0XHRoZWlnaHQ6IGRlZmF1bHRzLnRhYmxlUm93SGVpZ2h0XG5cdFx0c3VwZXJMYXllcjogQGxpc3RJdGVtQ29udGFpbmVyXG5cdFx0YmFja2dyb3VuZENvbG9yOiAnbm9uZSdcdFxuXHRAbGlzdEl0ZW0uc3R5bGUgPSBkZWZhdWx0cy5saXN0SXRlbVRleHRTdHlsZVxuXHRAbGlzdEl0ZW0uc3R5bGUgPVxuXHRcdGNvbG9yOiBwYXJhbXMudGV4dENvbG9yXG5cdFx0Ym9yZGVyVG9wOiBcdGlmIHBhcmFtcy5maXJzdEl0ZW1Jbkxpc3QgdGhlbiBcIlwiIGVsc2UgXCIxcHggc29saWQgXCIgKyBwYXJhbXMuYm9yZGVyQ29sb3JcblxuXHQjIFRoaXMgaXMgd2hlcmUgdGhlIGxhYmVsIG9mIHRoZSBsaXN0IGl0ZW0gbGl2ZXNcblx0QGxpc3RJdGVtLmh0bWwgPSBwYXJhbXMubmFtZSBcblxuXHQjIEFkZCB0aGUgY2hlY2ttYXJrIGZvciB0aGUgbGlzdFxuXHR0aGluZ1RvU3dpdGNoID0gc3dpdGNoXG5cdFx0d2hlbiBwYXJhbXMuaWNvbiA9PSAnY2hlY2snIHRoZW4gbmV3IENoZWNrKClcblx0XHR3aGVuIHBhcmFtcy5pY29uID09ICdjcm9zcycgdGhlbiBuZXcgQ3Jvc3MoKVxuXHRcdHdoZW4gcGFyYW1zLmljb24gPT0gJ2NhcmV0JyB0aGVuIG5ldyBDYXJldCgpXG5cdFx0d2hlbiBwYXJhbXMuaWNvbiA9PSAnc3dpdGNoJyB0aGVuIG5ldyBTd2l0Y2goKVxuXG5cdHRoaW5nVG9Td2l0Y2guc3VwZXJMYXllciA9IEBsaXN0SXRlbUNvbnRhaW5lclxuXHR0aGluZ1RvU3dpdGNoLnggPSBkZWZhdWx0cy5zY3JlZW5XaWR0aCAtIHRoaW5nVG9Td2l0Y2gud2lkdGggLSBkZWZhdWx0cy50YWJsZVJvd0hvcml6b250YWxQYWRkaW5nXG5cdHRoaW5nVG9Td2l0Y2guY2VudGVyWSgyKVxuIyBcdHRoaW5nVG9Td2l0Y2gueSA9IC1kZWZhdWx0cy50YWJsZVJvd0hlaWdodC8yIC0gdGhpbmdUb1N3aXRjaC5oZWlnaHQvMlxuXHRcblx0IyBNQUtFIElUIEFMTCBJTlRFUkFDVElWRVxuXHQjIE9uIGEgY2xpY2ssIGdvIHRvIHRoZSBuZXh0IHN0YXRlXG5cdGlmIHBhcmFtcy5pY29uID09ICdzd2l0Y2gnXG5cdFx0dGhpbmdUb1N3aXRjaC5vbiBFdmVudHMuQ2xpY2ssID0+XG5cdFx0XHRAbGlzdEl0ZW1Db250YWluZXIuc3dpdGNoKClcblx0ZWxzZSBcblx0XHRAbGlzdEl0ZW0ub24gRXZlbnRzLkNsaWNrLCA9PlxuXHRcdFx0QGxpc3RJdGVtQ29udGFpbmVyLnN3aXRjaCgpXG5cblx0QGxpc3RJdGVtQ29udGFpbmVyLnN3aXRjaCA9ID0+XG5cdFx0aWYgQHNlbGVjdGVkIHRoZW4gQGxpc3RJdGVtQ29udGFpbmVyLmRlc2VsZWN0KCkgZWxzZSBAbGlzdEl0ZW1Db250YWluZXIuc2VsZWN0KClcblx0XHRcblx0QGxpc3RJdGVtQ29udGFpbmVyLnNlbGVjdCA9IChvcHRpb25zKSA9PlxuXHRcdG9wdGlvbnMgPSBvcHRpb25zIHx8IHtzdXByZXNzRXZlbnRzOiBmYWxzZX1cblx0XHRpZiBAZW5hYmxlZCBcblx0XHRcdHRoaW5nVG9Td2l0Y2guc2VsZWN0KClcblx0XHRcdEBzZWxlY3RlZCA9IHRydWVcblx0XHRpZiBvcHRpb25zLnN1cHJlc3NFdmVudHMgPT0gZmFsc2Vcblx0XHRcdEBsaXN0SXRlbUNvbnRhaW5lci5lbWl0IFwiRGlkQ2hhbmdlXCIsIHsgc2VsZWN0ZWQ6IEBzZWxlY3RlZCB9XG5cblx0QGxpc3RJdGVtQ29udGFpbmVyLmRlc2VsZWN0ID0gKG9wdGlvbnMpID0+XG5cdFx0b3B0aW9ucyA9IG9wdGlvbnMgfHwge3N1cHJlc3NFdmVudHM6IGZhbHNlfVxuXHRcdGlmIEBlbmFibGVkIFxuXHRcdFx0dGhpbmdUb1N3aXRjaC5kZXNlbGVjdCgpXHRcdFxuXHRcdFx0QHNlbGVjdGVkID0gZmFsc2Vcblx0XHRpZiBvcHRpb25zLnN1cHJlc3NFdmVudHMgPT0gZmFsc2Vcblx0XHRcdEBsaXN0SXRlbUNvbnRhaW5lci5lbWl0IFwiRGlkQ2hhbmdlXCIsIHsgc2VsZWN0ZWQ6IEBzZWxlY3RlZCB9XG5cblx0QGxpc3RJdGVtQ29udGFpbmVyLnVwZGF0ZUxhYmVsID0gKG5ld1RleHQpID0+XG5cdFx0QGxpc3RJdGVtLmh0bWwgPSBuZXdUZXh0XG5cblx0QGxpc3RJdGVtQ29udGFpbmVyLnNlbGVjdGVkID0gKCkgPT5cblx0XHRyZXR1cm4gQHNlbGVjdGVkXG5cdFx0XHRcblx0QGxpc3RJdGVtQ29udGFpbmVyLnVwZGF0ZUxhYmVsKHBhcmFtcy5uYW1lKVxuXG5cdHJldHVybiBAbGlzdEl0ZW1Db250YWluZXJcblxuZXhwb3J0cy5UYWJsZVZpZXcgPSAocGFyYW1zKSAtPlxuXHRwYXJhbXMgPSBwYXJhbXMgb3Ige31cblx0Xy5kZWZhdWx0cyBwYXJhbXMsXG5cdFx0eTogXHRcdDBcblx0XHR3aWR0aDpcdGRlZmF1bHRzLnNjcmVlbldpZHRoXG5cdFx0aXRlbXM6IFtcIkl0J3MganVzdCBtZSFcIl1cblx0XHRpY29uOiAnY2hlY2snXG5cdFx0dmFsaWRhdGlvbjogJ25vbmUnXG5cdFxuXHRAYnV0dG9uR3JvdXBDb250YWluZXIgPSBuZXcgTGF5ZXJcblx0XHR4OiBcdFx0MFxuXHRcdHk6XHRcdHBhcmFtcy55XG5cdFx0d2lkdGg6IFx0cGFyYW1zLndpZHRoXG5cdFx0aGVpZ2h0OiBkZWZhdWx0cy50YWJsZVJvd0hlaWdodCAqIHBhcmFtcy5pdGVtcy5sZW5ndGhcblx0XHRiYWNrZ3JvdW5kQ29sb3I6IFx0XCJub25lXCJcblx0XHRcdFx0XHRcblx0QGJ1dHRvbkFycmF5ID0gW11cblx0Zm9yIGJ1dHRvbk5hbWUsIGkgaW4gcGFyYW1zLml0ZW1zXG5cdFx0Zmlyc3RJdGVtSW5MaXN0ID0gaWYgaSA9PSAwIHRoZW4gdHJ1ZSBlbHNlIGZhbHNlXG5cdFx0bGFzdEl0ZW1Jbkxpc3QgPSBpZiBpID09IChwYXJhbXMuaXRlbXMubGVuZ3RoLTEpIHRoZW4gdHJ1ZSBlbHNlIGZhbHNlXG5cdFx0bmV3QnV0dG9uID0gbmV3IGV4cG9ydHMuVGFibGVWaWV3Um93KHtcblx0XHRcdHg6IDAsIFxuXHRcdFx0eTogaSpkZWZhdWx0cy50YWJsZVJvd0hlaWdodCwgXG5cdFx0XHRuYW1lOiBidXR0b25OYW1lLCBcblx0XHRcdGljb246IHBhcmFtcy5pY29uLFxuXHRcdFx0Zmlyc3RJdGVtSW5MaXN0OiBmaXJzdEl0ZW1Jbkxpc3QsXG5cdFx0XHRsYXN0SXRlbUluTGlzdDogbGFzdEl0ZW1Jbkxpc3Rcblx0XHR9KVxuXHRcdEBidXR0b25BcnJheS5wdXNoKG5ld0J1dHRvbilcblx0XHRuZXdCdXR0b24uc3VwZXJMYXllciA9IEBidXR0b25Hcm91cENvbnRhaW5lclxuXG5cdGF0dGFjaFJhZGlvQnV0dG9uVmFsaWRhdGlvbiA9IChidXR0b25BcnJheSkgPT5cblx0XHRidXR0b25Hcm91cENvbnRhaW5lciA9IEBidXR0b25Hcm91cENvbnRhaW5lclxuXHRcdGZvciBidXR0b25DbGlja2VkLCBpbmRleE9mQnV0dG9uQ2xpY2tlZCBpbiBidXR0b25BcnJheVxuXHRcdFx0YnV0dG9uQ2xpY2tlZC5kZXNlbGVjdCh7c3VwcmVzc0V2ZW50czogdHJ1ZX0pXG5cdFx0XHQjIENyZWF0ZXMgYSBjbG9zdXJlIHRvIHNhdmUgdGhlIGluZGV4IG9mIHRoZSBidXR0b24gd2UncmUgZGVhbGluZyB3aXRoXG5cdFx0XHRkbyAoYnV0dG9uQ2xpY2tlZCwgaW5kZXhPZkJ1dHRvbkNsaWNrZWQpIC0+IFxuXHRcdFx0XHQjIExpc3RlbiBmb3IgZXZlbnRzIGFuZCBjaGFuZ2Ugb3RoZXIgYnV0dG9ucyBpbiByZXNwb25zZVxuXHRcdFx0XHRidXR0b25DbGlja2VkLm9uICdEaWRDaGFuZ2UnLCAoZXZlbnQpID0+XG5cdFx0XHRcdFx0Zm9yIG90aGVyQnV0dG9uLCBvdGhlckJ1dHRvbkluZGV4IGluIGJ1dHRvbkFycmF5XG5cdFx0XHRcdFx0XHRpZiBvdGhlckJ1dHRvbkluZGV4ICE9IGluZGV4T2ZCdXR0b25DbGlja2VkXG5cdFx0XHRcdFx0XHRcdCMgRG8gc3R1ZmYgdG8gdGhlIG90aGVyIGJ1dHRvbnNcblx0XHRcdFx0XHRcdFx0b3RoZXJCdXR0b24uZGVzZWxlY3Qoe3N1cHByZXNzRXZlbnRzOiB0cnVlfSlcblx0XHRcdFx0XHRidXR0b25Hcm91cENvbnRhaW5lci5lbWl0IFwiRGlkQ2hhbmdlXCIsIHsgc2VsZWN0ZWQ6IGluZGV4T2ZCdXR0b25DbGlja2VkLCBudW1TZWxlY3RlZDogMSwgYnV0dG9uczogYnV0dG9uQXJyYXkgfVxuXG5cdGF0dGFjaERlZmF1bHRWYWxpZGF0aW9uID0gKGJ1dHRvbkFycmF5KSA9PlxuXHRcdCMgSnVzdCBlbWl0cyB0aGUgbmV3IHZhbHVlc1xuXHRcdGJ1dHRvbkdyb3VwQ29udGFpbmVyID0gQGJ1dHRvbkdyb3VwQ29udGFpbmVyXG5cdFx0Zm9yIGJ1dHRvbkNsaWNrZWQsIGluZGV4T2ZCdXR0b25DbGlja2VkIGluIGJ1dHRvbkFycmF5XG5cdFx0XHRidXR0b25DbGlja2VkLmRlc2VsZWN0KHtzdXByZXNzRXZlbnRzOiB0cnVlfSlcblx0XHRcdCMgQ3JlYXRlcyBhIGNsb3N1cmUgdG8gc2F2ZSB0aGUgaW5kZXggb2YgdGhlIGJ1dHRvbiB3ZSdyZSBkZWFsaW5nIHdpdGhcblx0XHRcdGRvIChidXR0b25DbGlja2VkLCBpbmRleE9mQnV0dG9uQ2xpY2tlZCkgLT4gXG5cdFx0XHRcdCMgTGlzdGVuIGZvciBldmVudHMgYW5kIGNoYW5nZSBvdGhlciBidXR0b25zIGluIHJlc3BvbnNlXG5cdFx0XHRcdGJ1dHRvbkNsaWNrZWQub24gJ0RpZENoYW5nZScsIChldmVudCkgPT5cblx0XHRcdFx0XHRudW1TZWxlY3RlZCA9IDBcblx0XHRcdFx0XHR0YWJsZVZpZXdTdGF0ZXMgPSBbXVx0XHRcblx0XHRcdFx0XHRmb3IgYnV0dG9uIGluIGJ1dHRvbkFycmF5XG5cdFx0XHRcdFx0XHR0YWJsZVZpZXdTdGF0ZXMucHVzaChidXR0b24uc2VsZWN0ZWQoKSlcblx0XHRcdFx0XHRcdGlmIGJ1dHRvbi5zZWxlY3RlZCgpIHRoZW4gbnVtU2VsZWN0ZWQrK1xuXHRcdFx0XHRcdGJ1dHRvbkdyb3VwQ29udGFpbmVyLmVtaXQgXCJEaWRDaGFuZ2VcIiwgeyBzZWxlY3RlZDogdGFibGVWaWV3U3RhdGVzLCBudW1TZWxlY3RlZDogbnVtU2VsZWN0ZWQsIGJ1dHRvbnM6IGJ1dHRvbkFycmF5IH1cblxuXHRpZiBwYXJhbXMudmFsaWRhdGlvbiA9PSAncmFkaW8nXG5cdFx0YXR0YWNoUmFkaW9CdXR0b25WYWxpZGF0aW9uKEBidXR0b25BcnJheSlcblx0ZWxzZSBcblx0XHRhdHRhY2hEZWZhdWx0VmFsaWRhdGlvbihAYnV0dG9uQXJyYXkpXG5cdFx0XG5cdHJldHVybiBAYnV0dG9uR3JvdXBDb250YWluZXJcblxuXG5cbiMjI1xuXHRUQUJMRSBWSUVXIEhFQURFUlxuXHRJbiBpT1MsIHRoaXMgaXMgdHlwaWNhbGx5IGF0dGFjaGVkIHRvIHRoZSB0YWJsZSB2aWV3LCBcblx0YnV0IGl0J3MgaW5kZXBlbmRlbnQgaGVyZSBzbyB5b3UgY2FuIHB1dCBpdCB3aGVyZXZlciB5b3Ugd2FudC5cbiMjI1xuXG5leHBvcnRzLlRhYmxlVmlld0hlYWRlciA9IChwYXJhbXMpIC0+XG5cdHBhcmFtcyA9IHBhcmFtcyB8fCB7fVxuXHRfLmRlZmF1bHRzIHBhcmFtcyxcblx0XHR0ZXh0OiAnSSBhbSBhIGRpdmlkZXInXG5cdFx0eDogMFxuXHRcdHk6IDBcblx0bGlzdERpdmlkZXIgPSBuZXcgTGF5ZXJcblx0XHR4OiBwYXJhbXMueCArIGRlZmF1bHRzLnRhYmxlUm93SG9yaXpvbnRhbFBhZGRpbmdcblx0XHR5OiBwYXJhbXMueVxuXHRcdHdpZHRoOiBkZWZhdWx0cy5zY3JlZW5XaWR0aFxuXHRcdGJhY2tncm91bmRDb2xvcjogJ25vbmUnXG5cdGxpc3REaXZpZGVyLmh0bWwgPSBwYXJhbXMudGV4dFxuXHRsaXN0RGl2aWRlci5zdHlsZSA9IGRlZmF1bHRzLmRpdmlkZXJJdGVtVGV4dFN0eWxlXG5cdGxpc3REaXZpZGVyLnN0eWxlID0gXG5cdFx0Y29sb3I6IGRlZmF1bHRzLnRpbnRcblx0cmV0dXJuIGxpc3REaXZpZGVyXG5cblxuXG4jIyNcblx0UElDS0VSXG5cdEluIGlPUywgdGhpcyBpcyB0eXBpY2FsbHkgYXR0YWNoZWQgdG8gdGhlIHRhYmxlIHZpZXcsIFxuXHRidXQgaXQncyBpbmRlcGVuZGVudCBoZXJlIHNvIHlvdSBjYW4gcHV0IGl0IHdoZXJldmVyIHlvdSB3YW50LlxuIyMjXG5cblxuIyMgVXRpbGl0eSBmdW5jdGlvbnNcblxucXVhbnRpemUgPSAoaW5wdXQsIHN0ZXBTaXplKSAtPlxuXHRyZXR1cm4gTWF0aC5mbG9vcihpbnB1dC9zdGVwU2l6ZSkgKiBzdGVwU2l6ZVxuXG5cbiMjIFRoZSBpdGVtcyBpbiB0aGUgcGlja2VyXG5cbkRydW0gPSAocGFyZW50RHJ1bUxheWVyLCBkcnVtTmFtZSwgbGlzdEl0ZW1zLCBwYXJhbXMpIC0+XG5cdFxuXHQjIFNldHVwIHZhcmlhYmxlc1xuXHRAcGFyZW50RHJ1bUxheWVyID0gcGFyZW50RHJ1bUxheWVyXG5cdHBhcmFtcyA9IHBhcmFtcyB8fCB7fVxuXHRfLmRlZmF1bHRzIHBhcmFtcyxcblx0XHRlbmFibGVkOiB0cnVlXG5cdFx0eFBjdDogMCAgXHRcdFx0XHQjIDAgdG8gMVxuXHRcdHdpZHRoUGN0OiAxXHRcdFx0XHQjIDAgdG8gMVxuXHRcdHRleHRBbGlnbjogXCJjZW50ZXJcIlx0XHQjIGxlZnQsIGNlbnRlciwgcmlnaHRcblx0XHR0ZXh0UGFkZGluZzogXCIwXCJcblx0XHR0ZXh0Q29sb3I6IGRlZmF1bHRzLnRpbnRcblx0XG5cdCMgVmFsdWVzIGRlcml2ZWQgZnJvbSBwYXJhbXNcblx0ZHJ1bUNvbnRhaW5lckhlaWdodCA9IGRlZmF1bHRzLnRhYmxlUm93SGVpZ2h0KjVcblxuXHQjIFNldCB1cCBjb250ZW50IG9mIGxpc3QgXHRcdFxuXHRsaXN0SXRlbXMgPSBsaXN0SXRlbXNcblx0QG5hbWUgPSBkcnVtTmFtZVxuXHRAaW5kZXggPSAwXG5cdEB2YWwgPSBsaXN0SXRlbXNbQGluZGV4XVxuXHRAdmVsb2NpdHkgPSAwXG5cdGZpcnN0VG91Y2hBdmFpbGFibGUgPSB0cnVlICAgICMgaXMgdGhpcyB0aGUgZmlyc3QgdG91Y2ggaW4gYSBnaXZlbiBnZXN0dXJlP1xuXHRcblx0aW50ZXJ2YWxUb3VwZGF0ZURydW1BcHBlYXJhbmNlID0gMFxuXHRcblx0IyBDYWxjdWxhdGUgaGVpZ2h0IGFuZCB2ZXJ0aWNhbCBib3VuZHMgb2YgdGhlIGxpc3Rcblx0bGlzdE1pbllQb3MgXHQ9IC1kZWZhdWx0cy50YWJsZVJvd0hlaWdodC8yXG5cdGxpc3RNYXhZUG9zIFx0PSAtbGlzdEl0ZW1zLmxlbmd0aCpkZWZhdWx0cy50YWJsZVJvd0hlaWdodCtkZWZhdWx0cy50YWJsZVJvd0hlaWdodC8yXG5cdGxpc3RIZWlnaHQgXHRcdD0gbGlzdEl0ZW1zLmxlbmd0aCpkZWZhdWx0cy50YWJsZVJvd0hlaWdodCArIGRydW1Db250YWluZXJIZWlnaHRcblxuXHRAZHJ1bUNvbnRhaW5lciA9IG5ldyBMYXllclxuXHRcdHg6IFx0XHRcdFx0XHRwYXJhbXMueFBjdCAqIGRlZmF1bHRzLnNjcmVlbldpZHRoXG5cdFx0eTogXHRcdFx0XHRcdDBcblx0XHR3aWR0aDogXHRcdFx0XHRwYXJhbXMud2lkdGhQY3QgKiBkZWZhdWx0cy5zY3JlZW5XaWR0aFxuXHRcdGhlaWdodDogXHRcdFx0ZHJ1bUNvbnRhaW5lckhlaWdodFxuXHRcdGJhY2tncm91bmRDb2xvcjogXHRcIm5vbmVcIlxuXHRcdHN1cGVyTGF5ZXI6IFx0XHRwYXJlbnREcnVtTGF5ZXJcblx0XG5cdGxpc3RMYXllciA9IG5ldyBMYXllclxuXHRcdHg6IFx0XHRcdFx0XHQwXG5cdFx0eTogXHRcdFx0XHRcdC1kZWZhdWx0cy50YWJsZVJvd0hlaWdodC8yXG5cdFx0d2lkdGg6IFx0XHRcdFx0cGFyYW1zLndpZHRoUGN0ICogZGVmYXVsdHMuc2NyZWVuV2lkdGhcblx0XHRoZWlnaHQ6IFx0XHRcdGxpc3RIZWlnaHRcblx0XHRzdXBlckxheWVyOiBcdFx0QGRydW1Db250YWluZXJcblx0XHRiYWNrZ3JvdW5kQ29sb3I6IFx0XCJub25lXCJcblx0XG5cdCMgbGlzdExheWVyLnNjcm9sbCA9IHRydWVcblx0bGlzdExheWVyLmRyYWdnYWJsZS5lbmFibGVkID0gcGFyYW1zLmVuYWJsZWRcblx0bGlzdExheWVyLmRyYWdnYWJsZS5zcGVlZFggPSAwXG5cdFxuXHRmb3IgbGksIGkgaW4gbGlzdEl0ZW1zXG5cdFx0bGlzdEl0ZW1MYXllciA9IG5ldyBMYXllclxuXHRcdFx0eDogXHRcdFx0XHQwXG5cdFx0XHR5OiBcdFx0XHRcdGkgKiBkZWZhdWx0cy50YWJsZVJvd0hlaWdodCArIGRydW1Db250YWluZXJIZWlnaHQvMlxuXHRcdFx0d2lkdGg6IFx0XHRcdHBhcmFtcy53aWR0aFBjdCAqIGRlZmF1bHRzLnNjcmVlbldpZHRoXG5cdFx0XHRoZWlnaHQ6IFx0XHRkZWZhdWx0cy50YWJsZVJvd0hlaWdodFxuXHRcdFx0c3VwZXJMYXllcjogXHRsaXN0TGF5ZXJcblx0XHRcdGJhY2tncm91bmRDb2xvcjogXCJub25lXCIjVXRpbHMucmFuZG9tQ29sb3IoKVxuXHRcdGxpc3RJdGVtTGF5ZXIuaHRtbCA9IGxpXG5cdFx0bGlzdEl0ZW1MYXllci5zdHlsZSA9XG5cdFx0XHRjb2xvcjogXHRcdFx0cGFyYW1zLnRleHRDb2xvclxuXHRcdFx0Zm9udEZhbWlseTogXHRkZWZhdWx0cy5waWNrZXJUZXh0U3R5bGUuZm9udEZhbWlseVxuXHRcdFx0Zm9udFdlaWdodDogXHRkZWZhdWx0cy5waWNrZXJUZXh0U3R5bGUuZm9udFdlaWdodFxuXHRcdFx0Zm9udFNpemU6IFx0XHRkZWZhdWx0cy5waWNrZXJUZXh0U3R5bGUuZm9udFNpemVcblx0XHRcdGxpbmVIZWlnaHQ6IFx0ZGVmYXVsdHMudGFibGVSb3dIZWlnaHQrXCJweFwiXG5cdFx0XHR0ZXh0QWxpZ246IFx0XHRwYXJhbXMudGV4dEFsaWduXG5cdFx0XHRwYWRkaW5nOiBcdFx0cGFyYW1zLnRleHRQYWRkaW5nXG5cblx0XHRsaXN0SXRlbUxheWVyLnN0YXJ0WSA9IGkgKiBkZWZhdWx0cy50YWJsZVJvd0hlaWdodCArIGRydW1Db250YWluZXJIZWlnaHQvMlxuXG5cdGxpc3RMYXllci5vbiBFdmVudHMuRHJhZ01vdmUsID0+XG5cdFx0aWYgZmlyc3RUb3VjaEF2YWlsYWJsZVxuXHRcdFx0QGRydW1Db250YWluZXIuZW1pdChcIkRydW1TdGFydGVkTW92aW5nXCIsIHtkcnVtOiBkcnVtTmFtZSwgaW5kZXg6IEBpbmRleCwgdmFsdWU6IEB2YWwsIHZlbG9jaXR5OiAwfSlcblx0XHRcdGZpcnN0VG91Y2hBdmFpbGFibGUgPSBmYWxzZVx0XHRcblx0XHRcdFxuXHRcdHVwZGF0ZURydW1BcHBlYXJhbmNlKClcblx0XHRcblx0IyBUbyBzaW11bGF0ZSBpT1MgbW9tZW50dW0gc2Nyb2xsaW5nICh3aGljaCBjYXVzZXMgdGhlIGRydW0gdG8ga2VlcCBzcGlubmluZyBcblx0IyBhZnRlciB5b3VyIGZpbmdlciBsaWZ0cyBvZmYgaXQpLCB3ZSB0cmlnZ2VyIGFuIGFuaW1hdGlvbiB0aGUgbW9tZW50IHlvdSBsaWZ0XG5cdCMgeW91ciBmaW5nZXIuIFRoZSBpbnRlbnNpdHkgb2YgdGhpcyBhbmltYXRpb24gaXMgcHJvcG9ydGlvbmFsIHRvIHRoZSBzcGVlZCB3aGVuXG5cdCMgb2YgdGhlIGRyYWdnaW5nIHdoZW4geW91ciBmaW5nZXIgd2FzIGxpZnRlZC5cblx0bGlzdExheWVyLm9uIEV2ZW50cy5EcmFnRW5kLCAoZSwgZikgPT5cblx0XHRcblx0XHQjIE5leHQgdG91Y2ggc2hvdWxkIHRyaWdnZXIgRHJ1bVN0YXJ0ZWRNb3Zpbmdcblx0XHRmaXJzdFRvdWNoQXZhaWxhYmxlID0gdHJ1ZVxuXHRcblx0XHQjIFRoaXMgY2FsY3VsYXRlcyB0aGUgYW5pbWF0aW9uXG5cdFx0c2Nyb2xsVmVsb2NpdHkgPSBsaXN0TGF5ZXIuZHJhZ2dhYmxlLmNhbGN1bGF0ZVZlbG9jaXR5KCkueVxuXHRcdHRpbWVBZnRlckRyYWcgPSAoMC41K01hdGguYWJzKHNjcm9sbFZlbG9jaXR5KjAuMikpLnRvRml4ZWQoMSlcblx0XHRmaW5hbFBvc2l0aW9uQWZ0ZXJNb21lbnR1bSA9IHF1YW50aXplKGxpc3RMYXllci55ICsgc2Nyb2xsVmVsb2NpdHkqNDAwLCBkZWZhdWx0cy50YWJsZVJvd0hlaWdodCkgKyBkZWZhdWx0cy50YWJsZVJvd0hlaWdodC8yXG5cdFx0XG5cdFx0IyBBdCB0aGUgdG9wIGFuZCBib3R0b20sIHRoZSBtb21lbnR1bSBzaG91bGQgYmUgYWRqdXN0ZWQgc28gdGhlIFxuXHRcdCMgZmlyc3QgYW5kIGxhc3QgdmFsdWVzIG9uIHRoZSBkcnVtIGRvbid0IGdvIHRvbyBmYXIgb3V0IG9mIHZpZXdcblx0XHRkaXN0YW5jZVRvVHJhdmVsID0gZmluYWxQb3NpdGlvbkFmdGVyTW9tZW50dW0gLSBsaXN0TGF5ZXIueVxuXHRcdGxpc3RIZWlnaHRXaXRob3V0RW5kQnVmZmVyID0gLWxpc3RJdGVtcy5sZW5ndGgqZGVmYXVsdHMudGFibGVSb3dIZWlnaHRcblx0XHRib3R0b21PdmVyZmxvdyA9IE1hdGgubWF4KDAsIGxpc3RIZWlnaHRXaXRob3V0RW5kQnVmZmVyLWZpbmFsUG9zaXRpb25BZnRlck1vbWVudHVtIClcblx0XHR0b3BPdmVyZmxvdyA9IE1hdGgubWF4KDAsIGZpbmFsUG9zaXRpb25BZnRlck1vbWVudHVtIClcblx0XHRvdmVyZmxvd0RhbXBlbmluZyA9IDEwXG5cdFx0XG5cdFx0aWYgYm90dG9tT3ZlcmZsb3cgPiAwXG5cdFx0XHRmaW5hbFBvc2l0aW9uQWZ0ZXJNb21lbnR1bSA9IGxpc3RIZWlnaHRXaXRob3V0RW5kQnVmZmVyIC0gKGJvdHRvbU92ZXJmbG93IC8gb3ZlcmZsb3dEYW1wZW5pbmcpXG5cdFx0XHRuZXdEaXN0YW5jZVRvVHJhdmVsID0gZmluYWxQb3NpdGlvbkFmdGVyTW9tZW50dW0gLSBsaXN0TGF5ZXIueVxuXHRcdFx0dGltZUFmdGVyRHJhZyA9IHRpbWVBZnRlckRyYWcgKiAobmV3RGlzdGFuY2VUb1RyYXZlbC9kaXN0YW5jZVRvVHJhdmVsKVxuXG5cdFx0aWYgdG9wT3ZlcmZsb3cgPiAwXG5cdFx0XHRmaW5hbFBvc2l0aW9uQWZ0ZXJNb21lbnR1bSA9IDQwICsgKHRvcE92ZXJmbG93IC8gb3ZlcmZsb3dEYW1wZW5pbmcpXG5cdFx0XHRuZXdEaXN0YW5jZVRvVHJhdmVsID0gZmluYWxQb3NpdGlvbkFmdGVyTW9tZW50dW0gLSBsaXN0TGF5ZXIueVxuXHRcdFx0dGltZUFmdGVyRHJhZyA9IHRpbWVBZnRlckRyYWcgKiAobmV3RGlzdGFuY2VUb1RyYXZlbC9kaXN0YW5jZVRvVHJhdmVsKVxuXG5cdFx0IyBUcmlnZ2VyIHRoZSBhbmltYXRpb24sIGFuZCBzY2hlZHVsZSBhbiBldmVudCB0aGF0IHdpbGxcblx0XHQjIHRyaWdnZXIgd2hlbiB0aGUgZHJ1bSBmaW5hbGx5IHN0b3BzIHNwaW5uaW5nLlxuXHRcdGxpc3RMYXllci5hbmltYXRlKHtcblx0XHRcdFx0cHJvcGVydGllczoge3k6IGZpbmFsUG9zaXRpb25BZnRlck1vbWVudHVtfVxuXHRcdFx0XHR0aW1lOiB0aW1lQWZ0ZXJEcmFnXG5cdFx0XHRcdGN1cnZlOiBcImVhc2Utb3V0XCJcblx0XHRcdH0pXG5cdFx0VXRpbHMuZGVsYXkgdGltZUFmdGVyRHJhZywgLT5cblx0XHRcdHN0b3BEcnVtKClcblxuXHQjIFRoaXMgZW5zdXJlcyB0aGF0IGR1cmluZyB0aGUgYW5pbWF0aW9uIG9mIHRoZSBsaXN0IGxheWVyLCB0aGUgZHJ1bSdzIGFwcGVhcmFuY2UgY29udGludWVzXG5cdCMgdG8gYmUgdXBkYXRlZC4gQmVjYXVzZSBtdWx0aXBsZSBhbmltYXRpb25zIGNvdWxkIG92ZXJsYXAsIHdlIGVuc3VyZSB0aGF0IGV2ZXJ5IG5ldyBhbmltYXRpb25cblx0IyBlbmRzIHRoZSBpbnRlcnZhbCBhbmQgc3RhcnRzIGEgbmV3IG9uZSBzbyB0aGF0IHdlIG5ldmVyIGhhdmUgbW9yZSB0aGFuIG9uZSBydW5uaW5nIFxuXHRsaXN0TGF5ZXIub24gRXZlbnRzLkFuaW1hdGlvblN0YXJ0LCAtPlxuXHRcdGNsZWFySW50ZXJ2YWwoaW50ZXJ2YWxUb3VwZGF0ZURydW1BcHBlYXJhbmNlKVxuXHRcdGludGVydmFsVG91cGRhdGVEcnVtQXBwZWFyYW5jZSA9IFV0aWxzLmludGVydmFsIDEvMzAsIHVwZGF0ZURydW1BcHBlYXJhbmNlICAgIFxuXG5cdGxpc3RMYXllci5vbiBFdmVudHMuQW5pbWF0aW9uRW5kLCA9Plx0XHRcblx0XHRjbGVhckludGVydmFsKGludGVydmFsVG91cGRhdGVEcnVtQXBwZWFyYW5jZSlcblxuXHRcdCMgRW1pdCBhZnRlciBhbGwgbW92ZW1lbnQgZW5kcyBpbiB0aGUgbGlzdFxuXHRcdEBkcnVtQ29udGFpbmVyLmVtaXQoXCJEcnVtRmluaXNoZWRDaGFuZ2luZ1wiLCB7bGlzdDogZHJ1bU5hbWUsIGluZGV4OiBAaW5kZXgsIHZhbHVlOiBAdmFsfSlcblxuXHR1cGRhdGVEcnVtQXBwZWFyYW5jZSA9ID0+XG5cdFx0aXRlbXNJbkRydW0gPSA0XG5cdFx0bGlzdFBvc2l0aW9uID0gbGlzdExheWVyLnkgLyAtZGVmYXVsdHMudGFibGVSb3dIZWlnaHQgLSAwLjVcblx0XHRjYXBwZWRMaXN0UG9zaXRpb24gPSBNYXRoLm1heCgwLCBNYXRoLm1pbihsaXN0TGF5ZXIueSAvIC1kZWZhdWx0cy50YWJsZVJvd0hlaWdodCAtIDAuNSwgbGlzdEl0ZW1zLmxlbmd0aCAtIDEpKVxuXHRcdGZvY3VzSXRlbSA9IE1hdGgucm91bmQoY2FwcGVkTGlzdFBvc2l0aW9uKVxuXHRcdGRpc3RhbmNlRnJvbU1pZGRsZSA9IE1hdGguYWJzKGZvY3VzSXRlbSAtIGNhcHBlZExpc3RQb3NpdGlvbilcblx0XHRmb3IgaSBpbiBbKGZvY3VzSXRlbS1pdGVtc0luRHJ1bSkuLihmb2N1c0l0ZW0raXRlbXNJbkRydW0pXVxuXHRcdFx0aWYgaSA+PSAwIGFuZCBpIDwgbGlzdEl0ZW1zLmxlbmd0aFxuXHRcdFx0XHRsaXN0TGF5ZXIuc3ViTGF5ZXJzW2ldLm9wYWNpdHkgPSAxIC0gTWF0aC5hYnMobGlzdFBvc2l0aW9uIC0gaSkvNSAtIChpZiAoaSAhPSBmb2N1c0l0ZW0pIHRoZW4gMC4zIGVsc2UgMClcblx0XHRcdFx0bGlzdExheWVyLnN1YkxheWVyc1tpXS5zY2FsZVkgPSAxIC0gTWF0aC5taW4oMSwgTWF0aC5hYnMobGlzdFBvc2l0aW9uIC0gaSkvNClcblx0XHRcdFx0bGlzdExheWVyLnN1YkxheWVyc1tpXS55ID0gbGlzdExheWVyLnN1YkxheWVyc1tpXS5zdGFydFkgLSAoaS1saXN0UG9zaXRpb24pKk1hdGguYWJzKGktbGlzdFBvc2l0aW9uKSoxMFxuXG5cdFx0IyBVcGRhdGUgdGhlIHZhbHVlIG9mIHRoZSBkcnVtIG9ubHkgd2hlbiBhIG5ldyB2YWx1ZSBpcyByZWFjaGVkXG5cdFx0aWYgKEBpbmRleCAhPSBmb2N1c0l0ZW0pXG5cdFx0XHR1cGRhdGVEcnVtVmFsdWVzKGZvY3VzSXRlbSlcblx0XHRcblx0c3RvcERydW0gPSA9Plx0XHRcblx0XHQjIEVuc3VyZSB0aGUgZHJ1bSBuZXZlciBlbmRzIG91dCBvZiBib3VuZHNcblx0XHRpZiBsaXN0TGF5ZXIueSA+IGxpc3RNaW5ZUG9zIFxuXHRcdFx0bGlzdExheWVyLmFuaW1hdGUoe1xuXHRcdCAgICBcdHByb3BlcnRpZXM6IHt5Omxpc3RNaW5ZUG9zfVxuXHRcdCAgICBcdGN1cnZlOiBcInNwcmluZyg0MDAsNTAsMClcIlxuXHRcdFx0fSlcblx0XHRpZiBsaXN0TGF5ZXIueSA8IGxpc3RNYXhZUG9zXG5cdFx0XHRsaXN0TGF5ZXIuYW5pbWF0ZSh7XG5cdFx0XHRcdHByb3BlcnRpZXM6IHt5OiBsaXN0TWF4WVBvc31cblx0XHRcdFx0Y3VydmU6IFwic3ByaW5nKDQwMCw1MCwwKVwiXG5cdFx0XHR9KVxuXHRcblx0IyBVcGRhdGUgdGhlIHZhbHVlcyBvZiB0aGUgZHJ1bXMgYW5kIGludm9rZSB0aGUgY2FsbGJhY2sgXG5cdHVwZGF0ZURydW1WYWx1ZXMgPSAobmV3SW5kZXgpID0+XG5cdFx0QGluZGV4ID0gbmV3SW5kZXhcblx0XHRAdmFsID0gbGlzdEl0ZW1zW0BpbmRleF1cblx0XHRAZHJ1bUNvbnRhaW5lci5lbWl0KFwiRHJ1bURpZENoYW5nZVwiLCB7bGlzdDogZHJ1bU5hbWUsIGluZGV4OiBAaW5kZXgsIHZhbHVlOiBAdmFsfSlcblx0XG5cdCMgUmVuZGVyIGZvciB0aGUgZmlyc3QgdGltZVx0XHRcblx0dXBkYXRlRHJ1bUFwcGVhcmFuY2UoKVxuXHRcblx0QHNldEluZGV4ID0gKGluZGV4KSA9PlxuXHRcdHlQb3NpdGlvbkZvclRoaXNJbmRleCA9IC1kZWZhdWx0cy50YWJsZVJvd0hlaWdodC8yIC0gKGluZGV4ICogZGVmYXVsdHMudGFibGVSb3dIZWlnaHQpXG5cdFx0bGlzdExheWVyLmFuaW1hdGUoe1xuXHRcdFx0XHRwcm9wZXJ0aWVzOiB7eTogeVBvc2l0aW9uRm9yVGhpc0luZGV4fVxuXHRcdFx0XHR0aW1lOiAwLjVcblx0XHRcdFx0Y3VydmU6IFwiZWFzZS1vdXRcIlxuXHRcdFx0fSlcblxuXHRAc2V0VmFsdWUgPSAodmFsKSA9PlxuXHRcdGluZGV4ID0gbGlzdEl0ZW1zLmluZGV4T2YodmFsKVxuXHRcdGlmIGluZGV4ICE9IC0xXG5cdFx0XHRAc2V0SW5kZXgoaW5kZXgpXG5cblx0IyBSZXR1cm4gdGhlIGRydW0gb2JqZWN0IHNvIHdlIGNhbiBhY2Nlc3MgaXRzIHZhbHVlc1xuXHRyZXR1cm4gQFxuXG5cbiMjI1xuXHRQSUNLRVJcblx0VGhpcyBjb250YWlucyB0aGUgcGlja2VyIFxuIyMjIFxuZXhwb3J0cy5QaWNrZXIgPSAocGFyYW1zKSAtPlxuXHRcblx0cGFyYW1zID0gcGFyYW1zIHx8IHt9XG5cdF8uZGVmYXVsdHMgcGFyYW1zLFxuXHRcdHg6IFx0XHQwXG5cdFx0eTogXHRcdDBcblx0XHR3aWR0aDpcdGRlZmF1bHRzLnNjcmVlbldpZHRoXG5cdFx0ZGVmYXVsdFRleHQ6IFwiXCJcblx0XHR0ZXh0Q29sb3I6IGRlZmF1bHRzLnRpbnRcblxuXHRkcnVtQ29udGFpbmVySGVpZ2h0ID0gZGVmYXVsdHMudGFibGVSb3dIZWlnaHQqNVxuXG5cdEBwaWNrZXJDb250YWluZXIgPSBuZXcgTGF5ZXJcblx0XHR4OiBcdFx0cGFyYW1zLnhcblx0XHR5Olx0XHRwYXJhbXMueVxuXHRcdHdpZHRoOiBcdHBhcmFtcy53aWR0aFxuXHRcdGhlaWdodDogZHJ1bUNvbnRhaW5lckhlaWdodCs4OFxuXHRcdGJhY2tncm91bmRDb2xvcjogXHRkZWZhdWx0cy5pdGVtQmFja2dyb3VuZFxuXHRcdFx0XG5cdEBkcnVtID0gbmV3IExheWVyXG5cdFx0eDogXHRcdDBcblx0XHR5OiBcdFx0ODhcblx0XHR3aWR0aDogXHRwYXJhbXMud2lkdGhcblx0XHRoZWlnaHQ6IGRydW1Db250YWluZXJIZWlnaHRcblx0XHRiYWNrZ3JvdW5kQ29sb3I6IFwibm9uZVwiXG5cdFx0c3VwZXJMYXllcjogQHBpY2tlckNvbnRhaW5lclx0XHRcblx0XHRcblx0QHNlbGVjdGVkSXRlbSA9IG5ldyBMYXllclxuXHRcdHg6IFx0XHQwXG5cdFx0eTogXHRcdGRydW1Db250YWluZXJIZWlnaHQvMiAtIGRlZmF1bHRzLnRhYmxlUm93SGVpZ2h0LzJcblx0XHR3aWR0aDogXHRwYXJhbXMud2lkdGhcblx0XHRoZWlnaHQ6IGRlZmF1bHRzLnRhYmxlUm93SGVpZ2h0XG5cdFx0YmFja2dyb3VuZENvbG9yOiBcIm5vbmVcIlxuXHRcdHN1cGVyTGF5ZXI6IEBkcnVtXG5cblx0QHBpY2tlckNvbnRhaW5lci5waWNrZXJIZWFkZXIgPSBuZXcgTGF5ZXJcblx0XHR4OiBcdFx0MFxuXHRcdHk6IFx0XHQwXG5cdFx0d2lkdGg6IFx0cGFyYW1zLndpZHRoXG5cdFx0aGVpZ2h0Olx0ODhcblx0XHRiYWNrZ3JvdW5kQ29sb3I6IGRlZmF1bHRzLml0ZW1CYWNrZ3JvdW5kXG5cdFx0c3VwZXJMYXllcjogQHBpY2tlckNvbnRhaW5lclxuXHRcdFxuXHQjIFN0eWxlc1xuXHRAZHJ1bS5zdHlsZSA9XG5cdFx0cG9pbnRlckV2ZW50czogXCJub25lXCJcblx0XHRib3JkZXJUb3A6IFwiMXB4IHNvbGlkIFwiICsgZGVmYXVsdHMubGluZVRpbnRcblx0XHRib3JkZXJCb3R0b206IFwiMXB4IHNvbGlkIFwiICsgZGVmYXVsdHMubGluZVRpbnRcblx0XG5cdEBzZWxlY3RlZEl0ZW0uc3R5bGUgPVxuXHRcdHBvaW50ZXJFdmVudHM6IFwibm9uZVwiXG5cdFx0Ym9yZGVyVG9wOiBcIjFweCBzb2xpZCByZ2JhKDAsMCwwLDAuMylcIlxuXHRcdGJvcmRlckJvdHRvbTogXCIxcHggc29saWQgcmdiYSgwLDAsMCwwLjMpXCJcblx0XHRcblx0QHBpY2tlckNvbnRhaW5lci5waWNrZXJIZWFkZXIuc3R5bGUgPSBkZWZhdWx0cy5saXN0SXRlbVRleHRTdHlsZVxuXHRAcGlja2VyQ29udGFpbmVyLnBpY2tlckhlYWRlci5zdHlsZSA9IFxuXHRcdGNvbG9yOiBwYXJhbXMudGV4dENvbG9yXG5cdFx0cGFkZGluZ0xlZnQ6IFwiMjBweFwiXG5cdFx0Ym9yZGVyVG9wOiBcIjFweCBzb2xpZCBcIiArIGRlZmF1bHRzLmxpbmVUaW50XG5cdFx0XHRcblx0QHBpY2tlckNvbnRhaW5lci5waWNrZXJIZWFkZXIuaHRtbCA9IHBhcmFtcy5kZWZhdWx0VGV4dFxuXHRcdFxuXHRcdFxuXHQjIEFkZCBkcnVtc1xuXHRAcGlja2VyQ29udGFpbmVyLmRydW1zID0gW11cblx0QHBpY2tlckNvbnRhaW5lci5kcnVtc0J5TmFtZSA9IHt9XG5cdFxuXHRwaWNrZXJTdGFydGVkTW92aW5nID0gKCk9PlxuXHRcdGRydW1WYWx1ZXMgPSB7fVxuXHRcdG5ld1ZhbHVlcyA9IGZvciBkcnVtIGluIEBwaWNrZXJDb250YWluZXIuZHJ1bXNcblx0XHRcdGRydW1WYWx1ZXNbZHJ1bS5uYW1lXSA9IHtpbmRleDogZHJ1bS5pbmRleCwgdmFsOiBkcnVtLnZhbCwgdmVsb2NpdHk6IDB9XHRcblx0XHRAcGlja2VyQ29udGFpbmVyLmVtaXQoXCJQaWNrZXJTdGFydGVkTW92aW5nXCIgKVxuXHRcdFxuXHRwaWNrZXJEaWRDaGFuZ2UgPSAoKT0+XG5cdFx0ZHJ1bVZhbHVlcyA9IHt9XG5cdFx0bmV3VmFsdWVzID0gZm9yIGRydW0gaW4gQHBpY2tlckNvbnRhaW5lci5kcnVtc1xuXHRcdFx0ZHJ1bVZhbHVlc1tkcnVtLm5hbWVdID0ge2luZGV4OiBkcnVtLmluZGV4LCB2YWw6IGRydW0udmFsfVxuXG5cdFx0QHBpY2tlckNvbnRhaW5lci5lbWl0KFwiUGlja2VyRGlkQ2hhbmdlXCIsIGRydW1WYWx1ZXMgKVxuXHRcblx0cGlja2VyRmluaXNoZWRDaGFuZ2luZyA9ICgpPT5cblx0XHRkcnVtVmFsdWVzID0ge31cblx0XHRuZXdWYWx1ZXMgPSBmb3IgZHJ1bSBpbiBAcGlja2VyQ29udGFpbmVyLmRydW1zXG5cdFx0XHRkcnVtVmFsdWVzW2RydW0ubmFtZV0gPSB7aW5kZXg6IGRydW0uaW5kZXgsIHZhbDogZHJ1bS52YWx9XG5cblx0XHRAcGlja2VyQ29udGFpbmVyLmVtaXQoXCJQaWNrZXJGaW5pc2hlZENoYW5naW5nXCIsIGRydW1WYWx1ZXMgKVx0XG5cdGlmIChwYXJhbXMuZHJ1bXMgYW5kIHBhcmFtcy5kcnVtcy5sZW5ndGggPiAwKVxuXHRcdGZvciBkcnVtIGluIHBhcmFtcy5kcnVtc1xuXHRcdFx0bmV3RHJ1bSA9IG5ldyBEcnVtKEBkcnVtLCBkcnVtLm5hbWUsIGRydW0uaXRlbXMsIGRydW0ucGFyYW1zKVxuXG5cdFx0XHQjIyBTdG9yZSBkcnVtcyBpbnNpZGUgdGhlIHBpY2tlclxuXHRcdFx0QHBpY2tlckNvbnRhaW5lci5kcnVtcy5wdXNoKG5ld0RydW0pXG5cdFx0XHRAcGlja2VyQ29udGFpbmVyLmRydW1zQnlOYW1lW2RydW0ubmFtZV0gPSBuZXdEcnVtIFxuXG5cdFx0XHQjIyBFbnN1cmUgdGhhdCBjaGFuZ2VzIHRvIHRoZSBkcnVtIGJ1YmJsZSB1cCB0byB0aGUgcGlja2VyXG5cdFx0XHRuZXdEcnVtLmRydW1Db250YWluZXIub24gXCJEcnVtRGlkQ2hhbmdlXCIsIHBpY2tlckRpZENoYW5nZVxuXHRcdFx0XG5cdFx0XHQjIyBFbWl0IGFuIGV2ZW50IHdoZW4gZHJ1bXMgc3RvcCBtb3ZpbmcgYWx0b2dldGhlclxuXHRcdFx0bmV3RHJ1bS5kcnVtQ29udGFpbmVyLm9uIFwiRHJ1bUZpbmlzaGVkQ2hhbmdpbmdcIiwgcGlja2VyRmluaXNoZWRDaGFuZ2luZ1xuXG5cdFx0XHQjIyBFbWl0IGFuIGV2ZW50IHdoZW4gbGlzdHMgc3RvcCBtb3ZpbmcgYWx0b2dldGhlclxuXHRcdFx0bmV3RHJ1bS5kcnVtQ29udGFpbmVyLm9uIFwiRHJ1bVN0YXJ0ZWRNb3ZpbmdcIiwgcGlja2VyU3RhcnRlZE1vdmluZ1xuXG5cblx0cmV0dXJuIEBwaWNrZXJDb250YWluZXJcbiIsIiMgQWRkIHRoZSBmb2xsb3dpbmcgbGluZSB0byB5b3VyIHByb2plY3QgaW4gRnJhbWVyIFN0dWRpby4gXG4jIG15TW9kdWxlID0gcmVxdWlyZSBcIm15TW9kdWxlXCJcbiMgUmVmZXJlbmNlIHRoZSBjb250ZW50cyBieSBuYW1lLCBsaWtlIG15TW9kdWxlLm15RnVuY3Rpb24oKSBvciBteU1vZHVsZS5teVZhclxuXG5leHBvcnRzLm15VmFyID0gXCJteVZhcmlhYmxlXCJcblxuZXhwb3J0cy5teUZ1bmN0aW9uID0gLT5cblx0cHJpbnQgXCJteUZ1bmN0aW9uIGlzIHJ1bm5pbmdcIlxuXG5leHBvcnRzLm15QXJyYXkgPSBbMSwgMiwgM10iXX0=
