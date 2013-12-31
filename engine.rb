require './damage'

module Engine

  def pick player_id, hero_id
    player = players[player_id]
    player.heros[hero_id] = Hero.heros[hero_id.to_i].class.new
    broadcast as_json.merge({action: 'pick'}).to_json
  end

  def move player_id, hero_id, x, y
    player = players[player_id]
    hero = player.heros[hero_id]

    hero.turn_move = false

    broadcast as_json.merge({ action: "move" }).to_json
  end

  def attack player_id, hero_id, attack_type, goal_id
    player = players[player_id]
    hero = player.heros[hero_id]

    opponent = player.opponent
    opponent_hero = opponent.players[goal_id]

    damage_calculation(player, hero, opponent, opponent_hero)

    hero.turn_attack = false
    change_turn unless player.has_actions?

    broadcast as_json.to_json
  end

  def skill player_id, hero_id, *args
    player = players[player_id]
    hero = player.heros[hero_id]

    hero.skill(*args)

    hero.turn_attack = false
    change_turn unless player.has_actions?

    broadcast as_json.to_json
  end

  def check_start
    start if players[1].ready and players[2].ready
  end

  private

  def bleed player, hero, damage
    hero.current_health -= damage
    if hero.current_health <= 0
      player.heros.delete hero.id
    end

    if player.heros.empty?
      game_over
    end
  end

  def damage_calculation player, hero, opponent, opponent_hero
    damage = Damage.compute(hero.attack_type, hero.attack_value, opponent_hero.armor_type, opponent_hero.armor_value)
    bleed(opponent, opponent_hero, damage)
  end
end