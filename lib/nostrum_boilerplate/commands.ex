defmodule NostrumBoilerplate.Commands do
  @doc """
  Handling and routing for commands and interactions.
  """

  # Add your commands here. The command name will be passed as an argument to
  # your command's `spec/1` function, so you can see all of the command names
  # here and ensure they don't collide.
  @commands %{
    "ping" => NostrumBoilerplate.Commands.Ping,
    "greet" => NostrumBoilerplate.Commands.Greet
  }

  @command_names for {name, _} <- @commands, do: name

  def register_commands() do
    commands = for {name, command} <- @commands, do: command.spec(name)

    # Global application commands take a couple of minutes to update in Discord,
    # so we use a test guild when in dev mode.
    if Application.get_env(:nostrum_boilerplate, :env) == :dev do
      guild_id = Application.get_env(:nostrum_boilerplate, :dev_guild_id)
      Nostrum.Api.bulk_overwrite_guild_application_commands(guild_id, commands)
    else
      Nostrum.Api.bulk_overwrite_global_application_commands(commands)
    end
  end

  def handle_interaction(interaction) do
    if interaction.data.name in @command_names do
      @commands[interaction.data.name].handle_interaction(interaction)
    else
      :ok
    end
  end
end
