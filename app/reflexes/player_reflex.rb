class PlayerReflex < ApplicationReflex
  def play
    music = Music.find(element.dataset["music"])
    playlist = Playlist.find(element.dataset["playlist"]) if element.dataset["playlist"]

    session[:player] ||= {}
    session[:player][:music] = music

    session[:player][:playlist] = playlist.musics.select(:id).to_a

    update_player
  end

  def displace
    displacement = element.dataset["displacement"] || 1

    i = session[:player][:playlist].index session[:player][:music]

    if i + 1 > session[:player][:playlist].size - 1
      morph :nothing
      return
    end

    session[:player][:music] = session[:player][:playlist][i + displacement.to_i].reload

    update_player
  end

  def download_music
    music = Music.find(element.dataset["music"])

    music.set_music
  end

  def delete_music
    music = Music.find(element.dataset["music"])

    music.destroy
  end

  private

  def update_player
    cable_ready.outer_html(selector: "#player", html: render(Player::Component.new, layout: false))
    if /\/player$/.match?(request.path)
      cable_ready.inner_html(selector: "#player_viewer", html: render(Musics::Viewer::Component.new(music: session[:player][:music]), layout: false))
    end
    cable_ready.broadcast
    morph :nothing
  end
end
