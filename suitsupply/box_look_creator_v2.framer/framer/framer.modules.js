require=(function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);var f=new Error("Cannot find module '"+o+"'");throw f.code="MODULE_NOT_FOUND",f}var l=n[o]={exports:{}};t[o][0].call(l.exports,function(e){var n=t[o][1][e];return s(n?n:e)},l,l.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({"myModule":[function(require,module,exports){
exports.myVar = "myVariable";

exports.myFunction = function() {
  return print("myFunction is running");
};

exports.myArray = [1, 2, 3];


},{}],"suitsupply":[function(require,module,exports){
var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
  hasProp = {}.hasOwnProperty;

exports.Look = (function(superClass) {
  extend(Look, superClass);

  function Look() {
    return Look.__super__.constructor.apply(this, arguments);
  }

  Look.prototype.position = 0;

  Look.prototype.items = {};

  Look.prototype.addNewItem = function(item) {
    var itemLayer;
    if (this.items[item.name] != null) {
      return;
    }
    this.items[item.name] = item;
    itemLayer = new Layer({
      html: item.name,
      parent: this.content,
      x: this.position,
      backgroundColor: item.color
    });
    this.position += itemLayer.width + 10;
    return this.content.width += itemLayer.width + 10;
  };

  return Look;

})(ScrollComponent);

exports.Item = (function() {
  Item.prototype.color = 'red';

  Item.prototype.name = null;

  function Item(name, color) {
    this.name = name;
    this.color = color;
  }

  return Item;

})();

exports.Button = (function(superClass) {
  extend(Button, superClass);

  function Button(options) {
    Button.__super__.constructor.call(this, options);
    this.look = options.look;
    this.currentNewPosition = this.maxX + 10;
    this.item = new exports.Item(options.name, Utils.randomColor());
    this.onClick(function() {
      return this.createLayerNextToIt();
    });
  }

  Button.prototype.createLayerNextToIt = function() {
    return this.look.addNewItem(this.item);
  };

  return Button;

})(Layer);


},{}]},{},[])
//# sourceMappingURL=data:application/json;charset=utf-8;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoiZnJhbWVyLm1vZHVsZXMuanMiLCJzb3VyY2VzIjpbIi4uL21vZHVsZXMvc3VpdHN1cHBseS5jb2ZmZWUiLCIuLi9tb2R1bGVzL215TW9kdWxlLmNvZmZlZSIsIm5vZGVfbW9kdWxlcy9icm93c2VyLXBhY2svX3ByZWx1ZGUuanMiXSwic291cmNlc0NvbnRlbnQiOlsiY2xhc3MgZXhwb3J0cy5Mb29rIGV4dGVuZHMgU2Nyb2xsQ29tcG9uZW50XG5cdHBvc2l0aW9uOiAwXG5cdGl0ZW1zOiB7fVxuXHRhZGROZXdJdGVtOiAoaXRlbSkgLT5cblx0XHRpZiBAaXRlbXNbaXRlbS5uYW1lXT9cblx0XHRcdHJldHVyblxuXHRcdEBpdGVtc1tpdGVtLm5hbWVdID0gaXRlbVxuXHRcdGl0ZW1MYXllciA9IG5ldyBMYXllclxuXHRcdFx0aHRtbDogaXRlbS5uYW1lXG5cdFx0XHRwYXJlbnQ6IEBjb250ZW50XG5cdFx0XHR4OiBAcG9zaXRpb25cblx0XHRcdGJhY2tncm91bmRDb2xvcjogaXRlbS5jb2xvclxuXHRcdEBwb3NpdGlvbiArPSBpdGVtTGF5ZXIud2lkdGggKyAxMFxuXHRcdEBjb250ZW50LndpZHRoICs9IGl0ZW1MYXllci53aWR0aCArIDEwXG5cbmNsYXNzIGV4cG9ydHMuSXRlbVxuXHRjb2xvcjogJ3JlZCdcblx0bmFtZTogbnVsbFxuXHRjb25zdHJ1Y3RvcjogKG5hbWUsY29sb3IpIC0+XG5cdFx0QG5hbWUgPSBuYW1lXG5cdFx0QGNvbG9yID0gY29sb3JcblxuY2xhc3MgZXhwb3J0cy5CdXR0b24gZXh0ZW5kcyBMYXllclxuXHRjb25zdHJ1Y3RvcjogKG9wdGlvbnMpIC0+XG5cdFx0c3VwZXIgb3B0aW9uc1xuXHRcdEBsb29rID0gb3B0aW9ucy5sb29rXG5cdFx0QGN1cnJlbnROZXdQb3NpdGlvbiA9IEBtYXhYICsgMTBcblx0XHRAaXRlbSA9IG5ldyBleHBvcnRzLkl0ZW0ob3B0aW9ucy5uYW1lLFV0aWxzLnJhbmRvbUNvbG9yKCkpXG5cblx0XHRAb25DbGljayAtPlxuXHRcdFx0QGNyZWF0ZUxheWVyTmV4dFRvSXQoKVxuXG5cdGNyZWF0ZUxheWVyTmV4dFRvSXQ6ICgpIC0+XG5cdFx0QGxvb2suYWRkTmV3SXRlbShAaXRlbSlcbiIsIiMgQWRkIHRoZSBmb2xsb3dpbmcgbGluZSB0byB5b3VyIHByb2plY3QgaW4gRnJhbWVyIFN0dWRpby4gXG4jIG15TW9kdWxlID0gcmVxdWlyZSBcIm15TW9kdWxlXCJcbiMgUmVmZXJlbmNlIHRoZSBjb250ZW50cyBieSBuYW1lLCBsaWtlIG15TW9kdWxlLm15RnVuY3Rpb24oKSBvciBteU1vZHVsZS5teVZhclxuXG5leHBvcnRzLm15VmFyID0gXCJteVZhcmlhYmxlXCJcblxuZXhwb3J0cy5teUZ1bmN0aW9uID0gLT5cblx0cHJpbnQgXCJteUZ1bmN0aW9uIGlzIHJ1bm5pbmdcIlxuXG5leHBvcnRzLm15QXJyYXkgPSBbMSwgMiwgM10iLCIoZnVuY3Rpb24gZSh0LG4scil7ZnVuY3Rpb24gcyhvLHUpe2lmKCFuW29dKXtpZighdFtvXSl7dmFyIGE9dHlwZW9mIHJlcXVpcmU9PVwiZnVuY3Rpb25cIiYmcmVxdWlyZTtpZighdSYmYSlyZXR1cm4gYShvLCEwKTtpZihpKXJldHVybiBpKG8sITApO3ZhciBmPW5ldyBFcnJvcihcIkNhbm5vdCBmaW5kIG1vZHVsZSAnXCIrbytcIidcIik7dGhyb3cgZi5jb2RlPVwiTU9EVUxFX05PVF9GT1VORFwiLGZ9dmFyIGw9bltvXT17ZXhwb3J0czp7fX07dFtvXVswXS5jYWxsKGwuZXhwb3J0cyxmdW5jdGlvbihlKXt2YXIgbj10W29dWzFdW2VdO3JldHVybiBzKG4/bjplKX0sbCxsLmV4cG9ydHMsZSx0LG4scil9cmV0dXJuIG5bb10uZXhwb3J0c312YXIgaT10eXBlb2YgcmVxdWlyZT09XCJmdW5jdGlvblwiJiZyZXF1aXJlO2Zvcih2YXIgbz0wO288ci5sZW5ndGg7bysrKXMocltvXSk7cmV0dXJuIHN9KSJdLCJuYW1lcyI6W10sIm1hcHBpbmdzIjoiQUVBQTtBRElBLE9BQU8sQ0FBQyxLQUFSLEdBQWdCOztBQUVoQixPQUFPLENBQUMsVUFBUixHQUFxQixTQUFBO1NBQ3BCLEtBQUEsQ0FBTSx1QkFBTjtBQURvQjs7QUFHckIsT0FBTyxDQUFDLE9BQVIsR0FBa0IsQ0FBQyxDQUFELEVBQUksQ0FBSixFQUFPLENBQVA7Ozs7QURUbEIsSUFBQTs7O0FBQU0sT0FBTyxDQUFDOzs7Ozs7O2lCQUNiLFFBQUEsR0FBVTs7aUJBQ1YsS0FBQSxHQUFPOztpQkFDUCxVQUFBLEdBQVksU0FBQyxJQUFEO0FBQ1gsUUFBQTtJQUFBLElBQUcsNkJBQUg7QUFDQyxhQUREOztJQUVBLElBQUMsQ0FBQSxLQUFNLENBQUEsSUFBSSxDQUFDLElBQUwsQ0FBUCxHQUFvQjtJQUNwQixTQUFBLEdBQWdCLElBQUEsS0FBQSxDQUNmO01BQUEsSUFBQSxFQUFNLElBQUksQ0FBQyxJQUFYO01BQ0EsTUFBQSxFQUFRLElBQUMsQ0FBQSxPQURUO01BRUEsQ0FBQSxFQUFHLElBQUMsQ0FBQSxRQUZKO01BR0EsZUFBQSxFQUFpQixJQUFJLENBQUMsS0FIdEI7S0FEZTtJQUtoQixJQUFDLENBQUEsUUFBRCxJQUFhLFNBQVMsQ0FBQyxLQUFWLEdBQWtCO1dBQy9CLElBQUMsQ0FBQSxPQUFPLENBQUMsS0FBVCxJQUFrQixTQUFTLENBQUMsS0FBVixHQUFrQjtFQVZ6Qjs7OztHQUhjOztBQWVyQixPQUFPLENBQUM7aUJBQ2IsS0FBQSxHQUFPOztpQkFDUCxJQUFBLEdBQU07O0VBQ08sY0FBQyxJQUFELEVBQU0sS0FBTjtJQUNaLElBQUMsQ0FBQSxJQUFELEdBQVE7SUFDUixJQUFDLENBQUEsS0FBRCxHQUFTO0VBRkc7Ozs7OztBQUlSLE9BQU8sQ0FBQzs7O0VBQ0EsZ0JBQUMsT0FBRDtJQUNaLHdDQUFNLE9BQU47SUFDQSxJQUFDLENBQUEsSUFBRCxHQUFRLE9BQU8sQ0FBQztJQUNoQixJQUFDLENBQUEsa0JBQUQsR0FBc0IsSUFBQyxDQUFBLElBQUQsR0FBUTtJQUM5QixJQUFDLENBQUEsSUFBRCxHQUFZLElBQUEsT0FBTyxDQUFDLElBQVIsQ0FBYSxPQUFPLENBQUMsSUFBckIsRUFBMEIsS0FBSyxDQUFDLFdBQU4sQ0FBQSxDQUExQjtJQUVaLElBQUMsQ0FBQSxPQUFELENBQVMsU0FBQTthQUNSLElBQUMsQ0FBQSxtQkFBRCxDQUFBO0lBRFEsQ0FBVDtFQU5ZOzttQkFTYixtQkFBQSxHQUFxQixTQUFBO1dBQ3BCLElBQUMsQ0FBQSxJQUFJLENBQUMsVUFBTixDQUFpQixJQUFDLENBQUEsSUFBbEI7RUFEb0I7Ozs7R0FWTyJ9
