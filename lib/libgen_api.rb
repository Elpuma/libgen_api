require "libgen_api/version"

require "json"

require 'httparty'
require 'nokogiri'

module LibgenApi
    class Error < StandardError; end

    @mirror = 'libgen.is'

    # Results are in the same order as search results.
    def self.get_ids(page)
        books = []

        table = page.search('table')[2]
        table.search('tbody').each do |tb|
            tb.search('tr').each do |tr|

                # Here we check to see if the name of th current text element is "ID:"
                # and then move onto to the next element in the loop which contains the id.
                found_id = false
                tr.search('td').each do |td|
                    if found_id
                        books.push(td.text)
                        break
                    end

                    if td.text == "ID:"
                        found_id = true
                    end
                end
            end
        end

        books
    end

    def self.get_mirror
        @mirror
    end

    def self.change_mirror(new_mirror)
        @mirror = new_mirror
    end

    def self.search(query, res, column)
        raise "query must be at least four characters long!" if query.length() < 4

        if res != 25 && res != 50 && res != 100
            raise "res must equal either 25, 50 or 100"
        end
        
        id_collection = []
        page = 1
        loop do
            url = "http://#{@mirror}/search.php?req=#{query}&lg_topic=libgen&open=0&view=detailed&res=#{res}&column=#{column}&page=#{page}"
            response = HTTParty.get(url)

            doc = Nokogiri::HTML(response.body)
            page_ids = get_ids(doc)

            id_collection = id_collection + page_ids

            if page_ids.length() != res
                break
            end

            page += 1
        end

        id_collection
    end

    def self.get_book(id, fields=["Title", "Author", "MD5"])
        fields = fields.join(',')

        res = HTTParty.get("http://#{@mirror}/json.php?ids=#{id}&fields=#{fields}")

        begin
            JSON.parse(res.body)[0]
        rescue JSON::ParserError, TypeError => e
            raise "An error has occured when parsing the JSON recieved. The error is:\n#{e}"
        end
    end

    def self.get_books(ids, fields=["Title", "Author", "MD5"])
        ids = ids.map(&:to_s).join(',')
        fields = fields.join(',')

        res = HTTParty.get("http://#{@mirror}/json.php?ids=#{ids}&fields=#{fields}")

        begin
            JSON.parse(res.body)
        rescue JSON::ParserError, TypeError => e
            raise "An error has occured when parsing the JSON recieved. The error is:\n#{e}"
        end
    end

end