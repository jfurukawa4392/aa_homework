import React from 'react';
import PokemonIndexItem from './pokemon_index_item';

class PokemonIndex extends React.Component {
  constructor() {
    super();
  }

  componentDidMount() {
    this.props.requestAllPokemon();
  }

  render() {
    let pokemon = this.props.pokemon.map((entry, i) => {
      return(
        <PokemonIndexItem key={i} poke={entry}/>
      );
    });

    return (
      <section className="pokedex">
        <ul>
          {pokemon}
        </ul>
      </section>
    );
  }
}

export default PokemonIndex;
