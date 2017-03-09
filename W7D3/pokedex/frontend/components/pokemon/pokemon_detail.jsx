import React from 'react';
import { Link } from 'react-router';
import ItemDetailContainer from './item_detail_container';

class PokemonDetail extends React.Component {
  constructor(props) {
    super(props);
  }

  componentDidMount(){
    this.props.requestSinglePokemon(this.props.params.pokemonID);
  }

  componentWillReceiveProps(newProps) {
    if(newProps.params.pokemonID !== this.props.params.pokemonID)
      this.props.requestSinglePokemon(newProps.params.pokemonID);
  }

  render(){
    return(
      <content>
        <h1>{ this.props.pokemonDetail.name }</h1>
        {this.props.children}
      </content>
    );
  }
}

export default PokemonDetail;
