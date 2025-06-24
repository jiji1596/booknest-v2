import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.element.addEventListener("dblclick", () => {
      window.scrollTo({ top: 0, behavior: "smooth" });
    });
  }
}
