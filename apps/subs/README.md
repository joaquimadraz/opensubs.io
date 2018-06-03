# Subs (Core)

The architecture is heavily influenced by [Uncle Bob’s Clean Code Architecture](https://8thlight.com/blog/uncle-bob/2012/08/13/the-clean-architecture.html) (CCA), but I would suggest not to think about it. 
What I’ve tried to do was to make it easy to answer the question “Where does this code live?”.

Having that in mind, I’ll start by breaking down the folders inside `apps/subs/lib/subs`:

### Domain
When you think about the domain, you think about the different Entities your app has. The CCA states that Entities “encapsulate Enterprise-wide business rules”. 
For me, this goes from _What’s a valid subscription?_, _Is this user confirmed?_, _Was this notification sent?_ To _What are the active subscriptions from this User?_.

So on the `domain` folder, you’ll find Ecto Schemas and Repos. 
- Schemas are the `Entities` in the CCA. These are our business objects: `User`, `Subscription`, `SubsNotification`. Say we need to know if a particular user already confirmed his/her account, this is where we put that code.
- Repos is our data access layer. If at any point we need to access the database, this is where the query lives. This allows us to get rid of queries scattered around the code and to have an explicit API for DB actions. 
Repos also have the advantage of being easy to mock. At some point, I was mocking all Repos on Use Cases when writing unit tests, but I’ve realized it was too much. 

### Outbound
The outbound layer is the more straightforward one. This is where all the code that talks to the outside world live. If we need to create a wrapper around some external API, here’s where the wrapper should live.

For instance, in `opensubs.io` we are using SengGrid to send emails and the `Email` module abstract us from that. Later I’ve decided to extract all the notifications logic to a separated component called `Notifier`, but for the internal logic, nothing changed. 

### Application
This one is a bit more complicated to explain, and the name does not help as well. This is where “calculations” type of code live. Say we need to parse an Excel file and transform it into someone our app knows, that’s the type of logic I put in this layer. 

For example, in `opensubs.io` there’s some logic to [filter subscriptions by month](https://github.com/joaquimadraz/opensubs.io/blob/master/apps/subs/lib/subs/application/subscriptions_by_month.ex). It gets a bunch of subscriptions, a month and a year and based on the subscription’s configuration (`cycle` and `first_bill_date`) it calculates if the subscription appears in that month or not.

It’s not domain but knows about the domain, it’s not business logic but is used by the business logic.

### Helpers
This one is easier to explain with examples. In `opensubs.io` here lives the [Money](https://github.com/joaquimadraz/opensubs.io/blob/master/apps/subs/lib/subs/helpers/money.ex) module. It lists all the available currencies and has other functions to format the way money values are shown in the app.

Here also lives the [DT](https://github.com/joaquimadraz/opensubs.io/blob/master/apps/subs/lib/subs/helpers/dt.ex) module which encapsulates all logic around dates. Extracting all date related logic to this module allowed me to Mock the current date easily. 

### Use Cases
Use Cases (also known as Interactors) encapsulate the apps business logic and, in a nutshell, it represents actions the app does. Looking at `opensubs.io` use cases, we can see what the app does. The app allows us to _Create users_, _Authenticate Users_, _Create subscriptions_, _Get all subscriptions from a user_…

I like to see the Use Case as the entity that orchestrates a particular action. Even though It knows about the other layers of the app, it only delegates work.

Let’s grab the `CheckRecoveryToken` Use Case implementation as example:

```Elixir
defmodule Subs.UseCases.Passwords.CheckRecoveryToken do
  @moduledoc false

  use Subs.UseCase
  alias Subs.{User, UserRepo}

  def perform(token) do
    with {:ok, user} <- find_user_by_password_recovery_token(token),
         :ok <- user_token_valid?(user) do
      ok!(%{user: user})
    else
      {:error, :token_expired} ->  failure!(:token_expired)
      _ -> failure!(:invalid_token)
    end
  end

  defp find_user_by_password_recovery_token(token) do
    case UserRepo.get_by_password_recovery_token(token) do
      nil -> {:error, :invalid_token}
      user -> {:ok, user}
    end
  end

  defp user_token_valid?(user) do
    if User.reset_password?(user),
      do: :ok,
      else: {:error, :token_expired}
  end
end
```

To check the validity of a recovery token, we need to find the user by the token and check if the token is valid. Even though the use case is not responsible to know that information, it knows who to ask for that information. `UserRepo` is the one responsible for hitting the database to get the user and the `User` Entity is responsible for knowing if the user's recovery token is valid. 

For me, this is the biggest utility of the use cases. We can isolate particular logic and then have a general entity that orchestrates that logic and transforms it into something your applications does.

Most of the Use Cases could be a method in a module (Like Phoenix Contexts) but having it in a single file allows me to add more logic to it if necessary.

Envato wrote a piece about Use Cases that resonates with me - [A Case for Use Cases](https://webuild.envato.com/blog/a-case-for-use-cases/).
