require 'nokogiri'
require 'open-uri'

module Uzz
  class ScoreParser
    def self.parse(country = "England", type = "Premier League", date = "2014-04-27")
      url = "http://www.livescores.com/soccer/#{date}/"
      doc = Nokogiri::HTML(open(url));nil
      my_table = doc.css(".league-table:not(.mtn)").detect do |table|
        table.css(".league>a>strong").text == country && table.css(".league>span>a").text == type
      end

      final_string = ""

      if my_table
        my_table.css("tr>td").map(&:text).each_with_index do |txt, index|
          if index != 0 && index % 4 == 0
            final_string += "\n"
            txt = txt.strip
          end
          final_string += txt
        end
        final_string = final_string.strip.squeeze(" ")
      else
        final_string = "No match today"
      end
      final_string
    end
  end
end
