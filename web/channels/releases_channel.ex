defmodule PanicoCore.ReleasesChannel do
  use PanicoCore.Web, :channel

  def join("releases:" <>  releases_id, _params, socket) do
    :timer.send_interval(1_000, :ping)
    releases = Repo.all(PanicoCore.Release)
    resp = %{releases: Phoenix.View.render_many(releases, PanicoCore.ReleaseView, "release.json")}
    {:ok, resp, socket}
  end



  def handle_info(:ping, socket) do
    count=socket.assigns[:count] || 1
    push socket, "ping", %{count: count}

    {:noreply, assign(socket, :count, count + 1)}
  end

  def broadcast_new_release(rel) do
    payload = Phoenix.View.render(PanicoCore.ReleaseView, "release.json", %{release: rel})
    PanicoCore.Endpoint.broadcast("releases:all", "new_release", payload)
  end

  def broadcast_updated_release(rel) do
    payload = Phoenix.View.render(PanicoCore.ReleaseView, "release.json", %{release: rel})
    PanicoCore.Endpoint.broadcast("releases:all", "updated_release", payload)
  end

  def broadcast_deleted_release(rel) do
    payload = Phoenix.View.render(PanicoCore.ReleaseView, "release.json", %{release: rel})
    PanicoCore.Endpoint.broadcast("releases:all", "deleted_release", payload)
  end

end
