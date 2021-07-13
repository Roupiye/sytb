import ApplicationController from '../../javascript/controllers/application_controller'
import Cookies from 'js-cookie'

export default class extends ApplicationController {
  static targets = ["player"]

  connect() {
    this.playerTarget.volume = Cookies.get("volume")

    // this.playerTarget.play()

    this.playerTarget.addEventListener("volumechange", () => {
      var v = this.playerTarget.volume
      // console.log(v)
      Cookies.set("volume", v)
    }, false);

    // this.playerTarget.addEventListener("pause", () => {
    //   // console.log("pause")
    //   Cookies.set("play", false)
    // }, false);
    //
    //
    // this.playerTarget.addEventListener("play", () => {
    //   // console.log("play")
    //   Cookies.set("play", true)
    // }, false);
  }
}
