# coding: utf-8
require './damage'

module Engine
  def ready player_id
    player = players[player_id]
    player.ready = true
    broadcast_game_status
    check_start_pick
  end

  def pick player_id, hero_id
    player = players[player_id]
    player.heros[hero_id.to_i] = Hero.heros[hero_id.to_i].class.new

    broadcast({action: "disable_hero", hero_id: hero_id}.to_json)

    if players[1].heros.size == 5 and players[2].heros.size == 5
      broadcast_game_status
      game_start
      broadcast({action: 'game_start', notice: "战斗开始了！"}.to_json)
      broadcast_game_status
    else
      self.turn = 3 - self.turn
      broadcast_game_status
      # broadcast as_json.merge({action: 'pick', notice: "轮到玩家#{turn}选择英雄"}).to_json
    end
  end

  def move player_id, hero_id, x, y
    player = players[player_id]
    hero = player.heros[hero_id.to_i]

    # if game.events[round] and
    #   game.events[round][:cannot_move] and
    #   game.events[round][:cannot_move].include?(hero_id)

    #   broadcast_game_status("玩家#{player_id}试图移动#{hero.name}，结果服务器没允许。")
    #   return
    # end

    hero.turn_move = false

    broadcast ({ action: "move", player_id: player_id, hero_id: hero_id, x: x, y: y }.to_json)
  end

  def standby player_id, hero_id
    player = players[player_id]
    hero = player.heros[hero_id.to_i]

    hero.turn_attack = false
    change_turn unless player.has_actions?
    broadcast_game_status
  end

  def attack player_id, hero_id, goal_id
    hero_id = hero_id.to_i
    goal_id = goal_id.to_i

    player = players[player_id]
    hero = player.heros[hero_id]

    opponent = player.opponent
    opponent_hero = opponent.heros[goal_id]

    notice = damage_calculation(player, hero, opponent, opponent_hero)

    hero.turn_attack = false
    change_turn unless player.has_actions?

    broadcast_game_status(notice)
    # broadcast as_json.merge(action: "attack", notice: notice).to_json
  end

  def skill player_id, hero_id

    hero_id = hero_id.to_i
    player_id = player_id.to_i

    player = players[player_id]
    hero = player.heros[hero_id]

    notice = hero.skill(player)

    hero.turn_attack = false
    change_turn unless player.has_actions?

    broadcast_game_status(notice)
  end

  def check_start_pick
    game_start_pick if players[1] and players[1].ready and players[2] and players[2].ready
  end

  private

  def damage_calculation player, hero, opponent, opponent_hero
    notice = ""

    attack_value = hero.attack_value
    # if events[round] and
    #   events[round][:attack_value] and
    #   events[round][:attack_value][hero.id]

    #   attack_value = events[round][:attack_value][hero.id]
    #   notice += "#{hero.name}攻击力提升到了#{attack_value}! "
    # end

    damage = Damage.compute(hero.attack_type, attack_value, opponent_hero.armor_type, opponent_hero.armor_value)
    notice += "玩家#{player.position}的#{hero.name}使用普通攻击，对#{opponent_hero.name}造成了#{damage}点伤害。"

    # if events[round] and
    #   events[round][:whosyourdaddy] and
    #   events[round][:whosyourdaddy].include?(hero.id)

    #   return "玩家#{player.position}使用#{hero.name}攻击#{opponent_hero.name}，结果却被#{opponent_hero.name}无视了。"
    # end

    # if events[round] and
    #   events[round][:cannot_attack] and
    #   events[round][:cannot_attack].include?(hero.id)

    #   return "开会中，攻击被忽略了！！"
    # end

    if opponent.bleed(opponent_hero, damage)
      if opponent_hero.current_health <= 0
        notice += "#{opponent_hero.name}阵亡了！！"
      end
      notice
    end

  end
end