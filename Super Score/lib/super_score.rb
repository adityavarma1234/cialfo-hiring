module SuperScore
	def self.calculate(math_scores, reading_scores, writing_scores)
		math_scores_max = math_scores.max
		reading_scores_max = reading_scores.max
		writing_scores_max = writing_scores.max
		super_score = math_scores_max.to_i + reading_scores_max.to_i + writing_scores_max.to_i
		return [math_scores_max, reading_scores_max, writing_scores_max, super_score]
	end
end
