defmodule TodoApp.Task do
  use Ecto.Schema
  import Ecto.Changeset
  alias TodoApp.Task


  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "tasks" do
    field :description, :string
    field :is_completed, :boolean, default: false
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(%Task{} = task, attrs) do
    task
    |> cast(attrs, [:name, :description, :is_completed])
    |> validate_required([:name])
  end

  def toggle_complete(%Task{} = task) do
    if task.is_completed do
        change(task, is_completed: false)
    else
        change(task, is_completed: true)
    end
  end
end
