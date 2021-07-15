import ApplicationController from '../../../javascript/controllers/application_controller'

export default class extends ApplicationController {
  connect() {
    super.connect()
    this.disabled = false

    console.log("a")
  }

  scroll() {
    var body = document.body,
      html = document.documentElement

    var height = Math.max(body.scrollHeight, body.offsetHeight, html.clientHeight, html.scrollHeight, html.offsetHeight)

    if(window.pageYOffset >= height - window.innerHeight - 200) {
      if(this.disabled == false) {
        this.disabled = true
        this.stimulate('Musics::List::ComponentReflex#load')
      }
    }
    else {
      this.disabled = false
    }
  }
}
