function CopyToClipboard() {
  var text =  $("#show_invitation_link");
  text.select();
  document.execCommand("copy");
};