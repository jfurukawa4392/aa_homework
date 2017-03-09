import { values } from 'lodash';

const selectAllPokemon = (state) => (
  values(state.pokemon)
);

export default selectAllPokemon;
