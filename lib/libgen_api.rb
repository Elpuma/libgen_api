require "libgen_api/version"

module LibgenApi
    class Error < StandardError; end

    @mirror = "https://libgen.is/"

    def change_mirror(new_mirror)
        @mirror = new_mirror
    end

    def search(query, db)

        raise "query must be atleast four characters long" if query.length() < 4
        # Important view detailed so that we get the ID's
        url = "http://#{@mirror}/search.php?req=#{query}&lg_topic=libgen&open=0&view=detailed&res=25&column=def"

        
    end
    # Your code goes here...
end
