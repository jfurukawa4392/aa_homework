import { RECEIVE_SINGLE_POKEMON } from '../actions/pokemon_actions';
import { merge } from 'lodash';

const PokemonDetailReducer = (state = {}, action) => {
  let newState;

  switch (action.type) {
    case RECEIVE_SINGLE_POKEMON:
      newState = merge({}, state, action.pokemon);
      return newState;
    default:
      return state;
  }
};

export default PokemonDetailReducer;
