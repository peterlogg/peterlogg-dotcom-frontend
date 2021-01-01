// index.js
import './main.css';
// import { config } from 'dotenv';
import { Elm } from './Main.elm';
import * as serviceWorker from './serviceWorker';

// new webpack.EnvironmentPlugin(['ELM_APP_BACKEND_URL']);

console.log(process.env)
const app = Elm.Main.init({
  node: document.getElementById('root'),
  flags: {
    environment: process.env.NODE_ENV,
    backendUrl: process.env.ELM_APP_BACKEND_URL
  }
});

// If you want your app to work offline and load faster, you can change
// unregister() to register() below. Note this comes with some pitfalls.
// Learn more about service workers: https://bit.ly/CRA-PWA
serviceWorker.unregister();
