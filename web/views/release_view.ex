defmodule PanicoCore.ReleaseView do
  use PanicoCore.Web, :view

  def render("release.json", %{release: rel}) do
    %{
      id: rel.id,
      name: rel.name,
      description: rel.description,
      upvotes: rel.upvotes,
      downvotes: rel.downvotes
    }
  end
end
