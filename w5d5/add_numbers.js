var readline = require('readline');
var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

var addNumbers = function (sum, numsLeft, completionCallback) {
  if (numsLeft > 0) {
    reader.question("Enter a number: ", function (answer) {
      var number = parseInt(answer);
      sum += number;
      console.log("Sum so far: " + sum);
      addNumbers(sum, --numsLeft, completionCallback);
    });
  } else if (numsLeft === 0) {
    completionCallback(sum);
    reader.close();
  }
};

addNumbers(0, 3, function (sum) {
  console.log("Total Sum: " + sum);
});
