# frozen_string_literal: true

require_relative 'player'
require_relative 'treasure_trove'
require_relative 'game'

describe Player do
  before do
    $stdout = StringIO.new
    @player = Player.new('larry', 150)
    @initial_health = 150
  end

  it 'has a capitalized name' do
    expect(@player.name).to eql('Larry')
  end

  it 'has an initial health' do
    expect(@player.health).to eql(150)
  end

  it 'has a string representation' do
    @player.found_treasure(Treasure.new(:hammer, 50))
    @player.found_treasure(Treasure.new(:hammer, 50))

    expect(@player.to_s).to eql("I'm Larry with health = 150, points = 100, and score = 250.")
  end

  it 'computes a score as the sum of its health and points' do
    @player.found_treasure(Treasure.new(:hammer, 50))
    @player.found_treasure(Treasure.new(:hammer, 50))

    @player.score.should == 250
  end

  it 'increases health by 15 when w00ted' do
    @player.w00t

    expect(@player.health).to eql(@initial_health + 15)
  end

  it 'decreases health by 10 when blammed' do
    @player.blam

    expect(@player.health).to eql(@initial_health - 10)
  end

  context 'with a health greater than 100' do
    before do
      @initial_health = 150
      @player = Player.new('larry', @initial_health)
    end

    it 'is strong' do
      expect(@player).to be_strong
    end
  end

  context 'with a health of 100 or less' do
    before do
      @initial_health = 100
      @player = Player.new('larry', @initial_health)
    end

    it 'is wimpy' do
      expect(@player).not_to be_strong
    end
  end

  context 'in a collection of players' do
    before do
      @player1 = Player.new('moe', 100)
      @player2 = Player.new('larry', 200)
      @player3 = Player.new('curly', 300)

      @players = [@player1, @player2, @player3]
    end

    it 'is sorted by decreasing score' do
      expect(@players.sort).to eql([@player3, @player2, @player1])
    end
  end

  it 'computes points as the sum of all treasure points' do
    expect(@player.points).to eql(0)

    @player.found_treasure(Treasure.new(:hammer, 50))

    expect(@player.points).to eql(50)

    @player.found_treasure(Treasure.new(:crowbar, 400))

    expect(@player.points).to eql(450)

    @player.found_treasure(Treasure.new(:hammer, 50))

    expect(@player.points).to eql(500)
  end

  it 'computes total points as the sum of all player points' do
    game = Game.new('Knuckleheads')

    player1 = Player.new('moe')
    player2 = Player.new('larry')

    game.add_player(player1)
    game.add_player(player2)

    player1.found_treasure(Treasure.new(:hammer, 50))
    player1.found_treasure(Treasure.new(:hammer, 50))
    player2.found_treasure(Treasure.new(:crowbar, 400))

    game.total_points.should == 500
  end

  it 'yields each found treasure and its total points' do
    @player.found_treasure(Treasure.new(:skillet, 100))
    @player.found_treasure(Treasure.new(:skillet, 100))
    @player.found_treasure(Treasure.new(:hammer, 50))
    @player.found_treasure(Treasure.new(:bottle, 5))
    @player.found_treasure(Treasure.new(:bottle, 5))
    @player.found_treasure(Treasure.new(:bottle, 5))
    @player.found_treasure(Treasure.new(:bottle, 5))
    @player.found_treasure(Treasure.new(:bottle, 5))

    yielded = []
    @player.each_found_treasure do |treasure|
      yielded << treasure
    end

    yielded.should == [
      Treasure.new(:skillet, 200),
      Treasure.new(:hammer, 50),
      Treasure.new(:bottle, 25)
    ]
  end
end
