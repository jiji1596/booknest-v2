import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr"; // You need to import this to use new flatpickr()

// Connects to data-controller="datepicker"
export default class extends Controller {
  connect() {
    const bookedPeriods = JSON.parse(this.element.dataset.bookedPeriods || "[]")
    console.log("Booked periods:", bookedPeriods)

    const bookedRanges = bookedPeriods.map(range => ({
      from: range[0],
      to: range[1]
    }));
    flatpickr(this.element, {
      mode: "range",
      minDate: "today",
      disable: bookedRanges
    });
  }
}
