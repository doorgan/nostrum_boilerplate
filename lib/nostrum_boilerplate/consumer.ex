defmodule NostrumBoilerplate.Consumer do
  @moduledoc false
  use Nostrum.Consumer

  alias NostrumBoilerplate.Commands

  def start_link do
    Consumer.start_link(__MODULE__)
  end

  def handle_event({:READY, _data, _ws_state}) do
    Commands.register_commands()
  end

  def handle_event({:INTERACTION_CREATE, interaction, _ws_state}) do
    Commands.handle_interaction(interaction)
  end

  def handle_event(_data) do
    :ok
  end
end
