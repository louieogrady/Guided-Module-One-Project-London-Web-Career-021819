require_relative '../config/environment'
require_relative "../lib/tty-prompt"

# wrapper = Discogs::Wrapper.new("My test app")
# auth_wrapper = Discogs::Wrapper.new("My awesome web app", user_token: "my_user_token")

new_cli = CommandLineInterface.new

new_cli.run

#prompt = TTY::Prompt.new
