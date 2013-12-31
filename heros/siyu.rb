# # coding: utf-8
class Siyu < OO
  def initialize
    @name = "思雨"
    @skill_name = "800大使"
    @skill_description = "我有800大使，谁能挡我？2回合攻击+15"
    super
  end

  def skill player
    game = player.game

    if game.turn == 1
      game.events[game.round+1] ||= {}
      game.events[game.round+1][:attack_value] ||= {}
      game.events[game.round+1][:attack_value][id] = attack_value + 15
      game.events[game.round+2] ||= {}
      game.events[game.round+2][:attack_value] ||= {}
      game.events[game.round+2][:attack_value][id] = attack_value + 15
    else
      game.events[game.round+1] ||= {}
      game.events[game.round+1][:attack_value] ||= {}
      game.events[game.round+1][:attack_value][id] = attack_value + 15
      game.events[game.round+2] ||= {}
      game.events[game.round+2][:attack_value] ||= {}
      game.events[game.round+2][:attack_value][id] = attack_value + 15
    end
  end

  record
end