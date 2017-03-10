import {
        RECEIVE_CURRENT_USER,
        RECEIVE_ERRORS
      } from '../actions/session_actions';
import merge from 'lodash/merge';

const nullUser = {
                  currentUser: null,
                  errors: []
                };

const SessionReducer = (state = nullUser, action) => {
  let newState;
  switch(action.type){
    case(RECEIVE_CURRENT_USER):
      newState = action.currentUser;
      return merge({}, nullUser, newState);
    case(RECEIVE_ERRORS):
      newState = action.errors;
      return merge({}, state, newState);
    default:
      return state;
  }
};

export default SessionReducer;
