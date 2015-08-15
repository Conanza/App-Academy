require "heap_sort"
require "merge_sort"
require "quick_sort"

describe "comparison sorts" do
  before(:each) do
    @arr = [1, 2, 10, -4, 0, -3, 100, 5]
  end

  describe "Array#heap_sort" do
    it "should sort an empty array" do
      expect([].heap_sort).to eq([])
    end

    it "should sort an array" do
      expect(@arr.heap_sort).to eq(@arr.sort)
    end
  end

  describe "#merge_sort" do
    it "should sort an empty array" do
      expect(merge_sort([])).to eq([])
    end

    it "should sort an array" do
      expect(merge_sort(@arr)).to eq(@arr.sort)
    end
  end

  describe "quick sorts" do
    describe "#bad_qsort" do
      it "should sort an array" do
        expect(bad_qsort(@arr)).to eq(@arr.sort)
      end
    end

    describe "#qsort using partitioning" do
      it "should sort an array" do
        expect(qsort(@arr)).to eq(@arr.sort)
      end
    end

    describe "#qsort!" do
      it "should sort an array" do
        expect(qsort!(@arr)).to eq(@arr.sort)
      end
    end
  end
end
