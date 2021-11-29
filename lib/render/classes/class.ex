defmodule Render.Classes.Class do
  use Ecto.Schema
  import Ecto.Changeset

  schema "classes" do
    field :title, :string  # name of class
    field :archived, :boolean, default: false
    
    timestamps()
  end

  @doc false
  def changeset(class, attrs) do
    # IO.puts "Class changeset event: #{inspect class}, attrs: #{inspect attrs}"
    class
    |> cast(attrs, [:title])
    |> validate_required([:title])
  end
end
