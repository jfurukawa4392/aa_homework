require_relative 'piece'
require 'singleton'

class NullPiece < Piece

  include Singleton

  def initialize
    @type = nil
    @color = nil

  end

end
