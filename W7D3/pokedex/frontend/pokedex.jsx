import React from 'react';
import ReactDOM from 'react-dom';
import configureStore from './store/store';
import Root from './components/root';


import selectAllPokemon from './reducers/selectors';
import * as PokeActions from './actions/pokemon_actions';
import * as APIUtil from './util/api_util';

// window.receiveAllPokemon = PokeActions.receiveAllPokemon;
// window.fetchAllPokemon = APIUtil.fetchAllPokemon;
// window.requestAllPokemon = PokeActions.requestAllPokemon;
// window.selectAllPokemon = selectAllPokemon;

document.addEventListener("DOMContentLoaded", () => {
  const store = configureStore();
  window.store = store;
  const rootEl = document.getElementById('root');
  ReactDOM.render(<Root store={store}/>, rootEl);
});
