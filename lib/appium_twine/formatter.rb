# encoding: utf-8
require 'cgi'
require 'rexml/document'

# based on Twine's android formatter
# https://github.com/mobiata/twine/blob/ee6789f62a5d08cac4e1df2a69719470660be144/lib/twine/formatters/android.rb

module Twine
  module Formatters
    class Csharp < Abstract
      FORMAT_NAME = 'csharp'
      EXTENSION = '.cs'
      DEFAULT_FILE_NAME = 'strings.cs'

      def self.can_handle_directory?(path)
        true
      end

      def default_file_name
        return DEFAULT_FILE_NAME
      end

      def determine_language_given_path(path)
        raise 'not going to implement'
      end

      def read_file(path, lang)
        raise 'not going to implement'
      end

      def write_file(path, lang)
        default_lang = @strings.language_codes[0]
        File.open(path, 'w:UTF-8') do |f|
          # todo: use user specified variable for namespace/class
          # load it from the twine.yml
          f.write (<<S).strip
namespace ruby_lib
{
    public static class Twine
    {
S
          prefix = ' ' * 8
          @strings.sections.each do |section|
            printed_section = false
            section.rows.each do |row|
              if row.matches_tags?(@options[:tags], @options[:untagged])
                if !printed_section
                  f.puts ''
                  if section.name && section.name.length > 0
                    section_name = section.name.gsub('--', '—')
                    f.puts prefix + "// SECTION: #{section_name}"
                  end
                  printed_section = true
                end

                key = row.key

                value = row.translated_string_for_lang(lang, default_lang)
                if !value && @options[:include_untranslated]
                  value = row.translated_string_for_lang(@strings.language_codes[0])
                end

                if value # if values is nil, there was no appropriate translation, so let Android handle the defaulting
                  value = String.new(value) # use a copy to prevent modifying the original

                  value.gsub!('"', '\\\\"')

                  comment = row.comment
                  if comment
                    comment = comment.gsub('--', '—')
                  end

                  if comment && comment.length > 0
                    f.puts  prefix + "// #{comment}\n"
                  end
                  f.puts prefix + "public const string #{key} = \"#{value}\";"
                end
              end
            end
          end

          f.write (<<S).rstrip
    }
}
S
        end
      end
    end
  end
end