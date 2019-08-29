defmodule Division.Repo do
  use Ecto.Repo,
    otp_app: :division,
    adapter: Ecto.Adapters.Postgres
end
