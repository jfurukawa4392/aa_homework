import * as SessionAPI from '../util/session_api_util';

export const RECEIVE_CURRENT_USER = 'RECEIVE_CURRENT_USER';
export const RECEIVE_ERRORS = 'RECEIVE_ERRORS';

export const login = (user) => (dispatch) => {
  SessionAPI.login(user)
            .then( res => dispatch(receiveCurrentUser(res)) )
            .fail( res => dispatch(receiveErrors(res)) );
};

export const logout = () => (dispatch) => {
  SessionAPI.logout()
            .then( res => dispatch(receiveCurrentUser(res)) )
            .fail( res => dispatch(receiveErrors(res)) );
};

export const signup = (user) => (dispatch) => {
  SessionAPI.signup()
            .then( res => dispatch(receiveCurrentUser(res)) )
            .fail( res => dispatch(receiveErrors(res)) );
};

export const receiveCurrentUser = (currentUser) => ({
  type: RECEIVE_CURRENT_USER,
  currentUser
});

export const receiveErrors = (errorsArr) => ({
  type: RECEIVE_ERRORS,
  errors: errorsArr
});
