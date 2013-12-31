# coding: utf-8
class Xinchen < OO
  def initialize
    @name = "馨晨"
    @skill_name = "催进度"
    @skill_description = "对方所有工程师伤血15"
    super
  end

  def skill player
    opponent = player.opponent
    heros = opponent.heros.values

    heros.each do |h|
      next unless h.is_a? Programmer
      opponent.bleed(h, 15)
    end

    self.skill_used = true
    "馨晨开始催进度，player#{opponent.position}的工程师们，各损失了15点血。"

  end

  record
end