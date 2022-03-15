function findvalue(object, key, defval) {
    if (typeof defval == "undefined") defval = null;
    key = key.split("/");
    for (var i = 0; i < key.length; i++) {
      if (typeof object[key[i]] == "undefined") return defval;
      object = object[key[i]];
    }
    return object;
  }
  
  //var object = {"a":{"b":{"c":"d"}}};
  //var key = 'a/b/c' ;
  var object = { x: { y: { z: "a" } } };
  var key = "x/y/z";
  console.log("The value of " + key + " is " + findvalue(object, key));