import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="issen"
export default class extends Controller {
  static targets = ["issen", "output"];

  connect() {
    console.log("Hello, I'm issen_controller.js!!!");
  }

  greet() {
    this.outputTarget.textContent = `Hello, ${this.issenTarget.value}!`;
  }
}
