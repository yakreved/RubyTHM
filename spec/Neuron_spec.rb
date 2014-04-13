require './Neuron'
require './Synapse'
require 'rspec'

describe Neuron do
    before(:all) do
      @neuron = Neuron.new
    end
    
    it 'should have synapse' do
      @neuron.synapse.should_not be_nil and @neuron.synapse.should be Synapse
    end
end