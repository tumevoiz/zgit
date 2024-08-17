defmodule Zgit.Repo do
  use Ecto.Repo,
    otp_app: :zgit,
    adapter: Ecto.Adapters.Postgres
end
