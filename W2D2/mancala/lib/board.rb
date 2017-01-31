require 'byebug'

class Board
  attr_accessor :cups

  def initialize(name1, name2)
    @name1 = name1
    @name2 = name2
    @cups = Array.new(14) { Array.new }
    place_stones
  end

  def place_stones
    # helper method to #initialize every non-store cup with four stones each
    @cups.each_index do |idx|
      4.times { |time| @cups[idx] += [:stone] } unless idx == 6 || idx == 13
    end
  end

  def valid_move?(start_pos)
    if start_pos > 14 || start_pos < 1
      raise "Invalid starting cup"
    end
  end

  def make_move(start_pos, current_player_name)
    # debugger
    stones = @cups[start_pos].count
    @cups[start_pos] = []
    curr_cup = start_pos

    while stones > 0
      curr_cup = (curr_cup + 1) % 14
      if current_player_name == @name1 && curr_cup != 13
        @cups[curr_cup].concat([:stone])
        stones -= 1
      elsif current_player_name == @name2 && curr_cup != 6
        @cups[curr_cup].concat([:stone])
        stones -= 1
      end
    end

    render

    next_turn(curr_cup, current_player_name)
  end

  def next_turn(end_cup_idx, current_player)
    # helper method to determine what #make_move returns
    if current_player == @name1 && end_cup_idx == 6
      :prompt
    elsif current_player == @name2 && end_cup_idx == 13
      :prompt
    elsif @cups[end_cup_idx].count == 1
      :switch
    elsif @cups[end_cup_idx].count > 1
      end_cup_idx
    else
      :prompt
    end
  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def one_side_empty?
    top = @cups[7..12].all? { |cup| cup.empty? }
    bottom = @cups[0..5].all? { |cup| cup.empty? }
    return true if top || bottom
    false
  end

  def winner
    case @cups[13].count <=> @cups[6].count
    when -1 
      @name1
    when 0
      :draw
    when 1
      @name2
    end
  end
end
