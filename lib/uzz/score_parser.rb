require "nokogiri"
require "open-uri"
require_relative "./util"

module Uzz
  class ScoreParser
    def self.parse(country = "England", type = "Premier League", date = "")
      url = "http://www.livescores.com/soccer/#{date}/"
      doc = Nokogiri::HTML(open(url))
      my_table = doc.css(".league-table:not(.mtn)").detect do |table|
        table.css(".league>a>strong").text == country && table.css(".league>span>a").text == type
      end

      final_string = ""

      if my_table
        my_table.css("tr>td").each_with_index do |e, index|
          txt = e.text.strip.squeeze(" ")
          txt = Uzz::Util::CLUBS_INFO[txt] if Uzz::Util::CLUBS_CLASSES.include?(e.attributes["class"].value)
          final_string += txt
          if index != 0 && (index+1) % 4 == 0
            final_string += "\n"
          else
            final_string += " "
          end
        end
      else
        final_string = "No match today"
      end
      final_string
    end
  end
end
