#!/usr/bin/env ruby -w

require 'optparse'
require_relative 'src/string_proximity_phrase'

options = {distance: Float::INFINITY}

## Builds the options parser
optparse = OptionParser.new do |opts|

  opts.banner = "Usage: #{$PROGRAM_NAME} [options]"

  opts.on('-d', '--dir DIRECTORY', 'Directory to search for *.txt') do |dir|
    raise(OptionParser::InvalidArgument, "#{dir} Usage: The directory does not exist") if !Dir.exist?(dir)
    options[:dir] = dir
  end

  opts.on('--distance [DISTANCE]', Integer, "Distance integer > 0 (default #{options[:distance]})") do |dist|
    raise(OptionParser::InvalidArgument, "#{dist} Usage: must be integer > 0") if dist.nil? || dist < 1
    options[:dist] = dist

  end

  opts.on('-s', '--search-terms x,y', Array, 'Comma Separated list of Search Terms "Continuous Delivery","Dr. Fowler"') do |terms|
    raise(OptionParser::InvalidArgument, "#{terms} Usage: must be only two terms") if terms.size != 2
    options[:terms] = terms
  end

end

begin
  optparse.parse!
  mandatory = [:dir,:terms]                                         # Enforce the presence of
  missing = mandatory.select{ |param| options[param].nil? }        # the -t and -f switches
  unless missing.empty?                                            #
    puts "Missing options: #{missing.join(', ')}"                  #
    puts optparse                                                  #
    exit                                                           #
  end                                                              #
rescue OptionParser::InvalidOption, OptionParser::MissingArgument, OptionParser::InvalidArgument      #
  puts $!.to_s                                                           # Friendly output when parsing fails
  puts optparse                                                          #
  exit                                                                   #
end

##
# Recursively search directory for *.txt files read them into string and check proximity
Dir.glob("#{options[:dir]}**/*.txt") do |file|
  if File.read(file).proximity?(options[:terms][0], options[:terms][1], options[:distance])

    puts file
  end

end

