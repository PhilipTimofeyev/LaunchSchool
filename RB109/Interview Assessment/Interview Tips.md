



# # out the test cases





=begin
Complete the function that takes an array of words.

You must concatenate the nth letter from each word to construct a new word which should be returned as a string, where n is the position of the word in the list.

For example:

["yoda", "best", "has"]  -->  "yes"
  ^        ^        ^
  n=0     n=1     n=2
Note: Test cases contain valid input only - i.e. a string array or an empty array; and each word will have enough letters.

PROBLEM
  INPUT: an array of strings, where the length of each string is atleast its index + 1
  OUTPUT: A string
  - Output takes the ith character from each string (where i is the index in the array) 
  - Each of these characters is concatenated (in order) to create the output string
  - If the array is empty then the string returned should be empty
  - this also means the size of the output string is the same size as the input array

EXAMPLE


DATA STRUCTURES
  - Array
  - String

ALGORITHM
  - 
  - initialize a new variable assigned to an empty string, we'll call this 'result'
  - iterare through the argument array (Array#each_with_index) and use the position of each element to extract the corresponding character and concatenate it with out empty string (String#<<)
  - return the 'result' string, that's it

=end
