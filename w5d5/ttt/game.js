var Board = require("./board.js");

function Game(reader) {
  this.players = ["x", "o"];
  this.board = new Board();
  this.gameReader = reader;
}

Game.prototype.getInput = function(callback) {
  this.board.print();
  var that = this;
  this.gameReader.question("What row?\n", function(row){
    that.gameReader.question("What col?\n", function(col){
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
      completionCallback(that);
    } else {
      that.changeTurn();
      that.run(completionCallback);
    }
  });

};

module.exports = Game;
