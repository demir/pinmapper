module StringServices
  class InputCharacterCounter < ApplicationService
    attr_reader :str

    def initialize(str)
      @str = str
    end

    def call
      emoji_count = str.scan(/\p{Emoji}/).count
      extra_new_line_count = str.scan(/\r\n/).count
      str_length = str.length + emoji_count - extra_new_line_count
    rescue StandardError => e
      { success: false, error: e }
    else
      { success: true, payload: str_length }
    end
  end
end
