import { values } from 'lodash';

export const selectAllPokemon = (state) => (
  values(state.pokemon)
);

export const selectPokemonItem = (state, itemId) => {
  for( let i = 0; i < state.pokemonDetail.items.length; ++i) {
    if(Number(itemId) === state.pokemonDetail.items[i].id)
      return state.pokemonDetail.items[i];
  }
};
