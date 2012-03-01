require 'spreadsheet'
book = Spreadsheet.open 'bowlers.xls'
sheet = book.worksheet 0

sheet.each do |row|
    compacted = row.to_a.compact
    puts compacted.inspect unless compacted.empty?
end