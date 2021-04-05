defmodule ApiServerWeb.Schema.TranslationTypes do
  use Absinthe.Schema.Notation

  @desc "A response to a translation request"
  object :translation_response do
    field :translated_string, :string
  end
end
