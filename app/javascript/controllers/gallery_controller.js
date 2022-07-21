import { Controller } from "stimulus"
import PhotoSwipeLightbox from 'photoswipe/dist/photoswipe-lightbox.esm';
import PhotoSwipe from 'photoswipe/dist/photoswipe.esm';
import 'photoswipe/src/photoswipe.css';

export default class extends Controller {

  connect() {
    const options = {
      gallery: this.element,
      children: 'a.gallery-item',
      showHideAnimationType: 'fade',
      pswpModule: PhotoSwipe
    };
    const lightbox = new PhotoSwipeLightbox(options);
    lightbox.on('uiRegister', function () {
      lightbox.pswp.ui.registerElement({
        name: 'custom-caption',
        order: 9,
        isButton: false,
        appendTo: 'root',
        html: '',
        onInit: (el, pswp) => {
          lightbox.pswp.on('change', () => {
            const currSlideElement = lightbox.pswp.currSlide.data.element;
            let captionHTML = '';
            if (currSlideElement) {
              const hiddenCaption = currSlideElement.querySelector('.hidden-caption-content');
              if (hiddenCaption) {
                captionHTML = hiddenCaption.innerHTML;
              } else {
                captionHTML = currSlideElement.querySelector('img').getAttribute('alt');
              }
            }
            if (captionHTML) {
              el.style.visibility = 'visible';
              el.innerHTML = captionHTML;
            } else {
              el.style.visibility = 'hidden';
            }
          });
        }
      });
    });
    lightbox.init()
  }
}