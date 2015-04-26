# class Rpn
#   OPERATIONS = %w(+ - / *)

#   def initialize
#     @stack = []
#   end

#   def push(input)
#     @stack << input
#     evaluate
#   end

#   def exec(input)
#     input = OPERATIONS.include?(input) ? input.to_sym : Float(input)
#     push(input)
#   end

#   def evaluate
#     return if @stack.last.is_a?(Numeric)

#     operator = @stack.pop
#     el1, el2 = @stack.pop, @stack.pop
#     @stack << el2.send(operator, el1)
#   end

#   def cmd_input
#     puts "Enter input"
#     input = gets.chomp
#     exec(input)

#     cmd_input
#   end

#   def to_s
#     @stack.last.to_s
#   end
# end

# if $PROGRAM_NAME == __FILE__
#   calculator = Rpn.new
#   filename = ARGV[0]
#   if filename
#     File.read(filename).split.each { |arg| calculator.exec arg }
#     puts calculator
#   else
#     calculator.cmd_input
#   end
# end

class RPNCalculator
  def initialize
    @stack = []
  end

  def push(number)
    @stack << number
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
    
    puts @stack.last
  end

  def self.evaluate
    calc = RPNCalculator.new

    loop do 
      puts "Enter input: "
      user_input = calc.input(gets.chomp)
      if user_input.is_a?(Numeric)
        calc.push(user_input)
      elsif user_input.is_a?(Symbol)
        calc.exec_op(user_input)
      else
        calc.value
        break
      end
    end
  end

  def value
    case @stack.count
    when 1 then @stack.pop
    when 0 then raise "There are no operands"
    else "There are still operands left"
    end
  end

  def input(item)
    %w(+ - * / =).include?(item) ? item.to_sym : Float(item)
  end

  private

    def plus
      @stack << @stack.pop + @stack.pop
    end

    def minus
      @stack << -@stack.pop + @stack.pop
    end

    def times
      @stack << @stack.pop * @stack.pop
    end

    def divide
      @stack << (1 / @stack.pop.to_f) * @stack.pop
    end
end

# if __FILE__ == $PROGRAM_NAME
#   if ARGV[0]
#     puts RPNCalculator.evaluate(ARGV[0])
#   else
#     puts RPNCalculator.evaluate($stdin)
#   end
# end

