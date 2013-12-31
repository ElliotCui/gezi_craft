# coding: utf-8

require 'json'
require 'em-websocket'
require 'pry'

require './heros/hero_base'
require './player'
require './game'

# Hero.heros.values.each {|s| puts s.class.id}
# puts Hero.heros.to_json
# puts David.new.to_json

game = Game.new
binding.pry
EM.run {
  puts "Begin listen 0.0.0.0:8080"
  EM::WebSocket.start(:host => "0.0.0.0", :port => 9090) do |ws|
    ws.onopen { |handshake| puts "Connect" }

    # puts ws.object_id
    unless game.add_player(ws)
      # ws.send("人满了！")
      puts "人满了！"
      ws.close
    end
  end
}