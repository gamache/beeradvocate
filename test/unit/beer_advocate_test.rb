require 'test_helper'

## Warning: these are live unit tests and are therefore janky and dubious

describe BeerAdvocate do
  describe '.get_url' do
    def assert_beeradvocate_url(name)
      url = BeerAdvocate.get_url(name)
      assert_match(%r{}, url)
    end

    it 'gets URLs for common beers' do
      assert_beeradvocate_url('sierra torpedo')
      assert_beeradvocate_url('troegs java head')
      assert_beeradvocate_url('lagunitas dogtown')
    end
  end

  describe '.get_beer_details_from_url' do
    def assert_beer_details(name)
      url = BeerAdvocate.get_url(name)
      details = BeerAdvocate.get_beer_details_from_url(url)
      refute_empty(details[:name])
      refute_empty(details[:score])
      refute_empty(details[:style])
      refute_empty(details[:abv])
      refute_empty(details[:brewery])
    end

    it 'parses beer pages' do
      assert_beer_details('sierra torpedo')
      assert_beer_details('troegs java head')
      assert_beer_details('lagunitas dogtown')
    end
  end
end

