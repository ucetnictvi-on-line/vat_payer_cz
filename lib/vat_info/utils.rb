module VatInfo
  module Utils
    COMPANY_TYPES = ['a.s.', 's.r.o.', 'v.o.s.', 'k.s.', 'z.s.'].freeze
    SPECIAL_CHARS = [
      %w(Á á), %w(Č č), %w(Ď ď), %w(É é), %w(Ě ě), %w(Í í), %w(Ň ń), %w(Ó ó),
      %w(Ř ř), %w(Š š), %w(Ť ť), %w(Ú ú), %w(Ů ů), %w(Ž ž), %w(Ý ý)
    ].freeze

    def self.wrap_in_array(content)
      content.is_a?(Array) ? content : [content]
    end

    def self.normalize(string)
      return unless string
      string = replace_exceptions(string).strip.split(' ').map do |word|
        format_this word
      end.join(' ')
      replace_special_chars(string)
    end

    def self.replace_special_chars(string)
      sub_string = string[1..-1]
      SPECIAL_CHARS.each do |pattern|
        sub_string = sub_string.gsub(/#{pattern[0]}/i, pattern[1])
      end
      string[0].concat(sub_string)
    end

    def self.replace_exceptions(string)
      string.gsub(/,.+spol\.+ s r.o./i, ' s.r.o.')
    end

    def self.format_this(string)
      return string.downcase if string.size == 1
      return string.downcase if COMPANY_TYPES.include? string.downcase
      string.capitalize
    end
  end
end
