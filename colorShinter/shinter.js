(function($){
  $.fn.shinter = function(options){
    var settings = $.extend({
      initSet: "https://sheetsu.com/apis/8fea45d7",
      debug: false
    },options);

    function shadeColor(color, percent) {
      var f=parseInt(color.slice(1),16),t=percent<0?0:255,p=percent<0?percent*-1:percent,R=f>>16,G=f>>8&0x00FF,B=f&0x0000FF;
      return "#"+(0x1000000+(Math.round((t-R)*p)+R)*0x10000+(Math.round((t-G)*p)+G)*0x100+(Math.round((t-B)*p)+B)).toString(16).slice(1);
    }

    function hexToRgb(hex) {
      var result = /^#?([a-f\d]{2})([a-f\d]{2})([a-f\d]{2})$/i.exec(hex);
      return result ? {
        r: parseInt(result[1], 16),
        g: parseInt(result[2], 16),
        b: parseInt(result[3], 16)
      } : null;
    }

    var root = this,
        initSet;

    $.ajax({
      url: settings.initSet,
      dataType: 'json',
      async: false,
      success: function(data) {
        initSet = data.result;
        console.log(data.result);
      }
    });

    function generateSets(data) {
      var setCount = data.length,
      setHeight = 100/setCount,
      sets = [];

      $.each(data, function(i,val){
        var name = val.name,
        color = val.color,
        type = val.type,
        steps = val.steps.split(','),
        count = steps.length,
        pol = (type === 'tint') ? 1 : -1,
        tiles = [];

        $.each(steps,function(i){
          var tintInt = pol * steps[i],
          tint = Number(tintInt/100),
          tintHex = shadeColor(color, tint),
          tintRGB = 'rgb(' + hexToRgb(tintHex).r + ',' + hexToRgb(tintHex).g + ',' + hexToRgb(tintHex).b + ')',
          tintTxt = '',
          colorName = ntc.name(tintHex)[1];

          if (i > 0 && type !== 'none') {
            tintTxt = type + '( <strong style="color:' + color + ';">' + color + '</strong>, ' + Math.abs(tint)*100 + '% )';
          }

          var tileTemplate = '' +
          '<div class="fluid-grid__item tile tint ' + tintInt + ' ' + name + 'SW" data-tint="' + tintInt + '" style="width:' + 100/(count) + '%;">' +
          '<div class="swatch" style="background-color:' + tintHex + ';">' +
          '<p class="h-padding--s subtitle small_details">' +
          colorName +
          '</p>' +
          '</div>' +
          '<div class="box">' +
          '<span>' + tintHex + ' ' + tintRGB + '</span><br><span class="subtitle">' + tintTxt + '</span>' +
          '</div>' +
          '</div>';

          tiles.push(tileTemplate);

        });

        sets += '' +
        '<div class="fluid-grid fluid-grid--0 colorSet" id="' + name + '" style="height:' + setHeight + '%;">' +
        tiles.join().replace(',','') +
        '</div>';

        });

      root.append(sets);
    }

    generateSets(initSet);

  }

})(jQuery);
