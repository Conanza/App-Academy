function Board() {
  this.grid = [
    [null,null,null],
    [null,null,null],
    [null,null,null]
  ];
}

Board.prototype.print = function(){
  var boardString = "\n";
  this.grid.forEach(function(row){
    boardString += JSON.stringify(row) + "\n" ;
  });
  console.log(boardString);
};

Board.prototype.isWon = function(marker){
  var winCondition = [marker, marker, marker];
  var that = this;

  var rowCheck = this.grid.some(that.rowEquals.bind(that, winCondition));

  var gridTransposed = this.transposeGrid();
  var colCheck = gridTransposed.some(function (col) {
    return that.rowEquals(winCondition, col);
  });

  var diag1 = [this.grid[0][0], this.grid[1][1], this.grid[2][2]];
  var diag2 = [this.grid[0][2], this.grid[1][1], this.grid[2][0]];

  var diag1Check = this.rowEquals(winCondition, diag1);
  var diag2Check = this.rowEquals(winCondition, diag2);

  return rowCheck || colCheck || diag1Check || diag2Check;
};

Board.prototype.moveValid = function(moveArray){
  var row = moveArray[0];
  var col = moveArray[1];
  if (this.grid[row][col]) {
    return false;
  }
  return true;
};

Board.prototype.makeMove = function(moveArray, marker){
  var row = moveArray[0];
  var col = moveArray[1];
  if (this.moveValid(moveArray)) {
    this.grid[row][col] = marker;
    return true;
  }
  return false;
};


Board.prototype.rowEquals = function(test, row) {
  var result = true;
  row.forEach(function(el, i) {
    if (el !== test[i]) {
      result = false;
    }
  });

  return result;
};

Board.prototype.transposeGrid = function(){
  var newGrid = [[], [], []];

  this.grid.forEach(function(row,i){
    row.forEach(function(cell, j){
      newGrid[j][i] = cell;
    });
  });
  return newGrid;
};

module.exports = Board;
