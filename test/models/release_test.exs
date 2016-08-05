defmodule PanicoCore.ReleaseTest do
  use PanicoCore.ModelCase

  alias PanicoCore.Release

  @valid_attrs %{description: "some content", downvotes: 42, link: "some content", name: "some content", upvotes: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Release.changeset(%Release{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Release.changeset(%Release{}, @invalid_attrs)
    refute changeset.valid?
  end
end
