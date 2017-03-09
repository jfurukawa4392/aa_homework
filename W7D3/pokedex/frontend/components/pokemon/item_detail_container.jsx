import { connect } from 'react-redux';
import { requestSinglePokemon } from '../../actions/pokemon_actions';
import ItemDetail from './item_detail';
import { selectPokemonItem } from '../../reducers/selectors';

const mapStateToProps = (state, ownProps) => ({
  itemDetail: selectPokemonItem(state, ownProps.params.itemId)
});

const mapDispatchToProps = dispatch => ({
  // requestSinglePokemon: (pokemonID) => dispatch(requestSinglePokemon(pokemonID))
});

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(ItemDetail);
