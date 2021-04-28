import React, { useState } from 'react';
import logo from './logo.svg';
import './App.css';
import { useTranslateQuery } from './generated/graphql';
import { ApolloClient, InMemoryCache } from '@apollo/client';

const client = new ApolloClient({
  uri: 'http://localhost:4000/api/graphql',
  cache: new InMemoryCache()
});

function App() {

  const [sentence, setSentence] = useState("")
  const {data, loading} = useTranslateQuery({
    variables: {
      sentence
    },
    client
  })

  return (
    <div className="App">
      <header className="App-header">
        <textarea placeholder="Something in french" value={sentence} onChange={v => setSentence(v.target.value)} style={{margin: "20px", height: "400px", width: "600px"}} >
        </textarea>

        <div>
          {data?.translate?.translatedString}
        </div>

      </header>
    </div>
  );
}

export default App;
