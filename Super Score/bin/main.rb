# Assue atleast one entry present
require_relative '../lib/super_score'

n = gets.chomp.to_i
i = 0
math_scores = Array.new
reading_scores = Array.new
writing_scores = Array.new
test_dates = Array.new
while i < n do 
	i += 1
	input = gets.chomp.split(' ')
	math_scores << input[0]
	reading_scores << input[1]
	writing_scores << input[2]
	test_dates << (input[3] + " " + input[4])
end

result = SuperScore.calculate(math_scores, reading_scores, writing_scores)
math_scores_max = result[0]
reading_scores_max = result[1]
writing_scores_max = result[2]
super_score = math_scores_max.to_i + reading_scores_max.to_i + writing_scores_max.to_i
puts "#{math_scores_max}, #{reading_scores_max}, #{writing_scores_max}"
puts "#{super_score}"
