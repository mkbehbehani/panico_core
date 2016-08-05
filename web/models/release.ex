defmodule PanicoCore.Release do
  use PanicoCore.Web, :model

  schema "releases" do
    field :name, :string
    field :description, :string
    field :link, :string
    field :upvotes, :integer
    field :downvotes, :integer

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :description, :link, :upvotes, :downvotes])
    |> validate_required([:name, :description, :link, :upvotes, :downvotes])
  end
end
