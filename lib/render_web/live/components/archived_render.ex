defmodule RenderWeb.Components.ArchivedRender do
  use Phoenix.LiveComponent

  def render(assigns) do
    Phoenix.View.render(RenderWeb.LiveView, "component_archived_render.html", assigns)    
  end
end