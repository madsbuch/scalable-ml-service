# Architecture
This file lays out the overall architecture of this project.

## Code Map

### `api_server`
Contains an Elixir Phoenix based api server that governs the interaction to
the entire setup. It takes responsibilities such at

* Authentication external requests
* Route requests to internal services
* Provide API for administrative stuff
* Start training of new models

### `frontend_app`
The frontend application written in React. It provides a humane interface
to the entire system.

### `model_runner`
The code to train and execute models.

## Inter Service Communication
All services communicate through a rabbitMq message broker.