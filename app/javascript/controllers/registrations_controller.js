import { Controller } from 'stimulus';

export default class extends Controller {

  static targets = [ "accessNeeded" ]

  connect() {
    this.userTypeChanged()
  }

  userTypeChanged() {
    const value = this.accessNeededTarget.value;
    this.element.querySelectorAll('[data-show-if]').forEach((element) => {
      if(element.getAttribute('data-show-if') === value) {
        element.removeAttribute('hidden')
      } else {
        element.setAttribute('hidden', 'hidden')
      }
    })
    this.element.querySelectorAll('[data-show-if-blank]').forEach((element) => {
      if(value === "") {
        element.removeAttribute('hidden')
      } else {
        element.setAttribute('hidden', 'hidden')
      }
    })
  }
}
