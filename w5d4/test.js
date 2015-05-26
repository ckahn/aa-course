
function puts(obj) {
  console.log(obj);
}

Array.prototype.uniq = function() {
  var results = [];
  for (var i = 0; i < this.length; i++) {
    var el = this[i];
    if (results.indexOf(el) === -1 ) {
      results.push(el);
    }
  }
  return results;
};

Array.prototype.two_sum = function() {
  var results = [];
  for(var i = 0; i < this.length - 1; i++) {
    for(var j = i + 1; j < this.length; j++) {
      if (this[i] + this[j] === 0) {
        results.push([i, j]);
      }
    }
  }
  return results;
};


// console.log([1, 2, 3].two_sum());

var myTranspose = function(arr) {
  var result = [];
  for (var i = 0; i < arr.length; i++) {
    result.push([]);
  }

  for (var i = 0; i < arr.length; i++) {
    for (var j = 0; j < arr[i].length; j++) {
      result[j][i] = arr[i][j];
    }
  }
  return result;
};

Array.prototype.myEach = function (func) {
  for(var i = 0; i < this.length; i++) {
    func(this[i]);
  }
  return this;
};

/* [1, 2, 3].myEach(
  function(param) {
    console.log(param);
  }
);*/

Array.prototype.myMap = function (mapperFunction) {
  var mappedArray = [];

  this.myEach(function (el) {
    mappedArray.push(mapperFunction(el));
  });

  return mappedArray;
};

Array.prototype.myInject = function (acc, injecter) {
  var result = acc;
  this.myEach(function(el) {
    result = injecter(result, el)
  })
  return result;
};

// console.log([1, 2, 7].myInject(1,function(acc, el) { return acc + el }));

var bubbleSort = function (arr) {
  var sorted = false;
  while(!sorted) {
    sorted = true;
    for(var i = 0; i < arr.length - 1; i++) {
      if(arr[i] > arr[i + 1]) {
        var old = arr[i + 1];
        arr[i + 1] = arr[i];
        arr[i] = old;
        sorted = false;
      }
    }
  }
  return arr;
};


var substrings = function (string) {
  if (string.length === 1) {
    return [string];
  }

  var substrings = [];
  for (var i = 0; i < string.length; i++) {
    for (var j = i; j < string.length; j++) {
      var slice = string.slice(i,j+1);
      if (substrings.indexOf(slice) === -1) {
        substrings.push(slice);
      }
    }
  }
  return substrings;
};

function range(start, end) {
  if (start > end) {
    return [];
  }
  return [ start ].concat(range(start + 1 , end));
};

function sum_r(arr) {
  if (arr.length === 0) {
    return null;
  }
  if (arr.length === 1) {
    return arr[0];
  } else {
    var num = arr[0];
    return num + sum(arr.slice(1, arr.length));
  }
};

function sum_it(arr) {
  var sum = 0;
  for(var i = 0; i < arr.length; i++) {
    sum += arr[i];
  }
  return sum;
};

function exp(base, power) {
  if (power === 0) {
    return 1;
  }
  return base * exp(base, power - 1);
};

function exp2(base, power) {
  if (power === 0) {
    return 1;
  } else if (power === 1) {
    return base;
  } else if (power % 2 === 0) {
    var sub_result = exp2(base, Math.floor(power/2))
    return  sub_result * sub_result;
  } else {
    var sub_result = exp2(base, Math.floor((power - 1) / 2));
    return base * sub_result * sub_result;
  }
}

function fibo(n) {
  if (n === 1) {
    return [1];
  } else if (n === 2) {
    return [1,1];
  }

  var fib = fibo(n-1);
  return fib.concat(fib.slice(-2).reduce(function(a,b){ return a + b}));
};

function fibo_i(n) {
  if (n === 1) {
    return [1]
  } else if (n === 2) {
    return [1,1];
  }
  var arr = [1, 1];
  for(var i = 0; i < n - 2; i++) {
    arr.push(arr.slice(-2).reduce(function(a,b){ return a + b}));
  }
  return arr;
};

function bSearch(arr, target) {
  var mid_idx = Math.floor(arr.length / 2);
  var mid_el = arr[mid_idx];
  if (arr.length === 0) {
    return -1;
  } else if (target === mid_el) {
    return mid_idx;
  } else if (target > mid_el) {
    var sub_result = bSearch(arr.slice(mid_idx + 1, arr.length), target);
    if (sub_result === -1) {
      return -1;
    } else {
      return mid_idx + sub_result + 1;
    }
  } else {
    return bSearch(arr.slice(0, mid_idx), target);
  }
};



function makeChange(target, coins) {
  if (target === 0) {
    return [];
  }
  if (none_less_than(coins, target)) {
    return null;
  }
  coins.sort().reverse();
  var best_change = null;
  for(var i = 0; i < coins.length; i++) {
    if (coins[i] > target) { continue; }
    var remainder = target - coins[i];
    best_remainder = makeChange(remainder, coins.slice(i, coins.length));
    if (best_remainder === null) { continue; }
    this_change = [coins[i]].concat(best_remainder);
    if (best_change === null || (this_change.length < best_change.length)) {
      best_change = this_change;
    }
  }
  return best_change;
}


function none_less_than(arr, target) {
  for(var i = 0; i < arr.length; i++) {
    if (arr[i] <= target) {
      return false;
    }
  }
  return true;
};

function merge_sort(arr) {
  if (arr.length <= 1) {
    return arr;
  }
  var mid_idx = Math.floor(arr.length/2);
  var left = arr.slice(0, mid_idx);
  var right = arr.slice(mid_idx, arr.length);

  return merge(merge_sort(left), merge_sort(right));
}

function merge(left, right) {
  var merged_arr = [];
  while ( left.length > 0 && right.length > 0) {
    var a = left.shift();
    var b = right.shift();
    if (a <= b) {
      merged_arr.push(a);
      right.unshift(b);
    } else {
      merged_arr.push(b);
      left.unshift(a);
    }
  }
  return merged_arr.concat(left).concat(right);
};

// console.log(merge_sort([1,7,5,3,8,9,0,3,5]));

//
// console.log(makeChange(14, [10, 7, 1]));
// console.log(bSearch([1, 2, 3, 4, 5], 1000));

function subset(arr) {
  debugger
  if (arr.length === 0) {
    return [[]];
  }
  var last_el = arr[arr.length - 1];
  var old_result = subset(arr.slice(0, arr.length - 1));
  new_result = [];
  for(var i = 0; i < old_result.length; i++) {
    temp = old_result[i].slice(0, old_result.length);
    temp.push(last_el);
    new_result.push(temp);
  }
  return old_result.concat(new_result);
};

console.log(subset([1]));

function Cat(name, owner) {
  this.name = name,
  this.owner = owner,
  this.cuteStatement = function() {
    return owner + ' loves ' + name;
  }
};
cat1 = new Cat('asasd')
