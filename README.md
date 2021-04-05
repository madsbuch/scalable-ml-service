# Scalable ML Service

__Quick start:__

1. Clone this repo
2. Prepare the docker images
   ```
   docker build -t smls-server ./api_server
   docker build -t smls-model-runner ./model_runner
   ```
3. `docker-compose up`
4. `PGPASSWORD=postgres psql -h localhost -U postgres -c "create database api_server_prod;"`
5. Navigate to `http://localhost:4000/api/graphiql`
6. Execute following query:
    ```
    query translate {
      translate (sourceString: "je vais dormir .") {
        translatedString
      }
    }
    ```

This repository contains example code for a scalable ML service. The use case
is to build an ML translation service.

Thea architecture is bashed on a RabbitMq message broker, an Elixir GraphQl
server and a Python service that carries out translations. Everything is
orchestrated by using docker compose.

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
  data.
* __Frontend Application:__ Build and embed a frontend application.
* __Save Predictions:__ Dave the predictions made to "improve service".


If you have more ideas the write me and lets have aa talk!

# Resources

* https://www.rabbitmq.com/tutorials/tutorial-six-elixir.html
* https://www.rabbitmq.com/tutorials/tutorial-six-python.html
* https://pytorch.org/tutorials/intermediate/seq2seq_translation_tutorial.html
* Internet searches...
