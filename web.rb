require 'sinatra'
# require 'pry'
load 'lib/uzz/score_parser.rb'

get '/' do
  Uzz::ScoreParser.parse
  # Uzz::ScoreParser.parse.gsub(/\n/, "<br>")
end

post '/' do
  # keyword = params["keyword"]
  # from = params["from"]
  # date = params["date"]
  Uzz::ScoreParser.parse
end
