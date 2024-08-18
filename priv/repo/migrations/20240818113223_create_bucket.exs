defmodule Zgit.Repo.Migrations.CreateBucket do
  use Ecto.Migration

  def change do
    create table(:bucket) do
      add :name, :string
      add :description, :string
      add :local_path, :string
      add :user_id, references(:users, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:bucket, [:user_id])
  end
end
