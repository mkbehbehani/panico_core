defmodule PanicoCore.ReleaseController do
  use PanicoCore.Web, :controller

  alias PanicoCore.Release

  def index(conn, _params) do
    releases = Repo.all(Release)
    render(conn, "index.html", releases: releases)
  end

  def new(conn, _params) do
    changeset = Release.changeset(%Release{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"release" => release_params}) do
    changeset = Release.changeset(%Release{}, release_params)

    case Repo.insert(changeset) do
      {:ok, _release} ->
        conn
        |> put_flash(:info, "Release created successfully.")
        |> redirect(to: release_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    release = Repo.get!(Release, id)
    render(conn, "show.html", release: release)
  end

  def edit(conn, %{"id" => id}) do
    release = Repo.get!(Release, id)
    changeset = Release.changeset(release)
    render(conn, "edit.html", release: release, changeset: changeset)
  end

  def update(conn, %{"id" => id, "release" => release_params}) do
    release = Repo.get!(Release, id)
    changeset = Release.changeset(release, release_params)

    case Repo.update(changeset) do
      {:ok, release} ->
        conn
        |> put_flash(:info, "Release updated successfully.")
        |> redirect(to: release_path(conn, :show, release))
      {:error, changeset} ->
        render(conn, "edit.html", release: release, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    release = Repo.get!(Release, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(release)

    conn
    |> put_flash(:info, "Release deleted successfully.")
    |> redirect(to: release_path(conn, :index))
  end
end
