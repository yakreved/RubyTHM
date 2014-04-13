class Synapse
  attr_accessor :input_source, :permanence
  def initialize
    @input_source = -1                 #индекс элемента входа, с которым связан синапс
    @permanence = rand
  end
end