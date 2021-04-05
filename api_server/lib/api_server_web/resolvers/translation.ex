defmodule ApiServerWeb.Resolvers.Translation do
  def translate(_parent, %{source_string: source_string}, _resolution) do
    translation = ApiServerWeb.TranslationRPC.call(source_string)

    {:ok,
     %{
       translated_string: translation
     }}
  end
end
