import "mmenu-js/dist/mmenu";
import "theia-sticky-sidebar/js/theia-sticky-sidebar";

(function ($) {

  "use strict";

  $(document).on('turbo:load', function () {
    $('[data-loader="circle-side"]').fadeOut(); // will first fade out the loading animation
    $('#preloader').delay(350).fadeOut('slow'); // will fade out the white DIV that covers the website.
    $('body').delay(350);
    $('.hero_in h1,.hero_in form').addClass('animated');
    $('.hero_single, .hero_in').addClass('start_bg_zoom');
    $(window).scroll();
  });

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

  // Mobile Mmenu
  document.addEventListener('turbo:load', () => {
    var hamburger = $("#hamburger");
    const navMenu = document.querySelector(".nav-menu");
    hamburger.on("click", function () {
      navMenu.classList.toggle("active");
      if (hamburger.hasClass("is-active")) {
        hamburger.removeClass("is-active");
      } else {
        hamburger.addClass("is-active");
      }
    });
  });

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

})(window.jQuery);


