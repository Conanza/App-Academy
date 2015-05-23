var TicTacToe = require("./ttt");
var readline = require("readline");
var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

var newGame = new TicTacToe.Game(reader);
newGame.run(function(game){
  console.log("Final board:");
  game.board.print();
  reader.close();
});
