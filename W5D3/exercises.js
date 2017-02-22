
// > madLib('make', 'best', 'guac');
// "We shall MAKE the BEST GUAC."

function madLib(v, a, n) {
  return `We shall ${v.toUpperCase()} the ${a.toUpperCase()} ${n.toUpperCase()}.`
}

// > isSubstring("time to program", "time")
// true
//
// false

function isSubstring(search, sub) {
  return search.includes(sub);
}

isSubstring("Jump for joy", "joys");
isSubstring("time to program", "time");

function specialNums(num){
  var divisible = false;
  if ((num % 3 === 0 || num % 5 === 0) && (num % 15 != 0)) {
    return true;
  }
  return divisible;
}

function fizzBuzz(arr){
  return arr.filter(specialNums);
}
