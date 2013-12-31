# coding: utf-8
class Hero
  ATTACK_TYPES_COMMON   = 0
  ATTACK_TYPES_PIERCING = 1
  ATTACK_TYPES_MAGIC    = 2

  ARMOR_UNARMORED       = 0
  ARMOR_MEDIUM          = 1
  ARMOR_HEAVY           = 2

  COMMON_ATTACK         = 0
  SPECIAL_SKILL         = 1

  attr_reader :name, :attack_type, :attack_value, :attack_length, :armor_type, :armor_value, :speed, :health, :skill_name, :skill_description
  attr_accessor :current_health, :skill_used, :turn_move, :turn_attack

  def initialize
    self.current_health = self.health
    self.skill_used = false
  end

  class << self

    attr_accessor :id, :type

    def record
      @@heros ||= {}
      @@hero_id ||= 1

      self.id = @@hero_id

      @@heros[@@hero_id] = self.new
      @@hero_id += 1
    end

    def heros
      @@heros
    end
  end

  def id
    self.class.id
  end

  def to_json *args
    {
      name: name,
      type: self.class.type || "无",
      current_health: current_health,
      attack_type: attack_type,
      attack_value: attack_value,
      armor_type: armor_type,
      armor_value: armor_value,
      speed: speed,
      health: health,
      skill_name: skill_name,
      skill_description: skill_description,
      skill_used: skill_used,
      turn_move: turn_move,
      turn_attack: turn_attack,
    }.to_json
  end
end

class Programmer < Hero
  def self.type
    "搬砖的"
  end

  def initialize
    @attack_type = Hero::ATTACK_TYPES_COMMON
    @armor_type = Hero::ARMOR_HEAVY
    @attack_value = 20
    @armor_value = 6
    @health = 85
    @speed = 6
    @attack_length = 1
    super
  end
end

class Designer < Hero
  def self.type
    "切图的"
  end

  def initialize
    @attack_type = Hero::ATTACK_TYPES_MAGIC
    @armor_type = Hero::ARMOR_UNARMORED
    @attack_value = 32
    @attack_length = 4
    @armor_value = 4
    @speed = 4
    @health = 50
    super
  end
end

class PM < Hero
  def self.type
    "该需求的"
  end

  def initialize
    @attack_type = Hero::ATTACK_TYPES_COMMON
    @armor_type = Hero::ARMOR_UNARMORED
    @attack_value = 15
    @attack_length = 1
    @armor_value = 8
    @speed = 5
    @health = 115
    super
  end
end

class OO < Hero
  def self.type
    "没想好名字的"
  end

  def initialize
    @attack_type = Hero::ATTACK_TYPES_PIERCING
    @armor_type = Hero::ARMOR_MEDIUM
    @attack_value = 25
    @attack_length = 3
    @armor_value = 7
    @speed = 8
    @health = 65
    super
  end
end

module Intern
  def attack_value
    super - 3
  end

  def armor_value
    super + 2
  end
end

Dir['./heros/*'].each do |path|
  path = path.split('/')[-1]
  require File.expand_path("../#{path}", __FILE__)
end
