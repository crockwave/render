defmodule Render.Repo.Migrations.Classes do
  use Ecto.Migration

  def change do
    create table(:classes) do
      add :title, :string, null: false
      add :archived, :boolean, default: false
        
      timestamps()  # inserted_at and updated_at
    end
  end
end
