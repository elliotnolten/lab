 $(function() {

  // File uploader
  function handleFileSelect(evt) {

    var files = evt.target.files; // FileList object

    // Loop through the FileList and render image files as thumbnails.
    for (var i = 0, f; f = files[i]; i++) {

      // Only process image files.
      if (!f.type.match('image.*')) {
        continue;
      }

      var reader = new FileReader();

      // Closure to capture the file information.
      reader.onload = (function(theFile) {
        return function(e) {
          // Render thumbnail.
          var span = document.createElement('span');
          span.innerHTML = ['<div class="lookbook"><div class="image"><img class="img" src="', e.target.result, '" title="', escape(theFile.name), '"></div><div class="title"><p>Sienna</p><p>Light grey plain</p></div></div><input type="button" class="btnSave" value="Save PNG">'].join('');
          document.getElementById('list').insertBefore(span, null);
          blendPrint($('.lookbook'));
        };
      })(f);

      // Read in the image file as a data URL.
      reader.readAsDataURL(f);

    }

  }

  document.getElementById('files').addEventListener('change', handleFileSelect, false);

  var blendPrint = function(el) {

      el.find('img').blendmode({
        "mode":"multiply",
        "object": "#f2f2f2"
      });

      el.find('.btnSave').click(function() { 
        html2canvas($(this), {
          onrendered: function(canvas) {
            theCanvas = canvas;
            document.body.appendChild(canvas);
            Canvas2Image.saveAsPNG(canvas); 
            $("#img-out").append(canvas);
          }
        });
      });

  };

  // $('.lookbook').each(function(){

  //   btnSave = $(this).find(".btnSave");

  //   btnSave.click(function() { 

  //     html2canvas($(".lookbook"), {
  //       onrendered: function(canvas) {
  //         theCanvas = canvas;
  //         document.body.appendChild(canvas);
  //           Canvas2Image.saveAsPNG(canvas); 
  //           $("#img-out").append(canvas);
  //         }
  //       });
  //   });
  // });

});

