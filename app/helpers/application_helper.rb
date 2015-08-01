module ApplicationHelper

	# for title on HTML pages
	def full_title(custom_title='')
		base_title = 'Cardagain'
		if custom_title.empty?
			base_title
		else
			"#{custom_title} | #{base_title}"
		end
	end
	
end
