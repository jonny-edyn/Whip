module VotingLib
	def collect_yes(_start)
		if _start == @end_element_yes
			@yes_node = false
		end

		if @yes_node == true
			@yes_votes << _start.next_element.text
			collect_yes(_start.next_element)
		end

	end

	def collect_no(_start)

		if _start == @end_element_no
			@no_node = false
		end

		if @no_node == true
			@no_votes << _start.next_element.text
			collect_no(_start.next_element)
		end

	end
end