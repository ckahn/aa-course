var readline = require('readline');
var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

function HanoiGame() {
  this.stacks = [[3, 2, 1], [], []];
}

HanoiGame.prototype.isWon = function() {
  return this.stacks[2].length === 3;
};

HanoiGame.prototype.isValidMove = function (start, dest) {
  if (this.stacks[start].length === 0) {
    return false;
  }
  // if (this.stacks[dest].length === 3) {
  //   return false;
  // }
  if (this.stacks[dest].length === 0) {
    return true;
  }
  if (last(this.stacks[start]) < last(this.stacks[dest])) {
    return true;
  }
  return false;
};

var last = function (array) {
  if (array.length === 0) {
    return null;
  } else {
    return array[array.length - 1];
  }
};

HanoiGame.prototype.move = function(idx1, idx2) {
  if (this.isValidMove(idx1, idx2)) {
    var disc = this.stacks[idx1].pop();
    this.stacks[idx2].push(disc);
    return true;
  }
  return false;
};

HanoiGame.prototype.print = function() {
  console.log(this.stacks);
};

HanoiGame.prototype.promptMove = function(callback) {
  var that = this;
  this.print();
  reader.question("Where do you want to move from/to? ", function(answer) {
    callback(parseInt(answer[0]), parseInt(answer[1]));
  });
};

HanoiGame.prototype.run = function(completionCallback) {
  var that = this;
  that.promptMove(function(idx1, idx2) {
    var hasMoved = that.move(idx1, idx2);
    if (hasMoved) {
      if (that.isWon()) {
        that.print();
        completionCallback();
      } else {
        that.run(completionCallback);
      }
    } else {
      console.log("Invalid move.");
      that.run(completionCallback);
    }
  });
};

new HanoiGame().run(function() {
  console.log("Congrats, you win!");
  reader.close();
});
