require './THM'
require './Column'
require 'chunky_png'

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

def imageTest
  image = ChunkyPNG::Image.from_file('C:\max_ep.png')
  tmp = Array.new(0)
  image.height.times do |y|
    image.row(y).each_with_index do |pixel, x|
      tmp.push( ChunkyPNG::Color.to_hex(pixel) > "#666666" ? 1:0)
    end
  end
  p tmp
  n = Network.new
  n.setColumnsCount(tmp.length+2)
  n.connectNetworkToInputs(tmp.length)
  n.spaceGrouper(tmp)
  p n.PatternMap(tmp)
end
#testFunc1
imageTest
