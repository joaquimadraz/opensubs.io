defmodule SubsWeb.Helpers.AuthAccessPipeline do
  use Guardian.Plug.Pipeline, otp_app: :subs_web

  plug Guardian.Plug.VerifyHeader, claims: %{"typ" => "access"}
  plug Guardian.Plug.EnsureAuthenticated, realm: "Bearer"
  plug Guardian.Plug.LoadResource, ensure: true
end
