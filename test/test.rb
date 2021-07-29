
TEST_CASES = Dir.glob(File.join(File.dirname(__FILE__), 'fixtures', '*.input'))
CHECKMARK = "\u2713".encode('utf-8')
CROSSMARK = "\u2717".encode('utf-8')
ETL = File.expand_path(File.join(File.dirname(__FILE__), '..', 'etl.rb'))

def assert(test, expected, got)
  success = expected.strip == got.strip
  puts '', "----------------------------------------------"
  puts "#{test}: #{success ? CHECKMARK : CROSSMARK}"
  return if success

  puts '>>> Expected:', expected
  puts '<<< Got:', got
end

TEST_CASES.each do |test|
  expected = File.read(test.sub('input', 'output'))
  got = `cat #{test} | ruby #{ETL}`
  assert(test, expected, got)
end
