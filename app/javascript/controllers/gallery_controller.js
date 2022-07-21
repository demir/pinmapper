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
    lightbox.init()
  }
}