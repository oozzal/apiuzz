require 'sinatra'
require 'pry'
require_relative './lib/uzz'

get '/' do
  Uzz::ScoreParser.parse
  # Uncomment in Development
  # Uzz::ScoreParser.parse.gsub(/\n/, "<br>")
end

post '/' do
  # keyword = params["keyword"]
  # from = params["from"]
  # date = params["date"]
  Uzz::ScoreParser.parse
end
