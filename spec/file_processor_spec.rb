require 'fileutils'
require_relative '../FileProcessor'

RSpec.describe FileProcessor do
  before(:all) do
    @file_path = 'text.txt'
    File.open(@file_path, 'w') do |file|
      file.puts "Line 1"
      file.puts "Line 2"
      file.puts "Line 3"
      file.puts "Line 1" # Дублікат
      file.puts "Line 2" # Дублікат
    end
  end

  after(:all) do
    File.delete(@file_path) if File.exist?(@file_path)
  end

  describe '#unique_lines' do
    it 'returns only unique lines from the file' do
      processor = FileProcessor.new(@file_path)
      unique_lines = processor.unique_lines.to_a

      expect(unique_lines).to eq(["Line 1", "Line 2", "Line 3"])
    end

    it 'uses lazy evaluation' do
      processor = FileProcessor.new(@file_path)
      expect(processor.unique_lines).to be_a(Enumerator::Lazy)
    end
  end
end
