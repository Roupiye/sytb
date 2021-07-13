class Player::Component < ApplicationComponent
  def initialize
  end

  def render?
    !session[:player].nil?
  end
end
