class MissionControl::Console::Commands::Browser
  def chrome(url)
    "open -g \"/Applications/Google Chrome.app\" '#{url}'"
  end
end