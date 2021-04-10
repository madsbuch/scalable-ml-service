defmodule BouncePersistence.Repo.Migrations.IAM.CreateAccount do
  use Ecto.Migration

  def change do
    create table(:sentence_pairs, primary_key: false) do
      add(:id, :uuid, primary_key: true)
      add(:source_string, :string)
      add(:target_string, :string)
      add(:source_lang_code, :string)
      add(:target_lang_code, :string)
      timestamps()
    end
  end
end
