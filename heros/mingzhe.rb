# coding: utf-8
class MingZhe < PM
  def initialize
    @name = "明喆"
    @skill_name = "改需求"
    @skill_description = "David不在场时，可以发动技能改需求，对方所有非pm生命-15，自己生命-10*x"
    super
  end

  def skill player
    opponent = player.opponent
    heros = opponent.heros.values

    i = 0
    heros.each do |h|
      next if h.is_a? PM
      i += 1
      opponent.bleed(h, 15)
    end

    player.bleed(self, i * 10)
    self.skill_used = true
    "【明喆】改了需求，对方所有非pm生命值-15，明喆遭到了大家的反击，失去生命#{i*10}。"
  end

  record
end