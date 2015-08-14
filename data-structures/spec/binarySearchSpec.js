describe("binarySearch", function() {
  var arr;
  beforeEach(function() {
    arr = [-1, 0, 3, 5, 8, 10, 23, 24];
  });

  it("should return null for an empty array", function() {
    expect(binarySearch([], 10)).toEqual(null);
  });

  it("returns the first pivot", function() {
    expect(binarySearch(arr, 8)).toEqual(4);
  });

  it("should find something at the leftmost", function() {
    expect(binarySearch(arr, -1)).toEqual(0);
  });

  it("should find something at the rightmost", function() {
    expect(binarySearch(arr, 24)).toEqual(7);
  });

  it("should find something in between on the right", function() {
    expect(binarySearch(arr, 10)).toEqual(5);
  });

  it("should find something in between on the left", function() {
    expect(binarySearch(arr, 5)).toEqual(3);
  });

  it("should return null for a value not in the array", function() {
    expect(binarySearch(arr, 120)).toEqual(null);
  });
});
