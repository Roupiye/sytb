class Musics::List::ComponentReflex < ApplicationReflex
  def load
    offset = element.dataset["offset"].to_i
    playlist = Playlist.find element.dataset["playlist"]
    load_size = element.dataset["load"].to_i

    musics = playlist.musics.order(:id).with_attached_thumbnail.strict_loading.offset(offset).first(load_size)

    cable_ready
      .insert_adjacent_html(selector: "#music_list_content", html: render(Musics::List::Content::Component.new(musics: musics, playlist: playlist), layout: false))
      .broadcast
    morph "#music_list_controller", render(Musics::List::Controller::Component.new(playlist: playlist, offset: offset + load_size), layout: false)
  end
end
