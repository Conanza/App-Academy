require "heap_sort"

describe "Array#heap_sort" do
  before(:each) do
    @arr = [1, 2, 10, -4, 0, -3, 100, 5]
  end

  it "should sort an array" do
    expect(@arr.heap_sort).to eq(@arr.sort)
  end
end
