defmodule ApiServerWeb.Schema.TranslationTypesTest do
  use ExUnit.Case
  use ApiServerWeb.ConnCase, async: false

  alias ApiServer.Repo
  alias ApiServer.Schema.SentencePair
  import Ecto.Query

  setup do
    # TODO Run tests in transactions to ensure isolation
    :ok
  end

  describe "translate" do
    @query_translate """
      query Translate($sentence: String) {
        translate(sentence: $sentence) {
          translatedString
        }
      }
    """

    test "it translates", context do
      variables = %{
        "sentence" => "je vais dormir ."
      }

      resp =
        context.conn
        |> post("/api/graphiql", %{
          "query" => @query_translate,
          "variables" => Jason.encode!(variables)
        })
        |> json_response(200)

      assert %{
               "data" => %{
                 "translate" => %{"translatedString" => "The translation of: je vais dormir ."}
               }
             } = resp
    end
  end

  describe "add_string_pair" do
    @mutation_add_string_pair """
      mutation AddStringPair($input: AddStringPairInput!) {
        addStringPair(input: $input) {
          status
        }
      }
    """

    test "it adds string pair", context do
      variables = %{
        "input" => %{
          "sourceString" => "Hello World!",
          "targetString" => "Hej Verden!",
          "sourceLangCode" => "en-gb",
          "targetLangCode" => "da-dk"
        }
      }

      resp =
        context.conn
        |> post("/api/graphiql", %{
          "query" => @mutation_add_string_pair,
          "variables" => Jason.encode!(variables)
        })
        |> json_response(200)

      # See that is is committed to the database
      sp = Repo.one(from s in SentencePair, where: s.source_string == "Hello World!")

      assert %{"data" => %{"addStringPair" => %{"status" => "ok"}}} = resp

      assert %SentencePair{
               id: _id,
               inserted_at: _inserted_at,
               updated_at: _updated_at,
               source_lang_code: "en-gb",
               source_string: "Hello World!",
               target_lang_code: "da-dk",
               target_string: "Hej Verden!"
             } = sp
    end
  end
end
