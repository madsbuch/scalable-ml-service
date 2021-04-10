# Scalable ML Service

__Quick start:__

1. Clone this repo
2. Prepare the docker images
   ```
   docker build -t smls-server ./api_server
   docker build -t smls-model-runner ./model_runner
   ```
3. `docker-compose up`
4. Navigate to `http://localhost:4000/api/graphiql`
5. Execute following query:

```
query Translate {
  translate (sentence: "je vais dormir .") {
    translatedString
  }
}

mutation AddString {
  addStringPair(input:{sourceString: "hello", targetString:"hej",sourceLangCode:"en-gb", targetLangCode:"da-dk"}) {
    status
  }
}
```


__The Project:__ The goal is to build a full architecture to gather sentence
pairs in various languages and run the infrastructure to build the machine
learned models and provide a translations interface.

The project is purely educational and offers me a change to work with

* Machine learning
* Scalable architectures
* Application development
* Infrastructure development
* API development
* Test development
* Benchmarking a solution
* Etc.

It will not, however, offer a training ground for general DevOps, the art
of keeping the uptime near 100%, live migrations, continuous
integration/deployment etc.

Related blog articles are:

1. [Scalable Machine Learning Service](https://www.madsbuch.com/scalable-ml-service/)

Further things to do as educational tasks:

* __Improve Translator:__ The Python implementation of the translator is sole
  representative. It needs to be able to parse input properly, etc.
* __Auto Scaling:__ Currently we statically set the number of instances we run.
  ideally this would be adjusted depending on load.
* __Asynchronous:__ Currently the GraphQl interface is synchronous. one makes a
  query and receives an answer. though for long running tasks this is not
  optimal and we can push the asynchronous semantics all the way to the client.
* __Multiple models:__ How would we architect for a system that serves several
  ML models. Maybe a model per user.
* __Resilience:__ Currently stuff like back off, timeouts, etc has not been
  implemented. This would also be needed.
* __Development Setup:__ Currently it is hard to develop anything as there are
  strong dependencies.
* __Migrations:__ Currently the Postgres database is dead weight. However, in
  a real life situation we need to handle migration etc. as a part of the
  architecture.
* __Training:__ Integrate a training pipeline for models based on changes of
  data og changes of the model they are trained on.
* __Frontend Application:__ Build and embed a frontend application.
* __Save Predictions:__ Dave the predictions made to "improve service".


# Resources
Thanks to the authors behind following resources.

1. https://www.rabbitmq.com/tutorials/tutorial-six-elixir.html
2. https://www.rabbitmq.com/tutorials/tutorial-six-python.html
3. https://pytorch.org/tutorials/intermediate/seq2seq_translation_tutorial.html

And thanks to the entire community making projects like these possible.