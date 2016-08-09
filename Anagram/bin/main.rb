require_relative '../lib/anagram'


puts 'Enter first string'
first_string = gets.chomp

puts 'Enter second string'
second_string = gets.chomp

puts "Are #{first_string} and #{second_string} anagrams? : #{ Anagrams.are_anagrams?(first_string, second_string) }"