require 'sinatra'
require_relative './lib/uzz'

class App < Sinatra::Base
  get '/' do
    params[:view] == "clean" ? Uzz::ScoreParser.parse.gsub(/\n/, "<br><br>") : Uzz::ScoreParser.parse
  end

  post '/' do
    # from = $_GET["from"] // the sms sender
    # keyword = $_GET["keyword"] // first word
    # text = $_GET["text"] // the word(s) after the first word
    Uzz::ScoreParser.parse
  end
end

