defmodule SubsWeb.Guardian do
  use Guardian, otp_app: :subs_web
  alias Subs.UseCases.Users.FindUser

  def subject_for_token(resource, _claims), do: {:ok, to_string(resource.id)}
  def subject_for_token(_, _), do: {:error, :invalid_resource}

  def resource_from_claims(%{"sub" => user_id}) do
    case FindUser.perform(user_id) do
      {:ok, %{user: user}} -> {:ok, user}
      _ -> nil
    end
  end
  def resource_from_claims(_claims) do
    {:error, :invalid_resource}
  end
end
