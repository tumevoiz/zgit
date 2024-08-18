defmodule ZgitWeb.BucketLive.FormComponent do
  use ZgitWeb, :live_component

  alias Zgit.Hosting

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage bucket records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="bucket-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:description]} type="text" label="Description" />
        <.input field={@form[:local_path]} type="text" label="Local path" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Bucket</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{bucket: bucket} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Hosting.change_bucket(bucket))
     end)}
  end

  @impl true
  def handle_event("validate", %{"bucket" => bucket_params}, socket) do
    changeset = Hosting.change_bucket(socket.assigns.bucket, bucket_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"bucket" => bucket_params}, socket) do
    save_bucket(socket, socket.assigns.action, bucket_params)
  end

  defp save_bucket(socket, :edit, bucket_params) do
    case Hosting.update_bucket(socket.assigns.bucket, bucket_params) do
      {:ok, bucket} ->
        notify_parent({:saved, bucket})

        {:noreply,
         socket
         |> put_flash(:info, "Bucket updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_bucket(socket, :new, bucket_params) do
    case Hosting.create_bucket(bucket_params) do
      {:ok, bucket} ->
        notify_parent({:saved, bucket})

        {:noreply,
         socket
         |> put_flash(:info, "Bucket created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
