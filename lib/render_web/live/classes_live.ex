defmodule RenderWeb.ClassesLive do
  use Phoenix.LiveView,
    layout: {RenderWeb.LayoutView, "live.html"}

  alias RenderWeb.Router.Helpers, as: Routes
  alias Render.Classes.Class
  alias Render.Repo
  import RenderWeb.Gettext
  import Ecto.Query
  import Render.Util

  @impl true
  def mount(params, session, socket) do
    case connected?(socket) do
      true -> connected_mount(params, session, socket)
      false -> {:ok, assign(socket, page: "loading")}
    end
  end

  def connected_mount(_params, _session, socket) do
    classes = get_classes()
    selected_class = "0"
    IO.puts("ClassesLive connected_mount, classes: #{inspect classes}")
    {:ok, assign(socket, selected_class: selected_class, page: "classes", classes: classes)}
  end

  @impl true
  def render(%{page: "loading"} = assigns) do
    ~H"""
    <div><%= gettext("The page is loading, please wait...") %></div>
    """
  end

  @impl true
  def render(%{page: page} = assigns) do
    Phoenix.View.render(RenderWeb.LiveView, "page_" <> page <> ".html", assigns)
  end

  @impl true
  def handle_event("select_class", %{"id" => class_id}, socket) do
    IO.puts("ClassesLive handle_event select_class, class_id: #{class_id}")
    {:noreply, assign(socket, selected_class: class_id)}
  end  

  @impl true
  def handle_event("archive_class", %{"id" => class_id} = _params, %{assigns: assigns} = socket) do
    class = Repo.get!(Class, class_id)
    class = Ecto.Changeset.change class, archived: true
    case Repo.update class do
      {:ok, _struct} ->
        classes = get_classes()
        IO.puts("ClassesLive handle_event archive_class, classes: #{inspect classes}")
        {:noreply, assign(socket, classes: classes)}
      {:error, changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  @impl true
  def handle_event("unarchive_class", %{"id" => class_id} = _params, %{assigns: assigns} = socket) do
    class = Repo.get!(Class, class_id)
    class = Ecto.Changeset.change class, archived: false
    case Repo.update class do
      {:ok, _struct} ->
        classes = get_classes()
        IO.puts("ClassesLive handle_event unarchive_class, classes: #{inspect classes}")
        {:noreply, assign(socket, classes: classes)}
      {:error, changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  # ---------------
  # get_classes
  # ---------------
  def get_classes() do
    Repo.all(
      from c in Class,
        order_by: [c.archived, c.title, c.id]
    )
  end
end
