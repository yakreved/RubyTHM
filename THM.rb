require './Column'

class Network
  
  attr_accessor :columns, :neurons_in_column,:connectedPerm,:desiredLocalActivity, :minOverlap

  def initialize
    @minOverlap = 5
    @neurons_in_column = 5
    @columns = Array.new(20){Column.new}
    @desiredLocalActivity = 3          #Параметр контролирующий число колонок победителей после шага подавления. 

  end
  
  #Присоединяем синапсы к входным данным (Раз и навсегда)
  def connectNetworkToInputs(size)
    bindList = Array.new(0)
    @columns.each do |c|
      c.neurons.each do |n|
        p c if n==nil
        bindList.push(n.synapse) if n!=nil
      end
    end

    if(size>bindList.length)
      throw "u have not enough neurons for input data"
    end
    for i in 0 .. size -1 do
      curr = bindList.sample
      curr.input_source = i
      bindList.delete(curr)
    end
  end
  
  #Имплементация пространственного группировщика
  def spaceGrouper(input)
    #1.Overlap
    def overlap(input)
      @columns.each do |c|
        c.overlap = 0
        c.connectedSynapses.each do |s|
          c.overlap = c.overlap + input[s.input_source]
        end
        if c.overlap < 1  then c.overlap =0 #5 = minOverlap
        else
          c.overlap= c.overlap*c.boost
        end
      end
    end
    
    #2.Ингибирование (подавление)
    def ingibit
      activeColumns = []
      @columns.each do |c|
        minLocalActivity = kthScore(neighbors(c), @desiredLocalActivity)
        if c.overlap>0 and c.overlap>= minLocalActivity
          activeColumns.push(c)
        end
      end
      activeColumns
    end
    
    #Для заданного списка колонок возвращает их k-ое максимальное значение их перекрытий со входом. 
    def kthScore(colls,desiredLocalActivity)
      if colls.length> desiredLocalActivity
        colls.sort_by{|p| p.overlap}[desiredLocalActivity].overlap
      else
        colls.last.overlap
      end
    end
    
    #Список колонок находящихся в радиусе подавления inhibitionRadius колонки c. 
    def neighbors(c)
      @columns.slice(@columns.index(c)-10,@columns.index(c)+10)
    end
    
    #Фаза 3: Обучение
    def learn(activeColumns)
      activeColumns.each do |c|
        c.connectedSynapses.each do |s|
          s.permanence+= 0.1#permanenceInc
          s.permanence = [1, s.permanence].min
        end
        
        c.connectedSynapses.each do |s|
          s.permanence -= 0.1#permanenceDec
          s.permanence =  [0, s.permanence].max
        end
        #Здесь возможно будет заимплементено ускорение
      end
    end
    
    overlap(input)
    learn(ingibit)
    
  end

  def PatternMap(data)
    overlap data
    ingibit.map { |e| e.__id__ }
  end
end