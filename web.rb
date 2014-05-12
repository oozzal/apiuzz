require 'sinatra'
require 'pry'
require_relative './lib/uzz'

get '/' do
  Uzz::ScoreParser.parse
  # Uncomment in Development
  # Uzz::ScoreParser.parse.gsub(/\n/, "<br>")
end

post '/' do
  # from = $_GET["from"] // the sms sender
  # keyword = $_GET["keyword"] // first word
  # text = $_GET["text"] // the word(s) after the first word
  Uzz::ScoreParser.parse
end
