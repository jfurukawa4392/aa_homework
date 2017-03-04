import React from 'react';
import ReactDOM from 'react-dom';

class Tabs extends React.Component{
  constructor(props){
    super(props);
    this.state = { index: 0 };
    this.displayTitles = this.displayTitles.bind(this);
    this.handleClick = this.handleClick.bind(this);
  }

  handleClick (e, idx) {
    if (e.target.className === "bold") {
      e.target.className = "unbold";
    } else {
      e.target.className = "bold";
    }

    this.setState({index: idx});
  }


  displayTitles(){
    const articleList = this.props.tabs.map( (tab, idx) => {
      let selected = "unbold";

      if(this.state.index === idx){
        selected = "bold";
      }

      return(
        <li key={idx}>
          <h1 className={selected} onClick={ e => this.handleClick(e, idx)  }>{tab.title}</h1>
          <article>{tab.content}</article>
        </li>
      );
    });
    console.log(articleList);
    return (
      articleList
    );
  }

  render(){

    return (
      <ul>
        { this.displayTitles() }
      </ul>
    );
  }
}

export default Tabs;
