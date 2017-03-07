import React from 'react';
import ReactDOM from 'react-dom';
import configureStore from './store/store';

import Root from './components/root';



function applyMiddlewares(store, ...middleWares) {
  let dispatch = store.dispatch;
  middleWares.forEach((mW) => {
    dispatch = mW(store)(dispatch);
  });

  return Object.assign({}, store, { dispatch });
}

document.addEventListener('DOMContentLoaded', () => {
  const preloadedState = localStorage.state ?
    JSON.parse(localStorage.state) : {};
  let store = configureStore(preloadedState);

  const root = document.getElementById('content');
  ReactDOM.render(<Root store={store} />, root);
});
