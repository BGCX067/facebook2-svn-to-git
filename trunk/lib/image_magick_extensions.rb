# Project FaceBook2
# 
# Author: Hlxwell
# 
# Subversion Keywords:
# 
# LastChangedDate: 2007-08-20 12:43:59 +0800 (星期一, 20 八月 2007) 
# LastChangedRevision: 1 
# LastChangedBy: Hlxwell 
# URL: http://facebook2.googlecode.com/svn/trunk/ 
# 
# Copyright (C) 2007 Hlxwell <hlxwell@gmail.com>
# Powered by http://chinaonrails.com
 
require 'RMagick'

module RubyBrain
  module Magick
    module Extensions
      FIELD_SEPERATOR = "\n2#"
     
      VALID_OPTIONS = [:include, :exclude, :use_labels, :coerce_types]
     
      IPTC_OPTIONS = { :use_labels => true, :coerce_types => true }
      EXIF_OPTIONS = { :coerce_types => true }

      # create an iptc data hash table
      #   available options:
      #     :use_label - use labels or field numbers.  default: true
      #     :coerce_type - try to convert values to native types.  default: true 
      #     :include - only keys provided will be included in the result.  (use lowercase)
      #     :except - all keys will be returned except the keys provided.  (use lowercase)
      #
      def iptc(options = {})
        options = IPTC_OPTIONS.merge(options)
        validate_options(options)
        old_format = self.format
        self.format = "iptctext"
        profile = self.to_blob
        self.format = old_format

        build_hash(options, profile)
      rescue ::Magick::ImageMagickError
        {}
      end

      # create an iptc data hash table
      #   available options:
      #     :use_label - use labels or field numbers.  default: true
      #     :coerce_type - try to convert values to native types.  default: true 
      #     :include - only keys provided will be included in the result.  (use lowercase)
      #     :except - all keys will be returned except the keys provided.  (use lowercase)
      #
      def exif(options = {})
        options = EXIF_OPTIONS.merge(options)
        validate_options(options)
        hash = {}

        exif_data = self['EXIF:*']
        if exif_data
          exif_data.split("\n").each do |pair|

            key, value = pair.split("=")

            # filter out unwanted values
            unless ( options[:exclude] && options[:exclude].include?(key.downcase) ) || 
              ( options[:include] && !options[:include].include?(key.downcase) )

              # fix trailing '.'
              value.sub!(/\.$/, "")

              hash[key] =  options[:coerce_types] ? type_cast(value) : value
            end

          end
        end
        hash
      end

      private 

      def build_hash(options, iptc_encoded_string)
        iptc_encoded_string ||= ""
        hash = Hash.new
        pairs = iptc_encoded_string.split(FIELD_SEPERATOR)
        pairs.each do |pair|
          unless 0 == pair.length
            compound_key, value = pair.split("=", 2) # split string in 2 pieces on the first '='
            # either use the field label or the field number as the key
            field_key = options[:use_labels] ? 
              compound_key.split("#")[1] : compound_key.split("#")[0].to_i

            # filter out unwanted values
            unless ( options[:exclude] && options[:exclude].include?(field_key.downcase) ) || 
              ( options[:include] && !options[:include].include?(field_key.downcase) )

              value.chop!.sub!(/^\"/,"").sub!(/\"$/,"") # clean up value

              # if we get more then one value for a key, convert the storage to an Array
              if hash[field_key] 
                hash[field_key] = [] << hash[field_key] unless hash[field_key].kind_of?(Array)
                hash[field_key] << (options[:coerce_types] ? type_cast(value) : value)
              else
                hash[field_key] = options[:coerce_types] ? type_cast(value) : value
              end

            end
          end
        end
        hash
      end

      # Try to determine the correct type of this string.  If any thing goes wrong just fall
      # back to the default.  Only try extremely simple cases.
      def type_cast(string)
        if string =~ /^\d+$/ # looks like a number.  All numeric digits start to finish
          return string.to_i
        elsif string =~ /^\d\d\d\d\:\d\d\:\d\d \d\d\:\d\d\:\d\d$/ # looks like a date
          return DateTime.strptime(string, "%Y:%m:%d %H:%M:%S")
        else
          string
        end
      rescue
        p $!
        return string
      end

      # Do some sanity checking on the options that are passed in.
      # Use Kernel.raise because Magick::Image overrides raise
      def validate_options(options = {})
        if options[:include] && options[:exclude]
          Kernel.raise ArgumentError, "include and except are mutually exclusive"
        end

        options.keys.each do |key| 
          Kernel.raise ArgumentError, "invalid option '#{key}'" unless VALID_OPTIONS.include?(key)
        end

        # convert single string values into one element arrays to allow:
        # :include => "byline", etc.

        options[:include] = [] << options[:include] unless 
          (!options[:include] || options[:include].kind_of?(Array))

        options[:exclude] = [] << options[:exclude] unless 
          (!options[:exclude] || options[:exclude].kind_of?(Array))
         
        if options[:include]
          options[:include].each { |option| option.downcase! }
        elsif options[:exclude]
          options[:exclude].each { |option| option.downcase! }
        end
      end
    end
  end
end

Magick::Image.send(:include, RubyBrain::Magick::Extensions)