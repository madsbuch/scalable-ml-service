defmodule ApiServer.Schema.SentencePair do
  use Ecto.Schema
  alias __MODULE__
  import Ecto.Changeset

  @attrs [:id, :source_string, :target_string, :source_lang_code, :target_lang_code]

  @timestamps_opts [type: :utc_datetime_usec]
  @primary_key {:id, :binary_id, autogenerate: false}
  @foreign_key_type :binary_id
  schema "sentence_pairs" do
    field(:source_string, :string)
    field(:target_string, :string)
    field(:source_lang_code, :string)
    field(:target_lang_code, :string)
    timestamps()
  end

  def changeset(%SentencePair{} = sentencePair, attrs \\ %{}) do
    sentencePair
    |> cast(attrs, @attrs)
  end

  def validate(changeset) do
    changeset
    |> validate_required(@attrs)
  end
end
