import { Controller } from "stimulus"
import "leaflet/dist/leaflet.css"
import 'leaflet-defaulticon-compatibility/dist/leaflet-defaulticon-compatibility.webpack.css';
import L from "leaflet"
import 'leaflet-defaulticon-compatibility';
import 'leaflet.markercluster';

export default class extends Controller {
  static targets = ["container"]
  static values = { markers: String }

  connect() {
    this.map = L.map(this.containerTarget, {
      center: [23.317806692279813, 19.506879861220607],
      minZoom: 2
    })

    L.tileLayer('https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}', {
      attribution: 'Map data &copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors, Imagery © <a href="https://www.mapbox.com/">Mapbox</a>',
      maxZoom: 18,
      id: 'mapbox/streets-v11',
      tileSize: 512,
      zoomOffset: -1,
      accessToken: 'pk.eyJ1IjoicGlubWFwcGVyIiwiYSI6ImNrem4zc25rcjA0bTkyb3F1aWJ3b2lpaW4ifQ.Iov1BT5eiryI0cU8uTGKQQ'
    }).addTo(this.map);

    var markerClusters = L.markerClusterGroup({
      polygonOptions: {
        opacity: 0,
        fillOpacity: 0
      }
    });

    var markers = JSON.parse(this.markersValue)
    for (var i = 0; i < markers.length; ++i) {
      var m = L.marker([markers[i].latitude, markers[i].longitude], { id: markers[i].id }).bindPopup(markers[i].popup);
      markerClusters.addLayer(m);
    }

    this.map.addLayer(markerClusters);
    this.map.fitBounds(markerClusters.getBounds());
  }

  disconnect() {
    this.map.remove()
  }
}