defmodule ZgitWeb.BucketLive.Index do
  use ZgitWeb, :live_view

  alias Zgit.Hosting
  alias Zgit.Hosting.Bucket

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :bucket_collection, Hosting.list_bucket())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Bucket")
    |> assign(:bucket, Hosting.get_bucket!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Bucket")
    |> assign(:bucket, %Bucket{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Bucket")
    |> assign(:bucket, nil)
  end

  @impl true
  def handle_info({ZgitWeb.BucketLive.FormComponent, {:saved, bucket}}, socket) do
    {:noreply, stream_insert(socket, :bucket_collection, bucket)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    bucket = Hosting.get_bucket!(id)
    {:ok, _} = Hosting.delete_bucket(bucket)

    {:noreply, stream_delete(socket, :bucket_collection, bucket)}
  end
end
