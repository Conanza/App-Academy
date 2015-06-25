var readline = require('readline');

var reader = readline.createInterface({
    input: process.stdin,
    output: process.stdout
});

function addNumbers (sum, numsLeft, completionCallback) {
  if (numsLeft > 0) {
    reader.question("What's your number?", function (numString) {
      sum += parseInt(numString);
      console.log(sum);
      numsLeft -= 1;
      addNumbers(sum, numsLeft, completionCallback);
    });
  } else {
    completionCallback(sum);
  }
}

addNumbers(0, 5, function (sum) {
  console.log("The sum is: " + sum);
  reader.close();
});
