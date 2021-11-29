defmodule RenderWeb.Components.ArchivedClass do
  use Phoenix.LiveComponent

  def render(assigns) do
    Phoenix.View.render(RenderWeb.LiveView, "component_archived_class.html", assigns)    
  end
end