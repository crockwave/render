# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Render.Repo.insert!(%Render.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

Render.Repo.insert!(%Render.Classes.Class{
	title: "Math",
	archived: false,
})

Render.Repo.insert!(%Render.Classes.Class{
	title: "French",
	archived: false,
})

Render.Repo.insert!(%Render.Classes.Class{
	title: "Chemistry",
	archived: false,
})
