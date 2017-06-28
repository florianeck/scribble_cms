// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

window.initScribblerTinyMce = function(){
  tinymce.remove("textarea")
  $('textarea').not('.plain').tinymce({
    mode: 'textareas',
    theme: 'modern',
    plugins: "autolink code colorpicker hr image link lists paste table textcolor",
    menubar: '',
    toolbar: "undo redo | styleselect | bold italic | link unlink image | alignleft aligncenter alignright | bullist numlist table | textcolor fontsizeselect | code",
    valid_elements : '*[*]',
    elementpath: false,
    statusbar: true,
    fontsize_formats: "8px 10px 12px 14px 16px 18px 24pt 36px 48px"
  });
}

$(document).ready(function() {
  window.initScribblerTinyMce()
});
