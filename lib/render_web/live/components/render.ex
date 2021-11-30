defmodule RenderWeb.Components.Render do
  use Phoenix.LiveComponent

  def render(assigns) do
    Phoenix.View.render(RenderWeb.LiveView, "component_render.html", assigns)    
  end
end