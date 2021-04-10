defmodule ApiServerWeb.Schema.TranslationTypes do
  use Absinthe.Schema.Notation
  use Absinthe.Relay.Schema.Notation, :modern

  alias ApiServerWeb.Resolvers.Translation, as: TranslationResolver

  @desc "A response to a translation request"
  object :translation_response do
    field :translated_string, :string
  end

  object :translation_queries do
    @desc "Get a translation of a string"
    field :translate, :translation_response do
      arg(:sentence, non_null(:string))

      resolve(&TranslationResolver.translate/3)
    end
  end

  object :translation_mutations do
    @desc "Adds a string pair to the database"
    payload field :add_string_pair do
      input do
        field :source_string, non_null(:string)
        field(:target_string, non_null(:string))
        field(:source_lang_code, non_null(:string))
        field(:target_lang_code, non_null(:string))
      end

      output do
        field :status, :string
      end

      resolve(&TranslationResolver.add_string_pair/2)
    end
  end
end
