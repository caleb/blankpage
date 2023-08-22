require 'minitest/autorun'
require 'blankpage'

class TestBlankPage < Minitest::Test
  def setup; end

  def test_blankpage
    images = Dir.glob('assets/blank/*.*')

    images.each do |image|
      puts "Testing #{image}"
      data = File.read(image)
      assert Blankpage.blank?(data:, contrast: 1.2, brightness: 0)
    end

    images = Dir.glob('assets/not_blank/*.*')

    images.each do |image|
      puts "Testing #{image}"
      data = File.read(image)
      assert !Blankpage.blank?(data:, contrast: 1.2, brightness: 0)
    end
  end
end
