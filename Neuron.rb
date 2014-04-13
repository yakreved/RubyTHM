require './Synapse'

class Neuron
  attr_accessor :synapse
  def initialize
    @synapse = Synapse.new
  end
end