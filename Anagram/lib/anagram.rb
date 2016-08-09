# Assumes case sensitivity
# abc and ABC are not anagrams
module Anagrams
	def self.are_anagrams?(string_a, string_b)
		(string_a.chars.sort == string_b.chars.sort) ? true : false
	end
end
