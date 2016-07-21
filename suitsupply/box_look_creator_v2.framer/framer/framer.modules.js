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
//# sourceMappingURL=data:application/json;charset:utf-8;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbIm5vZGVfbW9kdWxlcy9icm93c2VyLXBhY2svX3ByZWx1ZGUuanMiLCIvVXNlcnMvZW5vbHRlbi9Db2RlL2xhYi9zdWl0c3VwcGx5L2JveF9sb29rX2NyZWF0b3JfdjIuZnJhbWVyL21vZHVsZXMvbXlNb2R1bGUuY29mZmVlIiwiL1VzZXJzL2Vub2x0ZW4vQ29kZS9sYWIvc3VpdHN1cHBseS9ib3hfbG9va19jcmVhdG9yX3YyLmZyYW1lci9tb2R1bGVzL3N1aXRzdXBwbHkuY29mZmVlIl0sIm5hbWVzIjpbXSwibWFwcGluZ3MiOiJBQUFBO0FDSUEsT0FBTyxDQUFDLEtBQVIsR0FBZ0I7O0FBRWhCLE9BQU8sQ0FBQyxVQUFSLEdBQXFCLFNBQUE7U0FDcEIsS0FBQSxDQUFNLHVCQUFOO0FBRG9COztBQUdyQixPQUFPLENBQUMsT0FBUixHQUFrQixDQUFDLENBQUQsRUFBSSxDQUFKLEVBQU8sQ0FBUDs7OztBQ1RsQixJQUFBOzs7QUFBTSxPQUFPLENBQUM7Ozs7Ozs7aUJBQ2IsUUFBQSxHQUFVOztpQkFDVixLQUFBLEdBQU87O2lCQUNQLFVBQUEsR0FBWSxTQUFDLElBQUQ7QUFDWCxRQUFBO0lBQUEsSUFBRyw2QkFBSDtBQUNDLGFBREQ7O0lBRUEsSUFBQyxDQUFBLEtBQU0sQ0FBQSxJQUFJLENBQUMsSUFBTCxDQUFQLEdBQW9CO0lBQ3BCLFNBQUEsR0FBZ0IsSUFBQSxLQUFBLENBQ2Y7TUFBQSxJQUFBLEVBQU0sSUFBSSxDQUFDLElBQVg7TUFDQSxNQUFBLEVBQVEsSUFBQyxDQUFBLE9BRFQ7TUFFQSxDQUFBLEVBQUcsSUFBQyxDQUFBLFFBRko7TUFHQSxlQUFBLEVBQWlCLElBQUksQ0FBQyxLQUh0QjtLQURlO0lBS2hCLElBQUMsQ0FBQSxRQUFELElBQWEsU0FBUyxDQUFDLEtBQVYsR0FBa0I7V0FDL0IsSUFBQyxDQUFBLE9BQU8sQ0FBQyxLQUFULElBQWtCLFNBQVMsQ0FBQyxLQUFWLEdBQWtCO0VBVnpCOzs7O0dBSGM7O0FBZXJCLE9BQU8sQ0FBQztpQkFDYixLQUFBLEdBQU87O2lCQUNQLElBQUEsR0FBTTs7RUFDTyxjQUFDLElBQUQsRUFBTSxLQUFOO0lBQ1osSUFBQyxDQUFBLElBQUQsR0FBUTtJQUNSLElBQUMsQ0FBQSxLQUFELEdBQVM7RUFGRzs7Ozs7O0FBSVIsT0FBTyxDQUFDOzs7RUFDQSxnQkFBQyxPQUFEO0lBQ1osd0NBQU0sT0FBTjtJQUNBLElBQUMsQ0FBQSxJQUFELEdBQVEsT0FBTyxDQUFDO0lBQ2hCLElBQUMsQ0FBQSxrQkFBRCxHQUFzQixJQUFDLENBQUEsSUFBRCxHQUFRO0lBQzlCLElBQUMsQ0FBQSxJQUFELEdBQVksSUFBQSxPQUFPLENBQUMsSUFBUixDQUFhLE9BQU8sQ0FBQyxJQUFyQixFQUEwQixLQUFLLENBQUMsV0FBTixDQUFBLENBQTFCO0lBRVosSUFBQyxDQUFBLE9BQUQsQ0FBUyxTQUFBO2FBQ1IsSUFBQyxDQUFBLG1CQUFELENBQUE7SUFEUSxDQUFUO0VBTlk7O21CQVNiLG1CQUFBLEdBQXFCLFNBQUE7V0FDcEIsSUFBQyxDQUFBLElBQUksQ0FBQyxVQUFOLENBQWlCLElBQUMsQ0FBQSxJQUFsQjtFQURvQjs7OztHQVZPIiwiZmlsZSI6ImdlbmVyYXRlZC5qcyIsInNvdXJjZVJvb3QiOiIiLCJzb3VyY2VzQ29udGVudCI6WyIoZnVuY3Rpb24gZSh0LG4scil7ZnVuY3Rpb24gcyhvLHUpe2lmKCFuW29dKXtpZighdFtvXSl7dmFyIGE9dHlwZW9mIHJlcXVpcmU9PVwiZnVuY3Rpb25cIiYmcmVxdWlyZTtpZighdSYmYSlyZXR1cm4gYShvLCEwKTtpZihpKXJldHVybiBpKG8sITApO3ZhciBmPW5ldyBFcnJvcihcIkNhbm5vdCBmaW5kIG1vZHVsZSAnXCIrbytcIidcIik7dGhyb3cgZi5jb2RlPVwiTU9EVUxFX05PVF9GT1VORFwiLGZ9dmFyIGw9bltvXT17ZXhwb3J0czp7fX07dFtvXVswXS5jYWxsKGwuZXhwb3J0cyxmdW5jdGlvbihlKXt2YXIgbj10W29dWzFdW2VdO3JldHVybiBzKG4/bjplKX0sbCxsLmV4cG9ydHMsZSx0LG4scil9cmV0dXJuIG5bb10uZXhwb3J0c312YXIgaT10eXBlb2YgcmVxdWlyZT09XCJmdW5jdGlvblwiJiZyZXF1aXJlO2Zvcih2YXIgbz0wO288ci5sZW5ndGg7bysrKXMocltvXSk7cmV0dXJuIHN9KSIsIiMgQWRkIHRoZSBmb2xsb3dpbmcgbGluZSB0byB5b3VyIHByb2plY3QgaW4gRnJhbWVyIFN0dWRpby4gXG4jIG15TW9kdWxlID0gcmVxdWlyZSBcIm15TW9kdWxlXCJcbiMgUmVmZXJlbmNlIHRoZSBjb250ZW50cyBieSBuYW1lLCBsaWtlIG15TW9kdWxlLm15RnVuY3Rpb24oKSBvciBteU1vZHVsZS5teVZhclxuXG5leHBvcnRzLm15VmFyID0gXCJteVZhcmlhYmxlXCJcblxuZXhwb3J0cy5teUZ1bmN0aW9uID0gLT5cblx0cHJpbnQgXCJteUZ1bmN0aW9uIGlzIHJ1bm5pbmdcIlxuXG5leHBvcnRzLm15QXJyYXkgPSBbMSwgMiwgM10iLCJjbGFzcyBleHBvcnRzLkxvb2sgZXh0ZW5kcyBTY3JvbGxDb21wb25lbnRcblx0cG9zaXRpb246IDBcblx0aXRlbXM6IHt9XG5cdGFkZE5ld0l0ZW06IChpdGVtKSAtPlxuXHRcdGlmIEBpdGVtc1tpdGVtLm5hbWVdP1xuXHRcdFx0cmV0dXJuXG5cdFx0QGl0ZW1zW2l0ZW0ubmFtZV0gPSBpdGVtXG5cdFx0aXRlbUxheWVyID0gbmV3IExheWVyXG5cdFx0XHRodG1sOiBpdGVtLm5hbWVcblx0XHRcdHBhcmVudDogQGNvbnRlbnRcblx0XHRcdHg6IEBwb3NpdGlvblxuXHRcdFx0YmFja2dyb3VuZENvbG9yOiBpdGVtLmNvbG9yXG5cdFx0QHBvc2l0aW9uICs9IGl0ZW1MYXllci53aWR0aCArIDEwXG5cdFx0QGNvbnRlbnQud2lkdGggKz0gaXRlbUxheWVyLndpZHRoICsgMTBcblxuY2xhc3MgZXhwb3J0cy5JdGVtXG5cdGNvbG9yOiAncmVkJ1xuXHRuYW1lOiBudWxsXG5cdGNvbnN0cnVjdG9yOiAobmFtZSxjb2xvcikgLT5cblx0XHRAbmFtZSA9IG5hbWVcblx0XHRAY29sb3IgPSBjb2xvclxuXG5jbGFzcyBleHBvcnRzLkJ1dHRvbiBleHRlbmRzIExheWVyXG5cdGNvbnN0cnVjdG9yOiAob3B0aW9ucykgLT5cblx0XHRzdXBlciBvcHRpb25zXG5cdFx0QGxvb2sgPSBvcHRpb25zLmxvb2tcblx0XHRAY3VycmVudE5ld1Bvc2l0aW9uID0gQG1heFggKyAxMFxuXHRcdEBpdGVtID0gbmV3IGV4cG9ydHMuSXRlbShvcHRpb25zLm5hbWUsVXRpbHMucmFuZG9tQ29sb3IoKSlcblxuXHRcdEBvbkNsaWNrIC0+XG5cdFx0XHRAY3JlYXRlTGF5ZXJOZXh0VG9JdCgpXG5cblx0Y3JlYXRlTGF5ZXJOZXh0VG9JdDogKCkgLT5cblx0XHRAbG9vay5hZGROZXdJdGVtKEBpdGVtKVxuIl19
