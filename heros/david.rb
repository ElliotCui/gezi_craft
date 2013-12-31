# coding: utf-8
require 'set'

class David < Programmer
  def initialize
    @name = "David"
    @skill_name = "又改需求啦？/恐吓"
    @skill_description = "对方产品经理 3回合不能移动"
    super
  end

  # def skill player
  #   opponent = player.opponent
  #   game = player.game

  #   pms = opponent.heros.select { |id, h| h.is_a? PM }
  #   pm = pms.sample

  #   if game.turn == 1
  #     game.events[game.round] ||= {}
  #     game.events[game.round][:cannot_move] ||= Set.new
  #     game.events[game.round][:cannot_move] << pm.id

  #     game.events[game.round+1] ||= {}
  #     game.events[game.round+1][:cannot_move] ||= Set.new
  #     game.events[game.round+1][:cannot_move] << pm.id

  #     game.events[game.round+2] ||= {}
  #     game.events[game.round+2][:cannot_move] ||= Set.new
  #     game.events[game.round+2][:cannot_move] << pm.id
  #   else
  #     game.events[game.round+1] ||= {}
  #     game.events[game.round+1][:cannot_move] ||= Set.new
  #     game.events[game.round+1][:cannot_move] << pm.id

  #     game.events[game.round+2] ||= {}
  #     game.events[game.round+2][:cannot_move] ||= Set.new
  #     game.events[game.round+2][:cannot_move] << pm.id

  #     game.events[game.round+3] ||= {}
  #     game.events[game.round+3][:cannot_move] ||= Set.new
  #     game.events[game.round+3][:cannot_move] << pm.id
  #   end

  #   "【david】咆哮到：竟然又改需求了!对方改需求的#{pm.name}吓破了胆，将3回合不能移动"
  # end

  record
end