import React from 'react';
import { Link } from 'react-router';

class ItemDetail extends React.Component {
  constructor(props) {
    super(props);
  }

  render(){
    return(
      <content>
        <h1>{ this.props.itemDetail.name }</h1>
      </content>
    );
  }
}

export default ItemDetail;
