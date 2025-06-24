import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    setTimeout(() => {
      this.element.remove()
    }, 3000) // desaparece tras 3 segundos
  }
}
