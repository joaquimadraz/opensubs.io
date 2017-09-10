defmodule Notifier.Email do
  import Bamboo.Email

  @from_email "no_reply@example.com"

  def confirmation_email(to_email, %{confirmation_url: confirmation_url}) do
    subject = "Welcome to Subs, please confirm you account"
    body = """
    Welcome to Subs,

    Please click on this link to confirm you account:
    #{confirmation_url}


    Thanks!
    """

    new_email()
    |> to(to_email)
    |> from(@from_email)
    |> subject(subject)
    |> text_body(body)
  end
end
