defmodule Zgit.Hosting do
  @moduledoc """
  The Hosting context.
  """

  import Ecto.Query, warn: false
  alias Zgit.Repo

  alias Zgit.Hosting.Bucket

  @doc """
  Returns the list of bucket.

  ## Examples

      iex> list_bucket()
      [%Bucket{}, ...]

  """
  def list_bucket do
    Repo.all(Bucket)
  end

  @doc """
  Gets a single bucket.

  Raises `Ecto.NoResultsError` if the Bucket does not exist.

  ## Examples

      iex> get_bucket!(123)
      %Bucket{}

      iex> get_bucket!(456)
      ** (Ecto.NoResultsError)

  """
  def get_bucket!(id), do: Repo.get!(Bucket, id)

  @doc """
  Creates a bucket.

  ## Examples

      iex> create_bucket(%{field: value})
      {:ok, %Bucket{}}

      iex> create_bucket(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_bucket(attrs \\ %{}) do
    %Bucket{}
    |> Bucket.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a bucket.

  ## Examples

      iex> update_bucket(bucket, %{field: new_value})
      {:ok, %Bucket{}}

      iex> update_bucket(bucket, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_bucket(%Bucket{} = bucket, attrs) do
    bucket
    |> Bucket.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a bucket.

  ## Examples

      iex> delete_bucket(bucket)
      {:ok, %Bucket{}}

      iex> delete_bucket(bucket)
      {:error, %Ecto.Changeset{}}

  """
  def delete_bucket(%Bucket{} = bucket) do
    Repo.delete(bucket)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking bucket changes.

  ## Examples

      iex> change_bucket(bucket)
      %Ecto.Changeset{data: %Bucket{}}

  """
  def change_bucket(%Bucket{} = bucket, attrs \\ %{}) do
    Bucket.changeset(bucket, attrs)
  end
end
