import React from 'react';
import { Link } from 'react-router';

const PokemonIndexItem = ({ poke }) => {
  return(
    <li>
      <Link to={`/pokemon/${poke.id}`}>
        <h2>{poke.name}</h2>
        <img src={poke.image_url}></img>
      </Link>
    </li>
  );
};

export default PokemonIndexItem;
