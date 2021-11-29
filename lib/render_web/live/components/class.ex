defmodule RenderWeb.Components.Class do
  use Phoenix.LiveComponent

  def render(assigns) do
    Phoenix.View.render(RenderWeb.LiveView, "component_class.html", assigns)    
  end
end