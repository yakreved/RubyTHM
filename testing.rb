require './THM'
require './Column'
require 'chunky_png'

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

def imageTest
  image = ChunkyPNG::Image.from_file('png_samples\cat_1.png')
  image2 = ChunkyPNG::Image.from_file('png_samples\cat_2.png')
  cat_3 = ChunkyPNG::Image.from_file('png_samples\cat_3.png')
  cat_4 = ChunkyPNG::Image.from_file('png_samples\cat_4.png')
  image3 = ChunkyPNG::Image.from_file('png_samples\human_1.png')
  image4 = ChunkyPNG::Image.from_file('png_samples\human_2.png')
  human_3 = ChunkyPNG::Image.from_file('png_samples\human_3.png')
  human_4 = ChunkyPNG::Image.from_file('png_samples\human_4.png')
  flower_1 = ChunkyPNG::Image.from_file('png_samples\flower_1.png')
  flower_2 = ChunkyPNG::Image.from_file('png_samples\flower_2.png')

  p "converting images "
  tmp = pngToArray(image)
  tmp2 = pngToArray(image2)
  tmp3 = pngToArray(image3)
  cat3 = pngToArray(cat_3)
  cat4 = pngToArray(cat_4)
  tmp4 = pngToArray(image4)
  human3 = pngToArray(human_3)
  human4 = pngToArray(human_4)
  flower1 = pngToArray(flower_1)
  flower2 = pngToArray(flower_2)
  p "end converting images"

  n = Network.new
  n.setColumnsCount(1000)
  n.ingibit_radius = 100
  n.connectNetworkToInputs(tmp.length)

  p "learning"
  for i in 0..10
    if i%10==0
      p i
    end
    n.spaceGrouper(tmp)
    n.spaceGrouper(tmp2)
    n.spaceGrouper(cat3)
    n.spaceGrouper(cat4)
    n.spaceGrouper(tmp3)
    n.spaceGrouper(tmp4)
    n.spaceGrouper(human3)
    n.spaceGrouper(human4)
  end
  p "end learn"

  h = Hash.new
  h["cat_1 & cat_2 "] = (n.PatternMap(tmp) & n.PatternMap(tmp2)).length
  h["cat_1 & cat_3 "] = (n.PatternMap(tmp) & n.PatternMap(cat3)).length
  h["cat_2 & cat_3 "] = (n.PatternMap(tmp2) & n.PatternMap(cat3)).length
  h["cat_4 & cat_3 "] = (n.PatternMap(cat4) & n.PatternMap(cat3)).length
  h["cat_1 & human_1 "] = (n.PatternMap(tmp) & n.PatternMap(tmp3)).length
  h["cat_2 & human_1 "] = (n.PatternMap(tmp2) & n.PatternMap(tmp3)).length
  h["human_1 & human_2 "] = (n.PatternMap(tmp4) & n.PatternMap(tmp3)).length
  h["human_2 & human_3 "] = (n.PatternMap(tmp4) & n.PatternMap(human3)).length
  h["cat_2 & human_2 "] = (n.PatternMap(tmp2) & n.PatternMap(tmp4)).length
  h["cat_4 & human_4 "] = (n.PatternMap(cat4) & n.PatternMap(human4)).length 
  h["cat_4 & flower1 "] = (n.PatternMap(cat4) & n.PatternMap(flower1)).length 
  h["cat_3 & flower1 "] = (n.PatternMap(cat4) & n.PatternMap(flower1)).length 
  h["human_2 & flower1 "] = (n.PatternMap(tmp4) & n.PatternMap(flower1)).length
  h["flower2 & flower1 "] = (n.PatternMap(flower2) & n.PatternMap(flower1)).length    
  h=h.sort_by{|k,v| -v} 
  h.each{|k,v| p k+v.to_s}
end

def pngToArray(image)
  tmp = Array.new(0)
  image.height.times do |y|
    image.row(y).each_with_index do |pixel, x|
      pi = "%024b" % ChunkyPNG::Color.to_hex(pixel)[1,6].to_i(16)
      pi.each_char do |char|
        tmp.push(char.to_i)  if char.to_i!=nil
      end
    end
  end
  tmp
end
#testFunc1
p "Image test begin"
imageTest
p "end image test"
