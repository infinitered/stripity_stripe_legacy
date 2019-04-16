defmodule Stripe.Plan do
  @moduledoc """
  Work with Stripe plan objects.

  You can:

  - Create a plan
  - Retrieve a plan
  - Update a plan
  - Delete a plan

  Does not yet render lists or take options.

  Stripe API reference: https://stripe.com/docs/api#plan
  """

  @type t :: %__MODULE__{}

  defstruct [
    :id, :object,
    :amount, :created, :currency, :interval, :interval_count,
    :livemode, :metadata, :name, :statement_descriptor, :trial_period_days
  ]

  @plural_endpoint "plans"

  @schema %{
    amount: [:create, :retrieve],
    created: [:retrieve],
    currency: [:create, :retrieve],
    id: [:create, :retrieve],
    interval: [:create, :retrieve],
    interval_count: [:create, :retrieve],
    livemode: [:retrieve],
    metadata: [:create, :retrieve, :update],
    name: [:create, :retrieve, :update],
    object: [:retrieve],
    statement_descriptor: [:create, :retrieve, :update],
    trial_period_days: [:create, :retrieve, :update]
  }

  @nullable_keys [
    :metadata, :statement_descriptor
  ]

  @doc """
  Create a plan.
  """
  @spec create(map, Keyword.t) :: {:ok, t} | {:error, Stripe.api_error_struct}
  def create(changes, opts \\ []) do
    Stripe.Request.create(@plural_endpoint, changes, @schema, opts)
  end

  @doc """
  Retrieve a plan.
  """
  @spec retrieve(binary, Keyword.t) :: {:ok, t} | {:error, Stripe.api_error_struct}
  def retrieve(id, opts \\ []) do
    endpoint = @plural_endpoint <> "/" <> id
    Stripe.Request.retrieve(endpoint, opts)
  end

  @doc """
  Update a plan.

  Takes the `id` and a map of changes.
  """
  @spec update(binary, map, list) :: {:ok, t} | {:error, Stripe.api_error_struct}
  def update(id, changes, opts \\ []) do
    endpoint = @plural_endpoint <> "/" <> id
    Stripe.Request.update(endpoint, changes, @schema, @nullable_keys, opts)
  end

  @doc """
  Delete a plan.
  """
  @spec delete(binary, list) :: :ok | {:error, Stripe.api_error_struct}
  def delete(id, opts \\ []) do
    endpoint = @plural_endpoint <> "/" <> id
    Stripe.Request.delete(endpoint, %{}, opts)
  end

  @doc """
  List all plans.
  """
  @spec list(map, Keyword.t) :: {:ok, Stripe.List.t} | {:error, Stripe.api_error_struct}
  def list(params \\ %{}, opts \\ []) do
    endpoint = @plural_endpoint
    Stripe.Request.retrieve(params, endpoint, opts)
  end
end
