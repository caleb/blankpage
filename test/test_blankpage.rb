require 'minitest/autorun'
require 'blankpage'

class TestBlankPage < Minitest::Test
  def setup; end

  def test_blankpage
    images = Dir.glob('assets/blank/*.*')

    images.each do |image|
      puts "Testing #{image}"
      data = File.read(image)
      assert Blankpage.is_blank_bytes?(data)
    end

    images = Dir.glob('assets/not_blank/*.*')

    images.each do |image|
      puts "Testing #{image}"
      data = File.read(image)
      assert !Blankpage.is_blank_bytes?(data)
    end
  end
end
