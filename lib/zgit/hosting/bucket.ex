defmodule Zgit.Hosting.Bucket do
  use Ecto.Schema
  import Ecto.Changeset

  schema "bucket" do
    field :name, :string
    field :description, :string
    field :local_path, :string
    field :user_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(bucket, attrs) do
    bucket
    |> cast(attrs, [:name, :description, :local_path])
    |> validate_required([:name, :description, :local_path])
  end
end
