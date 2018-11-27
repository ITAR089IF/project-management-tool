document.addEventListener('DOMContentLoaded', () => {
  // Get all "navbar-burger" elements
  const navbarBurgers = Array.prototype.slice.call(document.querySelectorAll('.navbar-burger'), 0);
  // Check if there are any navbar burgers
  if (navbarBurgers.length > 0) {
    // Add a click event on each of them
    navbarBurgers.forEach( el => {
      el.addEventListener('click', () => {
        // Get the target from the "data-target" attribute
        const elem = el.dataset.target;
        const target = document.getElementById(elem);
        // Toggle the "is-active" class on both the "navbar-burger" and the "navbar-menu"
        el.classList.toggle('is-active');
        target.classList.toggle('is-active');
      });
    });
  }
  var deleteButtons = document.getElementsByClassName('delete');

  for (var i = 0; i < deleteButtons.length; i++) {
    deleteButtons[i].addEventListener('click', dismiss);
  }

  function dismiss(e) {
    this.parentNode.classList.add('is-hidden');
  }

  $('.close').click( function(){
    $('.double_task_form').find('form')[0].reset();
  })

});
