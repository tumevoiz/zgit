defmodule Zgit.HostingTest do
  use Zgit.DataCase

  alias Zgit.Hosting

  describe "bucket" do
    alias Zgit.Hosting.Bucket

    import Zgit.HostingFixtures

    @invalid_attrs %{name: nil, description: nil, local_path: nil}

    test "list_bucket/0 returns all bucket" do
      bucket = bucket_fixture()
      assert Hosting.list_bucket() == [bucket]
    end

    test "get_bucket!/1 returns the bucket with given id" do
      bucket = bucket_fixture()
      assert Hosting.get_bucket!(bucket.id) == bucket
    end

    test "create_bucket/1 with valid data creates a bucket" do
      valid_attrs = %{name: "some name", description: "some description", local_path: "some local_path"}

      assert {:ok, %Bucket{} = bucket} = Hosting.create_bucket(valid_attrs)
      assert bucket.name == "some name"
      assert bucket.description == "some description"
      assert bucket.local_path == "some local_path"
    end

    test "create_bucket/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Hosting.create_bucket(@invalid_attrs)
    end

    test "update_bucket/2 with valid data updates the bucket" do
      bucket = bucket_fixture()
      update_attrs = %{name: "some updated name", description: "some updated description", local_path: "some updated local_path"}

      assert {:ok, %Bucket{} = bucket} = Hosting.update_bucket(bucket, update_attrs)
      assert bucket.name == "some updated name"
      assert bucket.description == "some updated description"
      assert bucket.local_path == "some updated local_path"
    end

    test "update_bucket/2 with invalid data returns error changeset" do
      bucket = bucket_fixture()
      assert {:error, %Ecto.Changeset{}} = Hosting.update_bucket(bucket, @invalid_attrs)
      assert bucket == Hosting.get_bucket!(bucket.id)
    end

    test "delete_bucket/1 deletes the bucket" do
      bucket = bucket_fixture()
      assert {:ok, %Bucket{}} = Hosting.delete_bucket(bucket)
      assert_raise Ecto.NoResultsError, fn -> Hosting.get_bucket!(bucket.id) end
    end

    test "change_bucket/1 returns a bucket changeset" do
      bucket = bucket_fixture()
      assert %Ecto.Changeset{} = Hosting.change_bucket(bucket)
    end
  end
end
