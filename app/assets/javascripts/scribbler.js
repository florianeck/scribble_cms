// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

window.initScribblerTinyMce = function(){
  tinymce.remove("textarea")
 tinyMCE.init({
   mode: 'textareas',
   theme: 'modern',
   plugins: "autolink code colorpicker hr image link lists paste table textcolor",
   menubar: '',
   toolbar: "undo redo | styleselect | bold italic | link unlink image | alignleft aligncenter alignright | bullist numlist table | textcolor | code",
   valid_elements : '*[*]',
   elementpath: false,
   statusbar: false
  });
}

$(document).ready(function() {
  window.initScribblerTinyMce()
});
