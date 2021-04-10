defmodule ApiServerWeb.Schema do
  use Absinthe.Schema
  use Absinthe.Relay.Schema, :modern

  import_types(Absinthe.Type.Custom)
  import_types(ApiServerWeb.Schema.TranslationTypes)

  query do
    import_fields(:translation_queries)
  end

  mutation do
    import_fields(:translation_mutations)
  end
end
