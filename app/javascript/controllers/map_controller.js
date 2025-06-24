import { Controller } from "@hotwired/stimulus"
import mapboxgl from 'mapbox-gl' // Don't forget this!

export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array,
    location: Object
  }

  connect() {
    mapboxgl.accessToken = this.apiKeyValue

    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v10"
    })

    this.#addMarkersToMap();
    this.#fitMapToMarkers();
    this.#addLocationToMap();
  }

  #addMarkersToMap() {
  this.markersValue.forEach((marker) => {
    const popup = new mapboxgl.Popup().setHTML(marker.info_window_html)
    new mapboxgl.Marker({ color: "red" })
      .setLngLat([ marker.lng, marker.lat ])
      .setPopup(popup)
      .addTo(this.map)
  })
  }

  #addLocationToMap() {
    console.log(this.locationValue)
    new mapboxgl.Marker()
      .setLngLat([ this.locationValue.lng, this.locationValue.lat ])
      .addTo(this.map)
  }

  #fitMapToMarkers() {
  const bounds = new mapboxgl.LngLatBounds()
    this.markersValue.forEach(marker => bounds.extend([ marker.lng, marker.lat ]))

    this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 })
  }
}
