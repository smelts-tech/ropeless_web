require 'test_helper'

class FileProcessor < ActiveSupport::TestCase
  test "file processing" do
    processor = FileProcessor.new('test/fixtures/files/upload1.xml')
    processor.process
  end
end


