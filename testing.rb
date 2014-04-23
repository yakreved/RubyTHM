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
  image3 = ChunkyPNG::Image.from_file('png_samples\human_1.png')
  image4 = ChunkyPNG::Image.from_file('png_samples\human_2.png')

  p "converting images "
  tmp = pngToArray(image)
  tmp2 = pngToArray(image2)
  tmp3 = pngToArray(image3)
  tmp4 = pngToArray(image4)
  p "end converting images"

  n = Network.new
  n.setColumnsCount(1000)
  n.ingibit_radius = 10
  n.connectNetworkToInputs(tmp.length)

  p "learning"
  n.spaceGrouper(tmp)
  n.spaceGrouper(tmp2)
  n.spaceGrouper(tmp3)
  n.spaceGrouper(tmp4)
  n.spaceGrouper(tmp)
  n.spaceGrouper(tmp2)
  n.spaceGrouper(tmp3)
  n.spaceGrouper(tmp4)
  n.spaceGrouper(tmp)
  n.spaceGrouper(tmp2)
  n.spaceGrouper(tmp3)
  n.spaceGrouper(tmp4)
  n.spaceGrouper(tmp)
  n.spaceGrouper(tmp2)
  n.spaceGrouper(tmp3)
  n.spaceGrouper(tmp4)
  p "end learn"

  p "cat_1 & cat_2 "
  puts (n.PatternMap(tmp) & n.PatternMap(tmp2)).length

  p "cat_1 & human_1 "
  puts (n.PatternMap(tmp) & n.PatternMap(tmp3)).length

  p "cat_2 & human_1 "
  puts (n.PatternMap(tmp2) & n.PatternMap(tmp3)).length

  p "human_1 & human_2 "
  puts (n.PatternMap(tmp4) & n.PatternMap(tmp3)).length

  p "cat_2 & human_2 "
  p (n.PatternMap(tmp2) & n.PatternMap(tmp4)).length
end

def pngToArray(image)
  tmp = Array.new(0)
  image.height.times do |y|
    image.row(y).each_with_index do |pixel, x|
      pi = ChunkyPNG::Color.to_hex(pixel)[1,6].to_i(16).to_s(2)
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
