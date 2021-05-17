BLOCKS = ['B:O', 'X:K', 'D:Q', 'C:P', 'N:A', 'G:T', 'R:E', 'F:S', 'J:W', 'H:U', 'V:I', 'L:Y', 'Z:M']

def block_word?(word)
  word.size == BLOCKS.count {|block| !!(word.upcase.match(/[#{block}]/))}
end

block_word?('BATCH') == true
block_word?('BUTCH') == false
block_word?('jest') == true