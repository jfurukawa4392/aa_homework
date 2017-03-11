import React from 'react';
import GreetingContainer from './greeting_container';

const App = ({children}) => (
  <content>
    <h1>BenchBnB</h1>
    <GreetingContainer />
    { children }
  </content>
);

export default App;
