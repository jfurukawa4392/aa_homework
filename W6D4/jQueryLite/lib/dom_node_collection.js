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
