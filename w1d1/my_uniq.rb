class Array
  def my_uniq
    uniq_els = []
    each { |el| uniq_els << el unless uniq_els.include?(el) }
    uniq_els
  end
end

if $PROGRAM_NAME == __FILE__
  p [1, 2, 1, 3, 3].uniq == [1,2,3]
end
