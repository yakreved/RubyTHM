require './Neuron'
require './Synapse'
require './THM'
require 'rspec'


describe Network do
    
    it 'should pass simple test' do
        data =  [1,0,1,0,1,0,1,0,1,0,1]
        data2 = [0,1,0,1,0,1,0,1,0,1,0]
        data3 = [1,1,0,1,0,1,0,1,0,1,0]
        data4 = [1,0,1,0,1,1,1,0,1,0,1]
      n = Network.new
      n.connectNetworkToInputs(data.length)
      
      n.spaceGrouper(data)
      n.spaceGrouper(data2)
      n.spaceGrouper(data3)
      n.spaceGrouper(data4)
      
      (n.PatternMap(data) - n.PatternMap(data4)).length.should < 2
      (n.PatternMap(data2) - n.PatternMap(data3)).length.should < 2
      
    end
end