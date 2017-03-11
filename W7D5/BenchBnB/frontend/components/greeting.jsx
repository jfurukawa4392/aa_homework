import React from 'react';
import { Link } from 'react-router';

class Greeting extends React.Component{
  constructor(props){
    super(props);
  }

  handleLogout(){
    console.log();
    return( e => (
      this.props.logout()
    ));
  }

  render(){
    let greet;
    let user = this.props.currentUser;
    if(Boolean(user)){
      greet = (
        <section>
          <h1>Welcome, {user.username}</h1>
          <button onClick={this.handleLogout(user)}>Logout</button>
        </section>
      );
    } else {
      greet = (
        <section>
          <Link to='/signup'>Sign Up</Link>
          <br />
          <Link to='/login'>Login</Link>
        </section>
      );
    }

    return(
      <content>
        {greet}
      </content>
    );
  }
}

export default Greeting;
