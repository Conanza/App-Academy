class RPNCalculator
  def initialize
    @stack = []
  end

  def self.evaluate
    calc = RPNCalculator.new

    loop do 
      user_input = calc.get_input
      if user_input.is_a?(Numeric)
        calc.push(user_input)
      elsif user_input.is_a?(Symbol)
        calc.exec_op(user_input)
      else
        calc.get_value
        break
      end

      calc.display_stack
    end
  end

  def get_input
    input = nil

    until input
      puts "Enter input: "
      input = valid_input(gets.chomp)
    end

    input
  end

  def exec_op(operation)
    raise "Too few operands" if @stack.length < 2

    case operation
    when :+ then plus
    when :- then minus
    when :* then times
    when :/ then divide
    else raise "No operation #{operation}"
    end
  end

  def push(number)
    @stack << number
  end

  def display_stack
    p @stack
  end

  def get_value
    case @stack.count
    when 1 then p @stack.pop
    when 0 then raise "There are no operands"
    else raise "There are still operands left"
    end
  end

  private
      
    def divide
      @stack << (1 / @stack.pop.to_f) * @stack.pop
    end

    def minus
      @stack << -@stack.pop + @stack.pop
    end

    def plus
      @stack << @stack.pop + @stack.pop
    end

    def times
      @stack << @stack.pop * @stack.pop
    end

    def valid_input(input)
      user_input = nil

      if input == ""
        user_input = ""
      elsif operations?(input)
        user_input = input.to_sym
      elsif number?(input)
        user_input = Float(input)
      else
        puts "Enter valid input"
      end

      user_input
    end

    def operations?(input)
      ["+", "-", "/", "*"].include?(input)
    end

    def number?(input)
      input.split.all? { |digit| digit =~ /[0-9]/ }
    end
end

if __FILE__ == $PROGRAM_NAME
  if ARGV[0]

  else
    RPNCalculator.evaluate
  end
end

