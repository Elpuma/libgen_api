require "test_helper"
require 'libgen_api'

class DmpTest < Minitest::Test
    def test_that_it_has_a_version_number
        refute_nil ::LibgenApi::VERSION
    end
    
    def test_change_mirror
        LibgenApi.change_mirror('dodo')
        assert LibgenApi.get_mirror == 'dodo'
        LibgenApi.change_mirror('libgen.is')
    end

    def test_basic_search
        @@dodo_results = LibgenApi.search('dodo', 25, 'def')
    end

    def test_get_book
        res = LibgenApi.get_book(663430, 
        ['id', 'title', 'author', 'year', 'pages', 'language', 'identifier', 'openlibraryid', 'scanned', 'md5'])

        assert_equal res['id'], '663430'
        assert_equal res['title'], 'The Valleys of the Assassins, and Other Persian Travels'
        assert_equal res['author'], 'Freya Stark'
        assert_equal res['year'], '2001'
        assert_equal res['pages'], '426'
        assert_equal res['language'], 'English '
        assert_equal res['identifier'], '0375757538,9780375757532'
        assert_equal res['openlibraryid'], 'OL7427474M'
        assert_equal res['scanned'], '1'
        assert_equal res['md5'], 'C6B52B8CC494223B48580FEBFAFA6714'
    end

    def test_get_books
        res = LibgenApi.get_books([663430, 358721],
        ['id', 'title', 'author', 'year', 'pages', 'language', 'identifier', 'openlibraryid', 'scanned', 'md5'])

        assert_equal res[0]['id'], '663430'
        assert_equal res[0]['title'], 'The Valleys of the Assassins, and Other Persian Travels'
        assert_equal res[0]['author'], 'Freya Stark'
        assert_equal res[0]['year'], '2001'
        assert_equal res[0]['pages'], '426'
        assert_equal res[0]['language'], 'English '
        assert_equal res[0]['identifier'], '0375757538,9780375757532'
        assert_equal res[0]['openlibraryid'], 'OL7427474M'
        assert_equal res[0]['scanned'], '1'
        assert_equal res[0]['md5'], 'C6B52B8CC494223B48580FEBFAFA6714'

        assert_equal res[1]['id'], '358721'
        assert_equal res[1]['title'], 'The Communist Hypothesis '
        assert_equal res[1]['author'], 'Alain Badiou'
        assert_equal res[1]['year'], '2010'
        assert_equal res[1]['pages'], '143'
        assert_equal res[1]['language'], 'English'
        assert_equal res[1]['identifier'], '1844676005,9781844676002'
        assert_equal res[1]['openlibraryid'], 'OL24525060M'
        assert_equal res[1]['scanned'], ''
        assert_equal res[1]['md5'], 'FB689A77A7E6EB754075C9793A80957C'
    end
end