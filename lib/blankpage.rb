module Blankpage
  VERSION = '1.0.0'

  def self.blank?(data: nil, file: nil, contrast: 1.2, brightness: 0)
    raise ArgumentError, 'only 1 of data, file and path can be provided' if [data, file].compact.size > 1

    if data
      if data.is_a?(String)
        BlankpageExt.is_blank_bytes?(data, contrast, brightness)
      elsif data.is_a?(StringIO)
        BlankpageExt.is_blank_bytes?(data.to_s, contrast, brightness)
      end
    elsif file
      if file.is_a?(String)
        BlankpageExt.is_blank_filename?(data, contrast, brightness)
      elsif file.is_a?(Tempfile)
        BlankpageExt.is_blank_filename?(data.path, contrast, brightness)
      elsif file.is_a?(Pathname)
        BlankpageExt.is_blank_filename?(data.to_s, contrast, brightness)
      end
    end
  end
end

require_relative 'blankpage/blankpage'
