import ApplicationController from '../../javascript/controllers/application_controller'
import Cookies from 'js-cookie'

export default class extends ApplicationController {
  static targets = ["player", "loopbtn"]

  connect() {
    super.connect()

    var t = this

    if(Cookies.get("volume")) {
      this.playerTarget.volume = Cookies.get("volume")
    }

    if(Cookies.get("loop")) {
      this.loopbtnTarget.classList.add("text-blue-200")
    }

    this.playerTarget.play()

    this.playerTarget.addEventListener("ended", function(){
        if(Cookies.get("loop")){
          t.playerTarget.currentTime = 0
          t.playerTarget.play()
          return
        }
        t.next()
    });

    this.playerTarget.addEventListener("volumechange", () => {
      var v = this.playerTarget.volume
      Cookies.set("volume", v)
    }, false);
  }

  next() {
    this.stimulate('PlayerReflex#displace')
  }

  loop() {
    if(Cookies.get("loop")) {
      Cookies.remove("loop")
      this.loopbtnTarget.classList.remove("text-blue-200")
    }
    else {
      Cookies.set("loop", true)
      this.loopbtnTarget.classList.add("text-blue-200")
    }
  }
}
