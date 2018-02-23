defmodule TodoAppWeb.Router do
  use TodoAppWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", TodoAppWeb do
    pipe_through :api
  end
end
