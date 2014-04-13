require './Neuron'
require './Synapse'
require './THM'
require 'rspec'


describe Network do
    
    it 'should pass simple test' do
      data = [1,0,1,0,1,0]
      data2 = [0,1,0,1,0,1]
      data3 = [1,1,0,1,0,1]
      n = Network.new
      n.connectNetworkToInputs(data.length)
      
      n.spaceGrouper(data)
      n.spaceGrouper(data2)
      n.spaceGrouper(data)
      n.spaceGrouper(data2)
      
      n.spaceGrouper(data)
      
      res1 = n.ingibit.map
      
      n.spaceGrouper(data2)
      
      res2 = n.ingibit.map
      
      n.spaceGrouper(data3)
     
      res3 = n.ingibit.map 
      
      res1.should_not eq res2 and res2.should eq res3
    end
end