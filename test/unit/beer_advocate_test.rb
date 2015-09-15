require 'test_helper'
require 'json'

## Warning: these are live unit tests and are therefore janky and dubious

describe BeerAdvocate do
  describe '.get_url' do
    def assert_beeradvocate_url(name)
      url = BeerAdvocate.get_url(name)
      assert_match(%r{beeradvocate.com/beer/profile}, url)
    end

    it 'gets URLs for common beers' do
      assert_beeradvocate_url('sierra torpedo')
      assert_beeradvocate_url('troegs java head')
      assert_beeradvocate_url('lagunitas dogtown')
    end

    it 'returns nil for highly nonexistent beers' do
      assert_nil(BeerAdvocate.get_url("lasldfbgLKSG"))
    end

    it 'throws exceptions from .get_url! for highly nonexistent beers' do
      url = BeerAdvocate.get_url!('skasdfbihkjhasdf') rescue :no_way
      assert_equal(:no_way, url)
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

    it 'returns nil for crap pages' do
      assert_nil(BeerAdvocate.get_beer_details_from_url("8==D"))
    end

    it 'throw exceptions from .get_beer_details_from_url! for crap pages' do
      details = BeerAdvocate.get_beer_details_from_url!("SDFASDF") rescue :gah
      assert_equal(:gah, details)
    end

    it 'returns all correct information' do
      url = BeerAdvocate.get_url('cambridge porter')
      details = JSON.parse(JSON.dump(
        BeerAdvocate.get_beer_details_from_url(url)))
      correct_details = JSON.parse(<<-EOT)
        {
          "name": "Charles River Porter",
          "score": "89",
          "style": "American Porter",
          "abv": "5.90%",
          "brewery": "Cambridge Brewing Company"
        }
      EOT
      correct_details.keys.each do |k|
        assert_equal(correct_details[k], details[k], k)
      end
    end
  end
end

