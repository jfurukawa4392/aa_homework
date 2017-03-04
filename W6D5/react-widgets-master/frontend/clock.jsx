import React from 'react';

class Clock extends React.Component {
  constructor() {
    super();
    this.state = {date: new Date()};
    this.tick = this.tick.bind(this);
  }

  tick(){
    this.state.date.setSeconds(this.state.date.getSeconds()+1);
    this.setState({date: this.state.date});
  }

  componentDidMount() {
    this.intervalId = setInterval( () => {
      this.tick();
    },1000);

    var request = new XMLHttpRequest();
    request.open('GET', '/my/url', true);

    request.onload = function() {
    if (request.status >= 200 && request.status < 400) {
      // Success!
      var resp = request.responseText;
    } else {
    // We reached our target server, but it returned an error

      }
    };

    request.onerror = function() {
      // There was a connection error of some sort
    };

    request.send();
  }

  componentWillUnmount () {
    clearInterval(this.intervalId);
  }



  render() {
    return (
      <section>
        <h3>{this.state.date.toString()}</h3>
      </section>
    );
  }
}

export default Clock;
