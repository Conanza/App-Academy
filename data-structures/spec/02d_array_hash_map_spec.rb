require "02d_array_hash_map"

describe ArrayHashMap do
  before(:each) do
    @ahm = ArrayHashMap.new
  end

  context "when initialized" do
    it "has a default size" do
      expect(@ahm.send(:buckets).length).to be(@ahm.send(:size))
    end
  end

  context "when setting values" do
    it "can use #set" do
      @ahm.set(4, [1, 2, 3])
      expect(@ahm.send(:count)).to be(1)
    end

    it "can use #[]=" do
      @ahm[4] = [1, 2, 3]
      expect(@ahm.send(:count)).to be(1)
    end
  end

  context "after setting some values" do
    before(:each) do
     @ahm[3] = "hi"
     @ahm["yup"] = "nope"
     @ahm.set(4, "bye")
     @ahm["toes"] = "fingers"
    end

    it "has the right count" do
      expect(@ahm.send(:count)).to be(4)
    end

    it "retrieves the right value with #[]" do
      expect(@ahm["yup"]).to eq("nope")
    end

    it "retrieves the right value with #get" do
      expect(@ahm[4]).to eq("bye")
    end

    it "returns nil for keys not in the hash" do
      expect(@ahm["conan"]).to be_nil
    end

    it "#include? returns the right value" do
      expect(@ahm.include?("toes")).to be_truthy
    end

    it "#has_key? returns the right value" do
      expect(@ahm.has_key?("conana")).to be_falsey
    end
  end

  context "when deleting" do
    before(:each) do
      @ahm[3] = "hi"
      @ahm["yup"] = "nope"
      @ahm.set(4, "bye")
      @ahm["toes"] = "fingers"
      @ahm.delete("toes")
    end

    it "returns nil for an invalid key" do
      expect(@ahm.delete("whatever")).to be_nil
    end

    it "returns true when deleting a present key" do
      expect(@ahm.delete("yup")).to be_truthy
    end

    it "reduces the count" do
      expect(@ahm.send(:count)).to be(3)
    end

    it "deletes the key" do
      expect(@ahm.include?("toes")).to be_falsey
    end
  end

  context "after resizing, everything still works" do
    before(:each) do
      @ahm["conan"] = "tzou"
      @ahm["colleen"] = "sister"
      @ahm["annie"] = "girlfriend"
      @ahm[3] = "this is three"
      @ahm[["conan"]] = "conan in an array"
      @ahm[6] = ["the", "sixth", "element"]
    end

    it "has the right count" do
      expect(@ahm.send(:count)).to be(6)
    end

    it "has the right size" do
      expect(@ahm.send(:buckets).length).to be(10)
    end

    it "retrieves the right value" do
      expect(@ahm[6]).to eq(["the", "sixth", "element"])
    end
  end
end
