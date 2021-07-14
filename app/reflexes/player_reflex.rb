class PlayerReflex < ApplicationReflex
  def play
    music = Music.find(element.dataset["music"])

    session[:player] = music
  end

  def download_music
    music = Music.find(element.dataset["music"])

    music.set_music
  end

  def delete_music
    music = Music.find(element.dataset["music"])

    music.destroy
  end
end
