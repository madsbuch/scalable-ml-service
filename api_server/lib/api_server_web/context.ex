defmodule ApplicationWeb.Context do
  @moduledoc """
  Good to have, here we add authorization and other API global
  things.
  """

  @behaviour Plug

  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _) do
    conn
  end
end
