require './Neuron'

class Column
  
    attr_accessor :overlap,:neurons, :boost, :predicted
    
    def initialize
      @neurons = Array.new(5){Neuron.new}
      @overlap = 0
      @boost = 1
      @connectedPerm = 0.6  #пороговое значение – минимальное значение перманентности при котором синапс считается «действующим» («подключенным»)
      @predicted = false
    end
    
    def connectedSynapses
      res = []
      @neurons.each do |n|
        if n.synapse.permanence>= @connectedPerm 
          res.push(n.synapse)
        end
      end
      res
    end
    
    def disconnectedSynapses
      res = []
      @neurons.each do |n|
        if n.synapse.permanence< connectedPerm
          res.push(n.synapse)
        end
      end
      res
    end
    
end