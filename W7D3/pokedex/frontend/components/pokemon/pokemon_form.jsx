import React from 'react';
const TYPES = [
    "fire",
    "electric",
    "normal",
    "ghost",
    "psychic",
    "water",
    "bug",
    "dragon",
    "grass",
    "fighting",
    "ice",
    "flying",
    "poison",
    "ground",
    "rock",
    "steel"
];

class PokemonForm extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      name: "Name",
      attack: "Attack",
      defense: "Defense",
      image_url: "Image Url",
      move1: "Move 1",
      move2: "Move 2",
      poke_type: ""
    };
    this.update = this.update.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
  }

  update(property){
    return e => this.setState({ property: e.target.value});
  }

  handleSubmit(e){
    e.preventDefault();

    this.props.createPokemon(this.state);
  }

  render() {
    let types = TYPES.map((type, i) => {
      return(
        <option key={i} value={type}>{type}</option>
      );
    });
    return(
      <form onSubmit={this.handleSubmit}>
        <input type="text" value={this.state.name} onChange={() => (this.update('name'))}/>
        <br />
        <input type="text" value={this.state.image_url} onChange={() => (this.update('image_url'))}/>
        <br />
        <select onChange={() => (this.update('poke_type'))}>
          {types}
        </select>
        <br />
        <input type="text" value={this.state.attack} onChange={() => (this.update('attack'))}/>
        <br />
        <input type="text" value={this.state.defense} onChange={() => (this.update('defense'))}/>
        <br />
        <input type="text" value={this.state.move1} onChange={() => (this.update('move1'))}/>
        <br />
        <input type="text" value={this.state.move2} onChange={() => (this.update('move2'))}/>
        <br />
        <input type="submit" value="Create New Pokemon"/>
      </form>
    );
  }
}

export default PokemonForm;
