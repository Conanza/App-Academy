var Board = require("./board.js");

var readline = require("readline");
var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

function Game() {
  this.players = ["x", "o"];
  this.board = new Board();
}

Game.prototype.getInput = function(callback) {
  this.board.print();
  reader.question("What row?\n", function(row){
    reader.question("What col?\n", function(col){
      callback([row, col]);
    });
  });
};

Game.prototype.changeTurn = function() {
  this.players.reverse();
};

Game.prototype.run = function(completionCallback) {
  var that = this;
  this.getInput(function(move) {
    if (!that.board.makeMove(move, that.players[0])) {
      console.log("Illegal move. try again");
      that.changeTurn();
    }
    if (that.board.isWon(that.players[0])) {
      console.log(that.players[0] + " won!");
      completionCallback(that)
    }else {
      that.changeTurn();
      that.run(completionCallback);
    }
  });

};


var newgame = new Game();
newgame.run(function(that){
  console.log(that.board.print());
  reader.close();
})











// var hello = new Board();
// hello.print();
