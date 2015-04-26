def super_print(string, options = {})
  defaults = { times: 1, upcase: false, reverse: false }
  user_options = defaults.merge(options)

  string.upcase! if user_options[:upcase]
  string.reverse! if user_options[:reverse]
  user_options[:times].times { print string }
end

if $PROGRAM_NAME = __FILE__
  super_print("Hello")                                    #=> "Hello"
  puts
  super_print("Hello", :times => 3)                       #=> "Hello" 3x
  puts
  super_print("Hello", :upcase => true)                   #=> "HELLO"
  puts
  super_print("Hello", :upcase => true, :reverse => true) #=> "OLLEH"
end
