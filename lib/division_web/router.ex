defmodule DivisionWeb.Router do
  use DivisionWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", DivisionWeb do
    pipe_through [:browser, DivisionWeb.Plugs.Guest]

    resources "/register", UserController, only: [:create, :new]
    get "/login", SessionController, :new
    post "/login", SessionController, :create
  end


  scope "/", DivisionWeb do
    pipe_through [:browser, DivisionWeb.Plugs.Auth]

    delete "/logout", SessionController, :delete

    get "/", PageController, :index

    resources "/profile", UserController, only: [:show, :edit, :update]
  end
  # Other scopes may use custom stacks.
  # scope "/api", DivisionWeb do
  #   pipe_through :api
  # end
end
