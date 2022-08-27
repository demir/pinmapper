import { Controller } from "stimulus"
import Cropper from "cropperjs"
import "cropperjs/dist/cropper.css"

export default class extends Controller {
  static targets = ["image"]
  static values = { model: String, cropModel: String, cropperType: String }

  changed() {
    let _this = this
    var minAspectRatio = 0.8;
    var maxAspectRatio = 1.91;
    var options = {
      minCropBoxWidth: 200,
      minCropBoxHeight: 50,
      zoomOnWheel: false,
      viewMode: 1,
      responsive: true,
      initialAspectRatio: 0.8,
      cropmove: function (e) {
        var cropBoxData = e.target.cropper.getCropBoxData();
        var cropBoxWidth = cropBoxData.width;
        var aspectRatio = cropBoxWidth / cropBoxData.height;

        if (aspectRatio < minAspectRatio) {
          e.target.cropper.setCropBoxData({
            height: cropBoxWidth / minAspectRatio
          });
        } else if (aspectRatio > maxAspectRatio) {
          e.target.cropper.setCropBoxData({
            height: cropBoxWidth / maxAspectRatio
          });
        }
      },
      crop(event) {
        _this.crop_x().value = event.detail.x
        _this.crop_y().value = event.detail.y
        _this.crop_width().value = event.detail.width
        _this.crop_height().value = event.detail.height
      }
    }
    if (this.cropperTypeValue === 'rounded') {
      options['aspectRatio'] = 1 / 1
    }

    if (this.imageTarget.cropper) {
      this.imageTarget.cropper.destroy()
    }
    new Cropper(this.imageTarget, options)
  }

  crop_x() {
    if (this._crop_x == undefined) {
      this._crop_x = document.createElement("input")
      this._crop_x.name = `${this.modelValue}[${this.cropModelValue}_attributes][crop_x]`
      this._crop_x.type = "hidden"
      this.imageTarget.parentNode.insertBefore(this._crop_x, this.imageTarget.nextSibling)
    }
    return this._crop_x
  }

  crop_y() {
    if (this._crop_y == undefined) {
      this._crop_y = document.createElement("input")
      this._crop_y.name = `${this.modelValue}[${this.cropModelValue}_attributes][crop_y]`
      this._crop_y.type = "hidden"
      this.imageTarget.parentNode.insertBefore(this._crop_y, this.imageTarget.nextSibling)
    }
    return this._crop_y
  }

  crop_width() {
    if (this._crop_width == undefined) {
      this._crop_width = document.createElement("input")
      this._crop_width.name = `${this.modelValue}[${this.cropModelValue}_attributes][crop_width]`
      this._crop_width.type = "hidden"
      this.imageTarget.parentNode.insertBefore(this._crop_width, this.imageTarget.nextSibling)
    }
    return this._crop_width
  }

  crop_height() {
    if (this._crop_height == undefined) {
      this._crop_height = document.createElement("input")
      this._crop_height.name = `${this.modelValue}[${this.cropModelValue}_attributes][crop_height]`
      this._crop_height.type = "hidden"
      this.imageTarget.parentNode.insertBefore(this._crop_height, this.imageTarget.nextSibling)
    }
    return this._crop_height
  }
}