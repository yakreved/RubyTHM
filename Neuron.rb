require './Synapse'

class Neuron
  attr_accessor :synapse, :dendrits, :predictiveState, :activeState, :learnState
  def initialize
    @synapse = Synapse.new
    @dendrits = Array.new(0)
    @predictiveState = Hash.new
    @activeState = Hash.new
    @learnState = Hash.new
    @activationThreshold = 2
  end
  
  def segmentActive(t)
    if @activeState[t]== nil
      return false
    end
    @activationThreshold< @activeState[t]
  end
  
end