module CardSurveyRankingsHelper

	def find_missing_minimum(array, max)
		minimum_id = 0
		(1 .. max).each do |count|
			unless array.include? count || count != 12 # 12 is the magic "all" id
				minimum_id = count
				break
			end
		end
		minimum_id
	end
	
end
