import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["name"]

  greet() {
    alert(`Hello, ${this.nameTarget.value}!`)
  }
}
