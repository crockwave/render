# Render

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Seed the database with `mix run priv/repo/seeds.exs`
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

  * There are two links under **Rendering Issue Demo**, demonstrating both good rendering of state changes and poor rendering
  * The files to compare are`lib/render_web/templates/live/page_classes.html.heex`, `lib/render_web/templates/live/page_render.html.heex` and the associated LiveComponents that they reference
