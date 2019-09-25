# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds/user.exs
#

alias Todolist.Account

user_data = [
  %{
    email: "thomas.toto@test.com",
    username: "tolo",
    password: "toto64480",
    password_confirmation: "toto64480",
    role: 1
  },
  %{
    email: "root@test.com",
    username: "rootroot",
    password: "rootroot",
    password_confirmation: "root",
    role: 3
  },
  %{
    email: "boss@test.com",
    username: "boss",
    password: "adminadmin",
    password_confirmation: "adminadmin",
    role: 2
  }
]

Enum.each(user_data, fn(data) ->
  Account.create_user(data)
end)
