require_relative 'player'
require_relative 'user'
require_relative 'dealer'
require_relative 'deck'
require_relative 'card'
require_relative 'controller'
require_relative 'bank'

controller = Controller.new
controller.start
