import "theia-sticky-sidebar/js/theia-sticky-sidebar";

(function ($) {

  "use strict";

  $(document).on('turbo:load', function () {
    $('.hero_in h1,.hero_in form').addClass('animate__animated');
    $('.hero_single, .hero_in').addClass('start_bg_zoom');
    $(window).scroll();

    // Sticky nav
    $(window).on('scroll', function () {
      if ($(this).scrollTop() > 1) {
        $('.header').addClass("sticky");
      } else {
        $('.header').removeClass("sticky");
      }
    });

    // Sticky sidebar
    $('#sidebar').theiaStickySidebar({
      additionalMarginTop: 150
    });

    // Sticky titles
    $('.fixed_title').theiaStickySidebar({
      additionalMarginTop: 180
    });

    // Mobile Menu
    const hamburger = document.getElementById("hamburger");
    if (hamburger) {
      hamburger.addEventListener("click", function (event) {
        document.querySelector(".nav-menu").classList.toggle("active");
        hamburger.classList.toggle("is-active")
      });
    }

    //Scroll to top
    $(window).on('scroll', function () {
      'use strict';
      if ($(this).scrollTop() != 0) {
        $('#toTop').fadeIn();
      } else {
        $('#toTop').fadeOut();
      }
    });
    $('#toTop').on('click', function () {
      $('body,html').animate({
        scrollTop: 0
      }, 500);
    });
  });
})(window.jQuery);


