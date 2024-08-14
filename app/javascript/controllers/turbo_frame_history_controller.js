import { Controller } from "@hotwired/stimulus";
import { Turbo } from "@hotwired/turbo-rails";

// Connects to data-controller="turbo-frame-history"
export default class extends Controller {
  connect() {}

  navigate() {
    const url = this.element.getAttribute("href");
    Turbo.navigator.history.push(new URL(url));
  }
}
