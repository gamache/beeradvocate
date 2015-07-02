# beeradvocate

A BeerAdvocate.com scraper of debatable quality.  Written in Ruby.

## Installation

`gem install beeradvocate`

## Overview

The `beeradvocate` gem implements several useful functions for scraping
beer information from [the Beer Advocate website](http://beeradvocate.com).

`BeerAdvocate.get_url(beer_name)`, given the name of a beer or something
like it, will return the first Beer Advocate beer search result.

`BeerAdvocate.get_beer_details_from_url(url)`, given a Beer Advocate
beer page URL (as returned from `.get_url`), will return a hash of beer
attributes `name`, `score`, `style`, `abv`, and `brewery`.

The `beer` command-line tool combines these two features.  Given the
name of a beer on the command line, `beer` will return a JSON-formatted
hash of beer details:

```bash
$ beer cambridge porter
{
  "name": "Charles River Porter",
  "score": "88",
  "style": "American Porter",
  "abv": "5.90%",
  "brewery": "Cambridge Brewing Company"
}
```

## Bugs

Very probable.

## Authorship and License

Pete Gamache wrote this in haste in July 2015.

This project is not developed or endorsed by [Beer Advocate](
http://www.beeradvocate.com/).

This code is released into the public domain.

