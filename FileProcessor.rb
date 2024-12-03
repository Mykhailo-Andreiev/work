require 'set'

class FileProcessor
  def initialize(file_path)
    @file_path = file_path
  end

  def unique_lines
    seen_lines = Set.new
    Enumerator.new do |yielder|
      File.foreach(@file_path, chomp: true) do |line|
        unless seen_lines.include?(line)
          seen_lines.add(line)
          yielder << line
        end
      end
    end.lazy
  end
end

processor = FileProcessor.new("text.txt")
processor.unique_lines.each do |line|
  puts line
end
