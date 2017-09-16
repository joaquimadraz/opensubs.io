defmodule SubsWeb.Guardian do
  use Guardian, otp_app: :subs_web
  alias Subs.UseCases.Users.FindUser

  def subject_for_token(resource, _claims), do: {:ok, to_string(resource.id)}

  def resource_from_claims(%{"sub" => sub}) do
    with {user_id, _} <- Integer.parse(sub),
         {:ok, %{user: user}} <-  FindUser.perform(user_id) do
      {:ok, user}
    else
      _ -> nil
    end
  end
  def resource_from_claims(_claims) do
    {:error, :invalid_resource}
  end
end
