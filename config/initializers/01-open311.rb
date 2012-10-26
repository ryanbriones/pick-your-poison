if ENV["OPEN311_API_KEY"].nil? || ENV["OPEN311_API_KEY"] == ""
  abort "You must provide an OPEN311_API_KEY"
end