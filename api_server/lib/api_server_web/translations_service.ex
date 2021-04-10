defmodule ApiServerWeb.TranslationsService do
  @moduledoc """
  Interface to the translation service
  """
  def call(source), do: Application.get_env(:api_server, :translations_service).call(source)
end

defmodule ApiServerWeb.TranslationsService.IO do
  @moduledoc """
  Mock translations service for testing
  """

  def call(source) do
    IO.inspect("EXECUTING TRANSLATION SERVICE")

    {:ok, "The translation of: #{source}"}
  end
end

defmodule ApiServerWeb.TranslationsService.MessageRPC do
  @moduledoc """
  We should probably reuse connections here
  """

  def wait_for_messages(_channel, correlation_id) do
    receive do
      {:basic_deliver, payload, %{correlation_id: ^correlation_id}} -> {:ok, payload}
    end
  end

  def call(source) do
    {:ok, connection} = AMQP.Connection.open("amqp://guest:guest@rabbitmq")
    {:ok, channel} = AMQP.Channel.open(connection)

    {:ok, %{queue: queue_name}} =
      AMQP.Queue.declare(
        channel,
        "",
        exclusive: true
      )

    AMQP.Basic.consume(channel, queue_name, nil, no_ack: true)

    correlation_id =
      :erlang.unique_integer()
      |> :erlang.integer_to_binary()
      |> Base.encode64()

    request = to_string(source)

    AMQP.Basic.publish(
      channel,
      "",
      "rpc_queue",
      request,
      reply_to: queue_name,
      correlation_id: correlation_id
    )

    wait_for_messages(channel, correlation_id)
  end
end
