describe("MinMaxQueue", function() {
  var mmq;

  beforeEach(function() {
    mmq = new MinMaxQueue();
  });

  it("should initialize with two empty stacks", function() {
    expect(mmq.in.length()).toEqual(0);
    expect(mmq.out.length()).toEqual(0);
  });

  describe("after enqueueing values", function() {
    beforeEach(function() {
      mmq.push(1);
      mmq.push(0);
      mmq.push(10);
      mmq.push(9);
      mmq.push(5);
    });

    it("should have the right max", function() {
      expect(mmq.max()).toEqual(10);
    });

    it("should have the right min", function() {
      expect(mmq.min()).toEqual(0);
    });

    it("should shift off the right value", function() {
      var val = mmq.shift();
      expect(mmq.in.length()).toEqual(0);
      expect(mmq.out.length()).toEqual(4);
      expect(val).toEqual(1);
    });
  });

  describe("after shifting more", function() {
    beforeEach(function() {
      mmq.push(1);
      mmq.push(0);
      mmq.push(10);
      mmq.push(9);
      mmq.push(5);
      mmq.shift();
      mmq.shift();
      mmq.shift();
    });

    it("should return the right max", function() {
      expect(mmq.max()).toEqual(9);
    });

    it("should return the right min", function() {
      expect(mmq.min()).toEqual(5);
    });

    it("should flip", function() {
      mmq.push(100);
      mmq.shift();
      mmq.shift();
      expect(mmq.shift()).toEqual(100);
      expect(mmq.in.length()).toEqual(0);
      expect(mmq.out.length()).toEqual(0);
    });
  });
});
