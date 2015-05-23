var readline = require('readline');
var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});
var i, stacks, startDisc, endDisc, game;

function HanoiGame() {
  this.stacks = [[1,2,3],[],[]];
}

HanoiGame.prototype.isWon = function(){
  stacks = this.stacks;
  for (i = 1; i < stacks.length; i++) {
    if (stacks[i].length === 3) {
       return true;
     }
  }
  return false;
};


HanoiGame.prototype.isValidMove = function(startTowerIndx, endTowerIndx) {
  stacks = this.stacks;
  startDisc = stacks[startTowerIndx][0];
  endDisc = stacks[endTowerIndx][0];

  if (!startDisc) {
    return false;
  } else if (!endDisc || startDisc < endDisc) {
    return true;
  }

  return false;
};

HanoiGame.prototype.move = function (startTowerIndx, endTowerIndx) {
  if (this.isValidMove(startTowerIndx, endTowerIndx)) {
    startDisc = this.stacks[startTowerIndx].shift();
    this.stacks[endTowerIndx].unshift(startDisc);
    return true;
  }

  return false;
};

HanoiGame.prototype.print = function () {
  console.log("Your stacks: \n" + JSON.stringify(this.stacks));
};

HanoiGame.prototype.promptMove = function(callback) {
  this.print();
  reader.question("What's your start move\n", function(startTowerIndx) {
    reader.question("What's end tower\n", function(endTowerIndx) {
      callback(startTowerIndx, endTowerIndx);
    });
  });
};

HanoiGame.prototype.run = function (completionCallback) {
  var that = this;
  this.promptMove(function(startTowerIndx, endTowerIndx){
    if (!that.move(startTowerIndx, endTowerIndx)) {
      console.log("illegal move. try again");
    }
    if (that.isWon()) {
      console.log("You won!");
      completionCallback(that);
    }else {
      that.run(completionCallback);
    }
  });
};


game = new HanoiGame();
game.run(function(that) {
  that.print();
  reader.close();
});
