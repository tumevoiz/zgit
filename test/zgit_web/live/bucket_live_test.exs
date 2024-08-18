defmodule ZgitWeb.BucketLiveTest do
  use ZgitWeb.ConnCase

  import Phoenix.LiveViewTest
  import Zgit.HostingFixtures

  @create_attrs %{name: "some name", description: "some description", local_path: "some local_path"}
  @update_attrs %{name: "some updated name", description: "some updated description", local_path: "some updated local_path"}
  @invalid_attrs %{name: nil, description: nil, local_path: nil}

  defp create_bucket(_) do
    bucket = bucket_fixture()
    %{bucket: bucket}
  end

  describe "Index" do
    setup [:create_bucket]

    test "lists all bucket", %{conn: conn, bucket: bucket} do
      {:ok, _index_live, html} = live(conn, ~p"/bucket")

      assert html =~ "Listing Bucket"
      assert html =~ bucket.name
    end

    test "saves new bucket", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/bucket")

      assert index_live |> element("a", "New Bucket") |> render_click() =~
               "New Bucket"

      assert_patch(index_live, ~p"/bucket/new")

      assert index_live
             |> form("#bucket-form", bucket: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#bucket-form", bucket: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/bucket")

      html = render(index_live)
      assert html =~ "Bucket created successfully"
      assert html =~ "some name"
    end

    test "updates bucket in listing", %{conn: conn, bucket: bucket} do
      {:ok, index_live, _html} = live(conn, ~p"/bucket")

      assert index_live |> element("#bucket-#{bucket.id} a", "Edit") |> render_click() =~
               "Edit Bucket"

      assert_patch(index_live, ~p"/bucket/#{bucket}/edit")

      assert index_live
             |> form("#bucket-form", bucket: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#bucket-form", bucket: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/bucket")

      html = render(index_live)
      assert html =~ "Bucket updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes bucket in listing", %{conn: conn, bucket: bucket} do
      {:ok, index_live, _html} = live(conn, ~p"/bucket")

      assert index_live |> element("#bucket-#{bucket.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#bucket-#{bucket.id}")
    end
  end

  describe "Show" do
    setup [:create_bucket]

    test "displays bucket", %{conn: conn, bucket: bucket} do
      {:ok, _show_live, html} = live(conn, ~p"/bucket/#{bucket}")

      assert html =~ "Show Bucket"
      assert html =~ bucket.name
    end

    test "updates bucket within modal", %{conn: conn, bucket: bucket} do
      {:ok, show_live, _html} = live(conn, ~p"/bucket/#{bucket}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Bucket"

      assert_patch(show_live, ~p"/bucket/#{bucket}/show/edit")

      assert show_live
             |> form("#bucket-form", bucket: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#bucket-form", bucket: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/bucket/#{bucket}")

      html = render(show_live)
      assert html =~ "Bucket updated successfully"
      assert html =~ "some updated name"
    end
  end
end
