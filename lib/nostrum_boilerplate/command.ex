defmodule NostrumBoilerplate.Command do
  @moduledoc """
  Behaviour for application command implementations.
  """

  alias Nostrum.Struct.Interaction

  @doc """
  Used to define the spec for the command to be used for command registration.
  See https://hexdocs.pm/nostrum/application-commands.html for more info on the
  required shape for the spec.
  """
  @callback spec(name :: String.t()) :: map()

  @doc """
  Called when the command is invoked.
  """
  @callback handle_interaction(Interaction.t()) :: any()

  @doc """
  Gets an option by it's name from the interaction. Returns `nil` if the
  option is not present in the interaction.
  """
  @spec get_option(Interaction.t(), String.t()) ::
          Nostrum.Struct.ApplicationCommandInteractionData.options() | nil
  def get_option(interaction, name),
    do: Enum.find(interaction.data.options || [], fn %{name: n} -> n == name end)
end
