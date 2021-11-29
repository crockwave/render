defmodule Render.Repo do
  use Ecto.Repo,
    otp_app: :render,
    adapter: Ecto.Adapters.Postgres
end
