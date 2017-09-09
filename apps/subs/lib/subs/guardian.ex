defmodule Subs.Guardian do
  use Guardian, otp_app: :subs

  def subject_for_token(resource, _claims), do: {:ok, to_string(resource.id)}
  def subject_for_token(_, _), do: {:error, :invalid_resource}
end
