defmodule PanicoCore.ReleaseView do
  use PanicoCore.Web, :view

  def render("release.json", %{release: rel}) do
    %{
      name: rel.name,
      description: rel.description,
      upvotes: rel.upvotes,
      downvotes: rel.downvotes
    }
  end
end
