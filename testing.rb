require './THM'
require './Column'

#Testing
def testFunc1
  data =  [1,0,1,0,1,0,1,0,1,0,1,0,1]
  data2 = [0,1,0,1,0,1,0,1,0,1,0,1,0]
  data3 = [1,1,0,1,0,1,0,1,0,1,0,1,0]
  data4 = [1,0,1,0,1,1,1,0,1,0,1,0,1]
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
  
  p n.PatternMap(data) - n.PatternMap(data4)
  
  p "////"
  
  p n.PatternMap(data3) - n.PatternMap(data2)
  
  p "////"
  p n.PatternMap(data3) - n.PatternMap(data)
  
end

def sinusTesting
  
end
testFunc1

