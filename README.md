# LibgenApi

Welcome to the `libgen_api` gem!

This gem allows you to search library genesis easily and relatively quicky.

## Advice

The Library Genesis maintainers run the library for free through donations. 
Please don't overload their servers.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'libgen_api'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install libgen_api

## Usage
### Searching the site
The main search method is called `search()` and has three options.

The first is `query` and is set to the value of the search you want to make.
The second is `res` and is set to the amount of results you want to recieve per page. The values you can give here are 10, 25 or 100.
The final option is `column` and is which column you want to search. The values this can have are `def`(if unsure use this one), `title`, `author`, `series`, `publisher`, `year`, `identifier`, `language`, `md5`, `tags` and `extension`.

This method will return in order the id's of the books shown in your search results.

### Retrieving books
Books can be retrieved using their ids.

The method `get_book()` can be used to retrieve an individual books information where as the method `get_books()` can be used to retrieve multiple books.
`get_book()` has two parameters, `id` and `fields`. `id` is any books id number whilst `fields` contains an array of which fields you are interested in looking at. A list of fields can be found [here](http://garbage.world/posts/libgen/) and [here](https://forum.mhut.org/viewtopic.php?f=17&t=6874). By default the `title`, `author` and `md5` fields are requested. It returns a hash with each selected field being a key that can be used to access its value.

`get_books()` works basically the same excepts its first argument is `ids` which accepts an array of ids. It returns an array of hashes for each book requested.

Both methods only make one http request, so don't be shy about requesting multiple books at once.

### Changing site
By default requests go to `libgen.is`. To change this call the method `change_mirror()` with the string of the new mirror site. 
To check what mirror is currently being used call `get_mirror()`

### Example
```ruby
require 'libgen_api'

# Change the mirror, this is not necessary.
LibgenApi.change_mirror("gen.lib.rus.ec")

# Search for books using the search term "dodo" with results per page 100 and default column settings.
# This is the potentially time consuming part, each page needs to be downloaded and parsed. 
# If your search term has a lot of results this can take a while.
ids = LibgenApi.search("dodo", 100, "def")

# Now we grab the books information, specifically their title and author/s.
# This is quick, it only takes one request from the JSON api.
books = LibgenApi.get_books(ids, ["title", "author"])

# Now print their title and author/s! 
books.each do |book|
    puts "Title: #{book['title']}\nAuthor: #{book['author']}\n\n"
end

```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Sag0Sag0/libgen_api.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Thanks

I'd like to thank the creators of [libgen.js](https://github.com/dunn/libgen.js/) and the author of [this](http://garbage.world/posts/libgen/) and of course the creators and maintainters of Library Genesis. They were all very helpfull in creating this gem.
