defmodule ApiServer.Repo do
  use Ecto.Repo,
    otp_app: :api_server,
    adapter: Ecto.Adapters.Postgres
end
