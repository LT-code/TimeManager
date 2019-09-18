# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds/role.exs
#

alias Todolist.Security

role_data = [
  %{
    name: "User"
  },
  %{
    name: "Manager"
  },
  %{
    name: "General Manager"
  }
]

Enum.each(role_data, fn(data) ->
  Security.create_role(data)
end)
