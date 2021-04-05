defmodule ApiServerWeb.Schema do
  use Absinthe.Schema

  alias ApiServerWeb.Resolvers.Translation, as: TranslationResolver

  import_types(Absinthe.Type.Custom)
  import_types(ApiServerWeb.Schema.TranslationTypes)

  query do
    @desc "Get a translation of a string"
    field :translate, :translation_response do
      arg(:source_string, non_null(:string))

      resolve(&TranslationResolver.translate/3)
    end
  end
end
