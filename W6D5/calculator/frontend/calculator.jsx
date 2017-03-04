import React from 'react';

class Calculator extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      result: 0,
      num1: "",
      num2: ""
    };

    this.setNum1 = this.setNum1.bind(this);
    this.setNum2 = this.setNum2.bind(this);
    this.operation = this.operation.bind(this);
    this.reset = this.reset.bind(this);
  }

  setNum1(e){
    e.preventDefault();
    this.setState({num1: e.target.value});
  }

  setNum2(e){
    e.preventDefault();
    this.setState({num2: e.target.value});
  }

  operation(e){
    e.preventDefault();
    let op = e.target.value;
    if(op==="+") {
      this.setState({result: (parseInt(this.state.num1) + parseInt(this.state.num2))});
    }
    else if(op==="-") {
      this.setState({result: (parseInt(this.state.num1) - parseInt(this.state.num2))})
    }
    else if(op==="*") {
      this.setState({result: (parseInt(this.state.num1) * parseInt(this.state.num2))})
    }
    else if(op==="/"){
      this.setState({result: (parseInt(this.state.num1) / parseInt(this.state.num2))})
    }
  }

  reset(e){
    this.setState({result: 0,
                   num1: "",
                   num2: ""});
  }

  render() {
    return (
      <div>
        <input
          onChange={this.setNum1}
          value={this.state.num1}>
        </input>
        <br/>
        <input
          onChange={this.setNum2}
          value={this.state.num2}>
        </input>
        <br></br>
        <button onClick={this.operation} value="+">+</button>
        <button onClick={this.operation} value="-">-</button>
        <button onClick={this.operation} value={"*"}>*</button>
        <button onClick={this.operation} value={"/"}>/</button>
        <br></br>
        <button onClick={this.reset}>Clear!</button>
        <h1>{this.state.result}</h1>
      </div>
    );
  }
}

export default Calculator;
