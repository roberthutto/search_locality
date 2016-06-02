# search-locality
Tool used to recursively search a provided directory for *.txt files that contain two search terms/phrases within a specified word distance. #Defaults to Infinity (File contains both terms)

# Usage
Requires ruby.

	$ ./search_locality.rb -h
	Usage: ./search_locality.rb [options]
        -d, --dir DIRECTORY              Directory to search for *.txt
            --distance [DISTANCE]        Distance integer > 0 (default Infinity)
        -s, --search-terms x,y           Comma Separated list of Search Terms "Continuous Delivery","Dr. Fowler"
    
    $ ./search_locality.rb -d <directory> --search-terms <phrase1>,<phrase2> --distance <distance>
        
    


**Example**

	Terms
	$ ./search_locality.rb -d test/sampledata/ --search-terms  term1,term2
	test/sampledata/terms/terms_within_3.txt
    test/sampledata/terms/terms_within_3_punctuation_newline.txt
    test/sampledata/terms/terms_within_3_reverse.txt

	
	Phrases
	$ ./search_locality.rb -d test/sampledata/ --search-terms  "phrase 1","phrase 2"
	test/sampledata/phrase_with_newline.txt
    test/sampledata/phrases_within_3.txt


# Test

**Test Requirements**

- Minitest ``gem install minitest``


**Execute Tests**

	cd test/
	ruby string_proximity_test.rb