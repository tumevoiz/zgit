defmodule ZgitWeb.BucketLive.Show do
  use ZgitWeb, :live_view

  alias Zgit.Hosting

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:bucket, Hosting.get_bucket!(id))}
  end

  defp page_title(:show), do: "Show Bucket"
  defp page_title(:edit), do: "Edit Bucket"
end
