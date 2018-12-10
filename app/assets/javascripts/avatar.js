// $(document).ready(function() {
//   $('.upload-button').click(function() {
//     $(this).css({background: 'red'});
// $("#btnupload").click(function(){ $("#inpupload").trigger("click");
    window.addEventListener('load', function() {
      document.querySelector('input[type="file"]').addEventListener('change', function() {
        if (this.files && this.files[0]) {
          var img = document.getElementsByClassName('photo');
          // console.log(img);
          for(i=0; i<img.length; i++){
            img[i].src = URL.createObjectURL(this.files[0]);
          }

          var formData = new FormData(img);
          $.ajax({
            url: Routes.account_profile_path,
            type: 'PATCH',
            data: formData,
            contentType: false,
            processData: false
          });

        }
      });
    });
//     });
// });
    // var parentEl = document.getElementById("avatar"),
    // img = document.createElement("IMG");
    // img.src = "http://www.stihi.ru/pics/2010/02/27/2487.jpg";
    //
    // parentEl.appendChild(img);




  // $('input[name="avatar"]').change(function() {
  //   var file = $('input[name="avatar"]').get(0).files[0];
  //   if(!file.type.match(/^image.*$/)) {
  //     alert('Wrong format file')
  //   } else {
  //     var img = document.createElement('img');
  //     let formData = new FormData();
  //     formData.append("image", file);
  //     function (img) {
  //       $(img).attr({'class':'crop-image'});
  //       $('.crop-image').replaceWith(img);
  //     }
      // window.loadImage(
      //   file,
      //   function (img) {
      //     $(img).attr({'class':'crop-image'});
      //     $('.crop-image').replaceWith(img);
      //   },
      //   {
      //     minWidth: 240,
      //     minheight: 240
      //   }
      // );
    // }
  // });
// });
