var sum = function() {
  var product = 0;
  for (var i = 0; i < arguments.length; i++) {
    product += arguments[i];
  }
  return product;
}

Function.prototype.myBind = function() {
  var that = this;
  var bindArguments = Array.prototype.slice.call(arguments);
  return function() {
    var bindArguments2 = Array.prototype.slice.call(arguments);
    that.apply(bindArguments[0],bindArguments.slice(1).concat(bindArguments2));
  };
}

var myObj = {
  name: "myName",
  myFn: function(arg, arg2) {
    console.log(this.name + arg + arg2);
  }
}

var myBoundFunction = myObj.myFn.myBind(myObj,"blah");
myBoundFunction("hoy!");

var curriedSum = function(numArgs){
  var numbers = [];
  var _curriedSum = function(num){
    numbers.push(num);
    if (numbers.length === numArgs){
      return numbers.reduce(function(a, b) {
             return a + b;
      });
    } else {
      return _curriedSum;
    }
  };
  return _curriedSum;
};

var s = curriedSum(4);
console.log(s(5)(30)(20)(1));

Function.prototype.curry = function(numArgs) {
  var args = [];
  var that = this;
  var _curry = function(num){
    args.push(num);
    if (args.length === numArgs){
      return that.apply(that, args);
    } else {
      return _curry;
    }
  };
  return _curry;
};

var sum = function() {
  var args = Array.prototype.slice.call(arguments);
  return args.reduce(function(a, b) {
    return a + b;
  }, 0);
};

console.log(sum.curry(3)(1)(2)(3));
