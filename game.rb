require './engine'

class Game
  include Engine
  attr_accessor :players, :status, :turn, :round

  def initialize
    self.status = :waiting
    self.players = {}
  end

  def start
    self.round = 1
    self.turn = 1
    self.stats = :playing
    self.players.each { |p| p.fresh_actions }

    broadcast({ action: "start" })
  end

  def game_over
    self.status = :over
  end

  def change_turn
    self.turn = 3 - self.turn
    unless players[1].has_actions? or players[2].has_actions?
      next_round
    end
  end

  def next_round
    round += 1
    self.players.each { |p| p.fresh_actions }
  end

  def as_json
    {
      status: status,
      turn: turn,
      round: round,
      player1: players[1].to_json,
      player2: players[2].to_json,
    }
  end

  def broadcast message
    players[1].ws.send message if players[1]
    players[2].ws.send message if players[2]
  end

  def add_player ws
    if players[1].nil?
      self.players[1] = Player.new(self, ws, 1)
      puts "Player1 Connected!"
      return 1
    end

    if players[2].nil?
      self.players[2] = Player.new(self, ws, 2)
      puts "Player2 Connected!"
      return 2
    end

    # puts "Connect failed!"
    return false
  end
end