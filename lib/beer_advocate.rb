require 'nokogiri'
require 'mechanize'
require 'open-uri'

require 'beer_advocate/version'

## A handful of utilities for making beer signs based on Beer Advocate data.
module BeerAdvocate
  class << self

    ## Given a beer name, return the URL for the top Google search result for
    ## `site:beeradvocate.com beer name`.
    def get_url(beer_name)
      agent = Mechanize.new
      page = agent.get('http://www.google.com')
      form = page.form('f')
      form.q = "site:beeradvocate.com #{beer_name}"

      results = agent.submit(form, form.buttons.first)

      urls = []
      results.links.each do |link|
        if link.href.to_s =~/url.q/
            str=link.href.to_s
            strList=str.split(%r{=|&})
            urls << strList[1]
        end
      end
      urls.select {|url| url.match(/beeradvocate.com/)}.first
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

