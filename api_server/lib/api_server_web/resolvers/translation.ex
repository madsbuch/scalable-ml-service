defmodule ApiServerWeb.Resolvers.Translation do
  alias ApiServer.Repo
  alias ApiServer.Schema.SentencePair

  require OK

  def translate(_parent, %{sentence: sentence}, _resolution) do
    OK.for do
      translation <- ApiServerWeb.TranslationsService.call(sentence)
    after
      %{
        translated_string: translation
      }
    end
  end

  def add_string_pair(attrs, _resolution) do
    OK.for do
      id = UUID.uuid4()

      SentencePair.changeset(%SentencePair{id: id}, attrs)
      |> SentencePair.validate()
      |> Repo.insert()
    after
      %{
        status: "ok"
      }
    end
  end
end
