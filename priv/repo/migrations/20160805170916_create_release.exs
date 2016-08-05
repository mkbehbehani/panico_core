defmodule PanicoCore.Repo.Migrations.CreateRelease do
  use Ecto.Migration

  def change do
    create table(:releases) do
      add :name, :string
      add :description, :string
      add :link, :string
      add :upvotes, :integer
      add :downvotes, :integer

      timestamps()
    end

  end
end
