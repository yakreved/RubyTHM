require './THM'
require './Column'

#Testing
def testFunc1
  data =  [1,0,1,0,1,0,1,0,1,0,1]
  data2 = [0,1,0,1,0,1,0,1,0,1,0]
  data3 = [1,1,0,1,0,1,0,1,0,1,0]
  data4 = [1,0,1,0,1,1,1,0,1,0,1]
  n = Network.new
  n.connectNetworkToInputs(data.length)
  
  n.spaceGrouper(data)
  n.spaceGrouper(data2)
  n.spaceGrouper(data)
  n.spaceGrouper(data2)
  n.spaceGrouper(data)
  n.spaceGrouper(data2)
  n.spaceGrouper(data)
  n.spaceGrouper(data2)
  
  n.spaceGrouper(data)
  
  n.ingibit.map { |p| puts p.neurons[0].synapse.input_source }
  
  p "////"
  
  n.spaceGrouper(data4)
  
  n.ingibit.map { |p| puts p.neurons[0].synapse.input_source }
  
  p "////"
  n.spaceGrouper(data2)
  
  n.ingibit.map { |p| puts p.neurons[0].synapse.input_source }
  
  p "////"
  
  n.spaceGrouper(data3)
  
  n.ingibit.map { |p| puts p.neurons[0].synapse.input_source }
  p "////"

  p n.PatternMap(data)
end

def sinusTesting
  
end
testFunc1

