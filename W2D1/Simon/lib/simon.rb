class Simon

  COLORS = %w(red blue green yellow)

  attr_accessor :sequence_length, :game_over, :seq

  def initialize
    @sequence_length = 1
    @game_over = false
    @seq = []
  end

  def play
    until @game_over
      take_turn
    end

    game_over_message
    reset_game
  end

  def take_turn
    show_sequence
    @game_over = require_sequence

    if !@game_over
      round_success_message
      @sequence_length += 1
    else
      return false
    end
  end

  def show_sequence
    add_random_color
    @seq.each do |color|
      puts "#{color}"
      sleep(1)
      system('clear')
    end
  end

  def require_sequence
    seq_copy = @seq.dup

    until seq_copy.empty?
      color_guess = get_user_guess
      if color_guess == seq_copy.first
        seq_copy.shift
      else
        return false
      end
    end

    true
  end

  def get_user_guess
    puts "Enter next color: #{COLORS}\n"
    gets.chomp.downcase
  end

  def add_random_color
    @seq << COLORS.sample
  end

  def round_success_message
    puts "Good job"
  end

  def game_over_message
    puts "You lost, try again to beat your high score"
  end

  def reset_game
    @sequence_length = 1
    @game_over = false
    @seq = []
  end
end
