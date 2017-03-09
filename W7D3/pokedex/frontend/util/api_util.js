export const fetchAllPokemon = () => (
  $.ajax({
    url: 'api/pokemon'
  })
);

export const fetchPokemon = (pokemon) => (
  $.ajax({
    url: `api/pokemon/${pokemon.id}`
  })
);
