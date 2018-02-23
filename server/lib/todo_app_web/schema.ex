defmodule TodoAppWeb.Schema do
  use Absinthe.Schema

  alias TodoApp.{Repo, Task}

  @desc "A task in the todo system"
  object :task do
    field(:id, :id)
    field(:name, :string)
    field(:description, :string)
    field(:is_completed, :boolean)
  end

  #   # Example data
  #   @items %{
  #     "foo" => %{id: "foo", name: "Foo"},
  #     "bar" => %{id: "bar", name: "Bar"}
  #   }

  query do
    field :tasks, list_of(:task) do
      resolve(fn _, _ ->
        {:ok, Task |> TodoApp.Repo.all()}
      end)
    end
  end

  mutation do
    field :create_task, :task do
      arg(:name, non_null(:string))
      arg(:description, :string)

      resolve(fn _,args, _ ->
        {:ok, Task.changeset(%Task{}, args) |> Repo.insert!()}
      end)
    end

    field :complete_task, :task do
      arg(:id, non_null(:id))

      resolve(fn _, args, _ ->
        task = Repo.get!(Task, args.id)
        {:ok, Task.toggle_complete(task) |> Repo.update!}
      end)
    end

    field :uncomplete_task, :task do
        arg(:id, non_null(:id))

      resolve(fn _, args, _ ->
        task = Repo.get!(Task, args.id)
        {:ok, Task.toggle_complete(task) |> Repo.update!}
      end)
    end
  end
end