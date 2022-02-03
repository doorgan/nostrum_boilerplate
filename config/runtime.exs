import Config

if Config.config_env() == :dev do
  DotenvParser.load_file(".env")
end

config :nostrum,
  token: System.get_env("DISCORD_BOT_TOKEN")

config :nostrum_boilerplate,
  env: Config.config_env(),
  dev_guild_id: System.get_env("DEV_GUILD_ID")
