# coding: utf-8
require './engine'

class Game
  include Engine
  attr_accessor :players, :status, :turn, :round, :events

  def initialize
    self.status = :waiting
    self.events = {}
    self.players = {}
  end

  def game_start
    self.turn = 1
    self.round = 1
    self.status = :playing
    self.players.each { |id, player| player.fresh_actions }
  end

  def game_start_pick
    self.turn = 1
    self.status = :picking
    broadcast as_json.merge(action: "start_pick").to_json
    broadcast_game_status
  end

  def game_over
    self.status = :waiting
    self.players[1].ready = false
    self.players[2].ready = false
  end

  def change_turn
    self.turn = 3 - self.turn
    unless players[1].has_actions? or players[2].has_actions?
      next_round
    end
  end

  def next_round
    self.round += 1
    self.players.each { |id, p| p.fresh_actions }

    self.players.each do |id, p|
      p.heros.values.each do |h|
        if h.is_a? Zhiheng
          h.add_current_health(10)
        end
      end
    end

  end

  def large_screen
    case self.status
    when :waiting
      "游戏等待中"
    when :picking
      "选人阶段，玩家#{turn}选择"
    when :playing
      "第#{round}回合，轮到玩家#{turn}。"
    end
  end

  def as_json
    h = {
      status: status,
      large_screen: large_screen,
      turn: turn,
      round: round,
    }
    if players[1]
      h.merge!(player1: players[1].heros, player1_ready: players[1].ready)
    end

    if players[2]
      h.merge!(player2: players[2].heros, player2_ready: players[2].ready)
    end

    h
  end

  def broadcast_game_status notice = nil
    h = as_json.merge({action: "game_status"})
    h.merge!(notice: notice) if notice

    broadcast h.to_json
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