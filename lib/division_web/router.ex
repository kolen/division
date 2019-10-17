defmodule DivisionWeb.Router do
  use DivisionWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug Phoenix.LiveView.Flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :matrix do
    # Allow Matrix endpoint to be used from web clients, see
    # https://matrix.org/docs/spec/client_server/r0.5.0#web-browser-clients
    plug CORSPlug
  end

  scope "/", DivisionWeb do
    pipe_through [:browser]

    get "/", PageController, :index
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

    resources "/profile", UserController, only: [:show, :edit, :update]
    resources "/chats", ChatController
  end

  scope alias: DivisionWeb.Matrix, as: :matrix do
    pipe_through [:api, :matrix]

    get "/.well-known/matrix/client", ServerDiscoveryController, :well_known

    scope "/_matrix" do
      scope "/client" do
	resources "/versions", VersionsController, only: [:index]

	scope "/r0" do
	  get "/login", SessionController, :show
	  post "/login", SessionController, :create
	  options "/login", LoginController, :options
	end
      end
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", DivisionWeb do
  #   pipe_through :api
  # end
end
