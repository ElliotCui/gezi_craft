# coding: utf-8
class Player
  attr_accessor :ws, :ready, :position, :heros, :game

  def initialize game, ws, position
    self.game = game
    self.ws = ws
    self.heros = {}
    self.position = position
    self.ready = false

    bind_callback
  end

  def fresh_actions
    self.heros.each do |id, h|
      h.turn_attack = true
      h.turn_move = true
    end
  end

  def has_actions?
    self.heros.map { |id, h| [h.turn_attack, h.turn_move] }.flatten.any?
  end

  def random_hero
    heros[heros.keys.sample]
  end

  def opponent
    self.game.players[3-position]
  end

  def to_json *args
    heros.to_json
  end

  def bleed hero, damage
    hero.current_health -= damage
    if hero.current_health <= 0
      heros.delete hero.id
    end

    if heros.empty?
      game.broadcast_game_status
      ws.send({action: 'game_over', result: 'loser'}.to_json)
      opponent.ws.send({action: 'game_over', result: 'winner'}.to_json)
      game.game_over
      # game.broadcast(game.as_json.merge({action: 'game_over', winner: "玩家#{opponent.position}" }).to_json)
      return false
    end
    true
  end

  private

  def get_player
    ws.send({action: "get_player", position: position}.to_json)
    game.broadcast_game_status
  end

  def get_heros
    ws.send({action: "get_heros", heros: Hero.heros.to_json}.to_json)
  end

  def bind_callback
    self.ws.onmessage { |msg|
      begin
        json = JSON(msg)
      rescue JSON::ParserError
        ws.send("json格式错误")
        next
      end

      puts json

      args = json.values
      action = args[0]
      begin
        if %w(get_player get_heros).include? action
          send(action, *args[1..-1])
        else
          game.send(action, *(args[1..-1].unshift(position)))
        end
      rescue Exception => e
        puts "Error: #{e}"
      end
    }

    self.ws.onclose {
      self.game.players[position] = nil
      puts "player#{position} left"
    }
  end
end