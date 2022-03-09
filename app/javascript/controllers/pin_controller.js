import { Controller } from 'stimulus'

export default class extends Controller {
  static targets = ['field', 'map']
  static values = { latitude: String, longitude: String }

  connect() {
    if ((typeof (google) != 'undefined') && this.hasMapTarget) {
      this.initMap()
    }
  }

  initMap() {
    var latLng = new google.maps.LatLng(
      this.latitudeValue || 41.33243830142252,
      this.longitudeValue || 36.288131427151704
    )
    this.map = new google.maps.Map(this.mapTarget, {
      center: latLng,
      zoom: (this.latitudeValue == null ? 4 : 15)
    })
    this.geocoder = new google.maps.Geocoder();

    this.autocomplete = new google.maps.places.Autocomplete(this.fieldTarget)
    this.autocomplete.bindTo('bounds', this.map)
    this.autocomplete.setFields(['address_components', 'geometry', 'icon', 'name'])
    this.autocomplete.addListener("place_changed", this.placeChanged.bind(this));

    this.marker = new google.maps.Marker({
      map: this.map,
      anchorPoint: new google.maps.Point(0, -29)
    })
    this.marker.setPosition(latLng)
    this.marker.setVisible(true)

    this.map.addListener("click", (mapsMouseEvent) => {
      let latLng = mapsMouseEvent.latLng
      this.marker.setPosition(latLng)
      this.geocode({ location: latLng })
    });
  }

  placeChanged() {
    let place = this.autocomplete.getPlace()

    if (!place.geometry) {
      window.alert("No details available for input: ${place.name}")
      return
    }

    if (place.geometry.viewport) {
      this.map.fitBounds(place.geometry.viewport)
    } else {
      this.map.setCenter(place.geometry.location)
      this.map.setZoom(17)
    }
    this.marker.setPosition(place.geometry.location)
    this.marker.setVisible(true)
  }

  keydown(event) {
    if (event.key == 'Enter') {
      event.preventDefault()
    }
  }

  liked(e) {
    e.preventDefault();
    e.currentTarget.classList.toggle('liked');
  }

  geocode(request) {
    this.geocoder
      .geocode(request)
      .then((result) => {
        let address = result.results[0].formatted_address
        this.fieldTarget.value = address
      })
      .catch((e) => {
        console.log("Something went wrong. Please try again.");
      });
  }
}
