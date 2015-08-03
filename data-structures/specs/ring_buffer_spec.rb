require "01b_ring_buffer"

describe RingBuffer do
  before(:each) do
    @ringbuffer = RingBuffer.new(4)
  end

  context "when initialized" do
    it "starts out empty" do
      expect(@ringbuffer.length).to be(0)
    end

    it "raises an error when indexing into the ring buffer" do
      expect { @ringbuffer[1] }.to raise_error "index out of bounds"
    end

    it "has the right capacity" do
      expect(@ringbuffer.send(:capacity)).to be(4)
    end

    it "begins at index 0" do
      expect(@ringbuffer.send(:start_idx)).to be(0)
    end
  end

  context "when pushing and popping" do
    before(:each) do
      4.times { |i| @ringbuffer.push(i) }
    end

    it "has the right length" do
      expect(@ringbuffer.length).to be(4)
    end

    it "still has start idx of 0" do
      expect(@ringbuffer.send(:start_idx)).to be(0)
    end

    it "returns the right value" do
      expect(@ringbuffer.pop).to be(3)
    end
  end

  context "when unshifting and shifting" do
    before(:each) do
      3.times { |i| @ringbuffer.push(i) }
      @ringbuffer.unshift(5)
    end

    it "has the right length" do
      expect(@ringbuffer.length).to be(4)
    end

    it "changes the start_idx" do
      expect(@ringbuffer.send(:start_idx)).to be(3)
    end

    it "retrieves the right value" do
      expect(@ringbuffer[0]).to be(5)
    end

    it "shifts off the right value" do
      expect(@ringbuffer.shift).to be(5)
    end

    it "changes the start_idx correctly after shifting" do
      @ringbuffer.shift
      expect(@ringbuffer.send(:start_idx)).to be(0)
    end
  end

  context "after resizing" do
    before(:each) do
      4.times { |i| @ringbuffer.push(i) }
      @ringbuffer.unshift(5)
    end

    it "increases capacity" do
      expect(@ringbuffer.send(:capacity)).to be(8)
    end

    it "has the right length" do
      expect(@ringbuffer.length).to be(5)
    end

    it "has the right start_idx" do
      expect(@ringbuffer.send(:start_idx)).to be(7)
    end

    it "pops off the right value" do
      expect(@ringbuffer.pop).to be(3)
    end

    it "shifts off the right value" do
      expect(@ringbuffer.shift).to be(5)
    end

    it "changes start_idx correctly after a shift" do
      @ringbuffer.shift
      expect(@ringbuffer.send(:start_idx)).to be(0)
    end
  end
end
