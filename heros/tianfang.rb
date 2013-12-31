# coding: utf-8
class Wangran < OO
  def initialize
    @name = "王然"
    @skill_name = "开会啦"
    @skill_description = "对面全体攻击无效一回合"
    super
  end

  def skill player
    game = player.game
    opponent = player.opponent

    opponent.heros.values.each do |h|
      if game.turn == 1
        game.events[game.round] ||= {}
        game.events[game.round][:cannot_attack] ||= Set.new
        game.events[game.round][:cannot_attack] << h.id
      else
        game.events[game.round+1] ||= {}
        game.events[game.round+1][:cannot_attack] ||= Set.new
        game.events[game.round+1][:cannot_attack] << h.id
      end
    end

    "【王然】开会"
  end


  record
end

class Tianfang < Programmer
  def initialize
    @name = "天放"
    @skill_name = "开会啦"
    @skill_description = "all不能攻击"
    super
  end

  def skill player
    game = player.game
    opponent = player.opponent

    opponent.heros.values.each do |h|
      if game.turn == 1
        game.events[game.round] ||= {}
        game.events[game.round][:cannot_attack] ||= Set.new
        game.events[game.round][:cannot_attack] << h.id
      else
        game.events[game.round+1] ||= {}
        game.events[game.round+1][:cannot_attack] ||= Set.new
        game.events[game.round+1][:cannot_attack] << h.id
      end
    end

    "【王然】开会"
  end

  record
end