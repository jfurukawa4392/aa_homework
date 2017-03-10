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

export const createPokemon = (pokemon) => {
  console.log(pokemon);
  $.ajax({
    url: `api/pokemon`,
    method: 'POST',
    dataType: 'json',
    data: pokemon
  });
};
