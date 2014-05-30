require './Column'

class Network
  
  attr_accessor :columns, :neurons_in_column,:connectedPerm,:desiredLocalActivity, :minOverlap, :ingibit_radius

  def initialize
    @ingibit_radius = 10
    @minOverlap = 5
    @neurons_in_column = 2
    @columns = Array.new(20){Column.new}
    @desiredLocalActivity = 3          #Параметр контролирующий число колонок победителей после шага подавления. 
    @t = 0 #Время int в начале каждого цикла инкрементим
  end

  def setColumnsCount(c)
    @columns = Array.new(c){Column.new}
  end
  
  #Присоединяем синапсы к входным данным (Раз и навсегда)
  def connectNetworkToInputs(size) #переделать до наоборот
    bindList = Array.new(0)
    @columns.each do |c|
      c.neurons.each do |n|
        p c if n==nil
        bindList.push(n.synapse) if n!=nil
      end
    end

    bindList.each do |s|
      s.input_source = rand(size)
    end
  end
  
  #Имплементация пространственного группировщика
  def spaceGrouper(input)
    #1.Overlap
    def overlap(input)
      minOverlap = @columns[0].neurons.length/2
      @columns.each do |c|
        c.overlap = 0
        c.connectedSynapses.each do |s|
          c.overlap = c.overlap + input[s.input_source] if input[s.input_source] !=nil
        end
        if c.overlap < minOverlap  then c.overlap =0 #5 = minOverlap
        else
          c.overlap= c.overlap*c.boost
        end
      end
    end
    
    #2.Ингибирование (подавление)
    def ingibit
      activeColumns = []
      @columns.each_with_index do |c,i|
        #minLocalActivity = kthScore(neighbors(c), @desiredLocalActivity) #уй бы с ним пока, а может и ваще
        minLocalActivity =findMinLocalActivity(i)
        if c.overlap>0 and c.overlap>= minLocalActivity
          activeColumns.push(c)
        end
      end
      activeColumns
    end
    
    #Хитровыебаный поиск максимума вместо соседей и kthScore: победитель в секторе будет только один, разреженность регулировать через @ingibit_radius
    @MinLocalActCached =-234
    def findMinLocalActivity(index_of_column)
      if index_of_column == 0 or @columns[index_of_column -1].overlap == @MinLocalActCached
        @MinLocalActCached =@columns.slice(0, @ingibit_radius).max{|a,b| a.overlap <=> b.overlap}.overlap
        return @MinLocalActCached
      else
        if @columns[index_of_column -1].overlap < @MinLocalActCached and ((@columns[index_of_column + @ingibit_radius] !=nil ? @columns[index_of_column + @ingibit_radius].overlap : -234) < @MinLocalActCached)
          return @MinLocalActCached
        end
        if ((@columns[index_of_column + @ingibit_radius] !=nil ? @columns[index_of_column + @ingibit_radius].overlap : -234) >= @MinLocalActCached)
          @MinLocalActCached = @columns[index_of_column + @ingibit_radius].overlap
          return @MinLocalActCached
        end
      end
      @MinLocalActCached
    end
    
    #Для заданного списка колонок возвращает их k-ое максимальное значение их перекрытий со входом. 
    def kthScore(colls,desiredLocalActivity)
      if colls.length> desiredLocalActivity
        colls.sort_by{|p| p.overlap}[desiredLocalActivity].overlap
      else
        colls.sort_by{|p| p.overlap}.last.overlap
      end
    end
    
    #Список колонок находящихся в радиусе подавления inhibitionRadius колонки c. 
    def neighbors(index_of_c)
      @columns.slice(index_of_c-@ingibit_radius,index_of_c+@ingibit_radius)
    end
    
    #Фаза 3: Обучение
    def learn(activeColumns)
      activeColumns.each do |c|
        c.connectedSynapses.each do |s|
          s.permanence+= 0.05#permanenceInc
          s.permanence = [1, s.permanence].min
        end
        
        c.connectedSynapses.each do |s|
          s.permanence -= 0.05#permanenceDec
          s.permanence =  [0, s.permanence].max
        end
        #Здесь возможно будет заимплементено ускорение
      end
    end
    
    overlap(input)
    learn(ingibit)
    
  end
  
  def temporalGrouper(activeColumns)
    def Faza1(activeColumns)
      activeColumns.each do |c|
        predicted = false
        lcChosen = false
        c.neurons.map do |n|
          if n.predictiveState
            s = n.getActiveSegment
            if s.sequenceSegment
              predicted = true
              n.activeState[@t] = 1
              if n.learnStateActive(@t-1)
                lcChosen = true
                n.learnState[@t] = 1
              end
            end
          end
        end
        
        if !predicted
          c.neurons.map do |n|
            n.activeState[@t] = 1
          end
        end
        if lcChosen
          neuron = c.getBestMatchingCell(@t-1)
          neuron.learnState[@t] = 1
          sUpdate = neuron.getSegmentActiveSynapses(@t-1)
          sUpdate.sequenceSegment = true
        end
      end
      
    end
  end

  def PatternMap(data)
    overlap data
    ingibit.map { |e| e.__id__ }
  end
end