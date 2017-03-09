export const fetchAllPokemon = () => (
  $.ajax({
    url: 'api/pokemon'
  })
);

export const fetchPokemon = (pokemonID) => (
  $.ajax({
    url: `api/pokemon/${pokemonID}`
  })
);
