# coding: utf-8
class Cuiyi < Programmer
  def initialize
    @name = "崔毅"
    @skill_name = "能吃辣"
    @skill_description = "吐火球，对面全体掉血10"
    super
  end

  def skill player
    opponent = player.opponent
    heros = opponent.heros.values
    heros.each do |h|
      opponent.bleed(h, 10)
    end
    self.skill_used = true
    "【崔毅】吐出大火球，对面全体生命减少10。"
  end

  record
end