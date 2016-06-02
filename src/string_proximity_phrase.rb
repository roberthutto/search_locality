require 'strscan'

##
# String extension that adds a method for checking if two phrases are within the specified distance in the String
# defaults to distance=Float::INFINITY
#
class String
  ##
  # Calculates if the terms are in proximity of distance in words. Sweeps the string from left to right looking for an
  # occurrence of a search term and update the current word position. If both terms have been found the positions are
  # used to calculate distance
  def proximity?(search_phrase_1, search_phrase_2, distance = Float::INFINITY)
    scanner = StringScanner.new(self)
    word_regex = /\b[!"#$%&'()*+.:;<=>?@^`{|}~\w]+\b/
    position = { word_count: 0 }

    while words?(scanner, search_phrase_1, search_phrase_2, word_regex)

      update_position(position, scanner, search_phrase_1, search_phrase_2)

      return true if proximate(position[search_phrase_1], position[search_phrase_2], distance, search_phrase_1, search_phrase_2)
    end

    false
  end

  private

  ##
  # Updates the position if the current match is a search term to the current word count
  def update_position(position, scanner, search_phrase_1, search_phrase_2)
    matched = scanner.matched

    if matched.casecmp(search_phrase_1) == 0 || matched.casecmp(search_phrase_2) == 0
      position.store(scanner.matched.downcase, position[:word_count])
    end

    position[:word_count] += matched.split(' ').size
  end

  ##
  # Returns true if the scanner has more words and advances scanner to the next match
  def words?(scanner, search_phrase_1, search_phrase_2, word_regex)
    scanner.scan_until(/\b#{search_phrase_1}\b|\b#{search_phrase_2}\b|#{word_regex}/i)
  end

  ##
  # Test if the currently matched search terms are within the specified distance
  def proximate(p1, p2, distance, search_phrase_1, search_phrase_2)
    if p1 && p2

      # Short circuit if the both terms have been found and the distance is Infinity
      return true if distance.equal?(Float::INFINITY)

      word_distance = p1 < p2 ? p2 - (p1 + search_phrase_1.split(' ').size - 1) : p1 - (p2 + search_phrase_2.split(' ').size - 1)
      return word_distance <= distance
    end
    false
  end
end
