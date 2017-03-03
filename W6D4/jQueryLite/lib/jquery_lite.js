/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};

/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {

/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId])
/******/ 			return installedModules[moduleId].exports;

/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			i: moduleId,
/******/ 			l: false,
/******/ 			exports: {}
/******/ 		};

/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);

/******/ 		// Flag the module as loaded
/******/ 		module.l = true;

/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}


/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;

/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;

/******/ 	// identity function for calling harmony imports with the correct context
/******/ 	__webpack_require__.i = function(value) { return value; };

/******/ 	// define getter function for harmony exports
/******/ 	__webpack_require__.d = function(exports, name, getter) {
/******/ 		if(!__webpack_require__.o(exports, name)) {
/******/ 			Object.defineProperty(exports, name, {
/******/ 				configurable: false,
/******/ 				enumerable: true,
/******/ 				get: getter
/******/ 			});
/******/ 		}
/******/ 	};

/******/ 	// getDefaultExport function for compatibility with non-harmony modules
/******/ 	__webpack_require__.n = function(module) {
/******/ 		var getter = module && module.__esModule ?
/******/ 			function getDefault() { return module['default']; } :
/******/ 			function getModuleExports() { return module; };
/******/ 		__webpack_require__.d(getter, 'a', getter);
/******/ 		return getter;
/******/ 	};

/******/ 	// Object.prototype.hasOwnProperty.call
/******/ 	__webpack_require__.o = function(object, property) { return Object.prototype.hasOwnProperty.call(object, property); };

/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";

/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(__webpack_require__.s = 0);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */
/***/ (function(module, exports, __webpack_require__) {

const DOMNodeCollection = __webpack_require__(1);

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


/***/ }),
/* 1 */
/***/ (function(module, exports) {

class DOMNodeCollection {
  constructor(elementArray) {
    this.elementList = elementArray;
  }

  html(innerHTML){ // set inner HTML on all elements or return first
    if(!innerHTML) {
      return this.elementList[0].innerHTML;
    } else {
      this.each((el) => (el.innerHTML = innerHTML));
    }
  }

  empty(){ //empty all nodes in the jQL object
    for (let i = 0; i < this.elementList.length; i++) {
      this.elementList[i].innerHTML = "";
    }
  }

  append(children) { //
    if (this.elementList[0].length === 0) return;
    if(children instanceof HTMLElement || typeof children == "string"){
      this.html(children);
    } else if (children.constructor.name === "DOMNodeCollection") {
      children.each((el) => this.html(el.outerHTML));
    }
  }

  each(cb) {
  // Our each passes in the node and index in traditional 'forEach' order,
  // jquery passes in index first and binds the call to the element.
    this.elementList[0].forEach(cb);
  }

  children(){

  }

  parent(){

  }

  find(selector){

  }

  remove(){

  }
}


module.exports = DOMNodeCollection;


/***/ })
/******/ ]);