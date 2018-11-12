# frozen_string_literal: true

require_relative 'player'
require_relative 'DIE'
require_relative 'treasure_trove'

#
# GameTurn
#
module GameTurn
  @die = Die.new

  def self.die
    @die
  end

  def self.take_turn(player)
    number_rolled = @die.roll

    case number_rolled
    when 1..2
      player.blam
    when 3..4
      puts "#{player.name} was skipped"
    else
      player.w00t
    end

    treasure = TreasureTrove.random
    player.found_treasure(treasure)
  end
end
