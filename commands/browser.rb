class MissionControl::Console::Commands::Browser
  def chrome(url)
    "open -a \"/Applications/Google Chrome.app\" '#{url}'"
  end
end