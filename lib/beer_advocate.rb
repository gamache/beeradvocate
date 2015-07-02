require 'nokogiri'
require 'open-uri'
require 'uri'

require 'beer_advocate/version'

## Quickly-coded utilities for scraping BeerAdvocate.com for beer information.
module BeerAdvocate
  class << self

    ## Given a beer name, return the URL for the top Beer Advocate beer
    ## search result.
    def get_url(beer_name)
      page = Nokogiri::HTML(open(
        "http://www.beeradvocate.com/search/?qt=beer&q=" +
        URI.escape(beer_name)
      ))

      "http://www.beeradvocate.com" +
        page.css('ul li a').first.attributes['href'].text
    end


    ## Given a URL for a Beer Advocate beer page, return a hash containing
    ## info about the beer, including `name`, `brewery`, `style`, `abv`,
    ## and `score`.
    def get_beer_details_from_url(url)
      page = Nokogiri::HTML(open(url))

      table = page.css('#ba-content table')[1]

      beer_name = table.css('img')[0].attributes['alt'].value

      beer_score = table.css('.ba-score').text

      beer_style = table.css('a').
        select {|tag| tag.attributes['href'].value.match(%r{^/beer/style/\d+/?$}) }.
        map {|tag| tag.text}.
        first

      beer_brewery = table.css('a').
        select {|tag| tag.attributes['href'].value.match(%r{^/beer/profile/\d+/?$}) }.
        map {|tag| tag.text}.
        first

      m = table.to_s.match(/ \| [^\d]{0,9} (\d+ \. \d+ \%) /x)
      beer_abv = m[1]

      {
        name: beer_name,
        score: beer_score,
        style: beer_style,
        abv: beer_abv,
        brewery: beer_brewery
      }
    end

  end
end

