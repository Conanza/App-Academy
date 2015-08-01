require "dynamic_array"

describe DynamicArray do
  before(:each) do
    @d_array = DynamicArray.new(4)
  end

  context "when first initialized" do
    it "starts out empty" do
      expect(@d_array.length).to be(0)
    end

    it "has the correct capacity" do
      expect(@d_array.send(:capacity)).to be(4)
    end

    it "throws an error when you try to index into the array" do
      expect { @d_array[1] }.to raise_error "index out of bounds"
    end

    it "throws an error when you try to set a value at an index" do
      expect { @d_array[1] = 2 }.to raise_error "index out of bounds"
    end
  end

  context "when pushing/popping" do
    before(:each) do
      4.times { |x| @d_array.push(x) }
    end

    it "has the right length" do
      expect(@d_array.length).to be(4)
    end

    it "resizes when max capacity is reached" do
      @d_array.push(5)
      expect(@d_array.length).to be(5)
      expect(@d_array.send(:capacity)).to be(8)
    end

    it "reduces the length after popping" do
      4.times { @d_array.pop }
      expect(@d_array.length).to be(0)
    end

    it "returns nil when it's empty" do
      4.times { @d_array.pop }
      expect(@d_array.pop).to be_nil
    end

    it "returns the right value from popping" do
      expect(@d_array.pop).to be(3)
    end
  end

  context "when shifting/unshifting values" do
    before(:each) do
      4.times { |x| @d_array.unshift(x) }
    end

    it "has the right length" do
      expect(@d_array.length).to be(4)
    end

    it "resizes when max capacity is reached" do
      @d_array.unshift(5)
      expect(@d_array.length).to be(5)
      expect(@d_array.send(:capacity)).to be(8)
    end

    it "reduces the length after shifting" do
      4.times { @d_array.shift }
      expect(@d_array.length).to be(0)
    end

    it "returns nil when it's empty" do
      4.times { @d_array.shift }
      expect(@d_array.shift).to be_nil
    end

    it "returns the right value from shifting" do
      expect(@d_array.shift).to be(3)
    end
  end
end
