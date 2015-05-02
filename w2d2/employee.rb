class Employee
  attr_reader :salary

  def initialize(name, title, salary, boss = nil)
    @name   = name
    @title  = title
    @salary = salary
    boss.subordinates << self unless boss.nil?
  end

  def bonus(multiplier)
    @salary * multiplier
  end
end

class Manager < Employee
  attr_accessor :subordinates

  def initialize(name, title, salary, boss = nil)
    super
    @subordinates = []
  end

  def bonus(multiplier)
    subordinates_salary * multiplier
  end

  def subordinates_salary
    total_sal = 0
    @subordinates.each do |subordinate|
      total_sal += subordinate.salary
      if subordinate.is_a?(Manager)
        total_sal += subordinate.subordinates_salary
      end
    end
    total_sal
  end
end

def t
  ned    = Manager.new( 'Ned',    'Founder',    1_000_000       )
  darren = Manager.new( 'Darren', 'TA Manager', 78_000,   ned   )
  shawna = Employee.new('Shawna', 'TA',         12_000,   darren)
  david  = Employee.new('David',  'TA',         10_000,   darren)
  p ned.bonus(5)
  p darren.bonus(4)
  p david.bonus(3)
end
