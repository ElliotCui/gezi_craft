# coding: utf-8
class Junwei < Programmer
  def initialize
    @name = "俊伟"
    @skill_name = "无视"
    @skill_description = "2回合被打不损血"
    super
  end

  def skill player
    game = player.game

    if game.turn == 1
      game.events[game.round] ||= {}
      game.events[game.round][:whosyourdaddy] ||= Set.new
      game.events[game.round][:whosyourdaddy] << pm.id

      game.events[game.round+1] ||= {}
      game.events[game.round+1][:whosyourdaddy] ||= Set.new
      game.events[game.round+1][:whosyourdaddy] << pm.id
    else
      game.events[game.round+1] ||= {}
      game.events[game.round+1][:whosyourdaddy] ||= Set.new
      game.events[game.round+1][:whosyourdaddy] << pm.id

      game.events[game.round+2] ||= {}
      game.events[game.round+2][:whosyourdaddy] ||= Set.new
      game.events[game.round+2][:whosyourdaddy] << pm.id
    end

    "【俊伟】"
  end

  record
end

class Sunwei < Programmer
  def initialize
    @name = "孙伟"
    @skill_name = "无视"
    @skill_description = "2回合被打不损血"
    super
  end

  def skill player
    game = player.game

    if game.turn == 1
      game.events[game.round] ||= {}
      game.events[game.round][:whosyourdaddy] ||= Set.new
      game.events[game.round][:whosyourdaddy] << pm.id

      game.events[game.round+1] ||= {}
      game.events[game.round+1][:whosyourdaddy] ||= Set.new
      game.events[game.round+1][:whosyourdaddy] << pm.id
    else
      game.events[game.round+1] ||= {}
      game.events[game.round+1][:whosyourdaddy] ||= Set.new
      game.events[game.round+1][:whosyourdaddy] << pm.id

      game.events[game.round+2] ||= {}
      game.events[game.round+2][:whosyourdaddy] ||= Set.new
      game.events[game.round+2][:whosyourdaddy] << pm.id
    end

    "【孙伟】"
  end

  record
end