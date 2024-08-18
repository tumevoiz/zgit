defmodule Zgit.HostingFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Zgit.Hosting` context.
  """

  @doc """
  Generate a bucket.
  """
  def bucket_fixture(attrs \\ %{}) do
    {:ok, bucket} =
      attrs
      |> Enum.into(%{
        description: "some description",
        local_path: "some local_path",
        name: "some name"
      })
      |> Zgit.Hosting.create_bucket()

    bucket
  end
end
