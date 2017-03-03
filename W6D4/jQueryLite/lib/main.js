const DOMNodeCollection = require('./dom_node_collection.js');

window.$l = function(selectors){
  let liteObj = [];

  if(selectors instanceof HTMLElement){
    liteObj.push(selectors);
  } else {
    liteObj.push(document.querySelectorAll(selectors));
  }

  return new DOMNodeCollection(liteObj);
};

// html
//
// Let's write the method html first. It can optionally receive a string as a parameter.
// If it receives an argument, this will become the innerHTML (hint hint) of the each of the nodes. If it does not receive an argument, it should return the innerHTML of the first node in the array.


// empty
//
// This method clears out the content of all nodes in the internal array. I set the html of all nodes to an empty string.


// append
//
// Take a look here. This method should accept either a jQuery-lite wrapped collection, an HTML element, or a string. Append the outerHTML of each element in the argument to the innerHTML of each element in the DOMNodeCollection. Don't worry about converting strings into HTML elements; just pass them straight through to the elements' innerHTML.


// other methods
//
// I will leave it up to you to figure out ways to implement attr, addClass, and removeClass. All the information for how to change nodes is available in this resource.
