class PlayerReflex < ApplicationReflex
  def play
    music = Music.find(element.dataset["music"])

    session[:player] = music
  end
end
