module StringHelper
	def self.make_query_list(query)
		query = query.gsub(/\s+/, '')
		query.split(';')

	end

	def self.clean_string(str)

		escape_for_nothing_characters = Regexp.escape('\\+-&|!(){}[]^~*?:&–\r\n')     
		str = str.gsub(/([#{escape_for_nothing_characters}])/, '')



	end

	def self.duration_to_int(duration)
		if duration.index("PT") != 0
			return 0
		end
		start = 2
		ret_time = 0
		if duration.include?("D")
			d_index = duration.index("D")
			ret_time = ret_time + (duration[start...d_index].to_i * 60 * 24)
			start = d_index +1
		end

		if duration.include?("H")
			h_index = duration.index("H")
			ret_time = ret_time + (duration[start...h_index].to_i * 60)
			start = h_index +1

		end

		if duration.include?("M")
			m_index = duration.index("M")
			ret_time = ret_time + (duration[start...m_index].to_i)
			start = m_index +1

		end
		puts ret_time
		return ret_time


	end

	def self.duration_to_string(duration)
		if duration.index("PT") != 0
			return nil
		end
		start = 2
		ret_string = ""
		if duration.include?("Day")
			d_index = duration.index("Day")
			if duration[start..d_index -1].to_i == 1
				unit = "Day "
			else
				unit = "Days "
			end
			ret_string = ret_string + duration[start...d_index] + ' '  + unit
			start = d_index + 3
		elsif duration.include?("D")
			d_index = duration.index("D")
			if duration[start..d_index -1].to_i == 1
				unit = "Day "
			else
				unit = "Days "
			end
			ret_string = ret_string + duration[start...d_index] + ' '  + unit
			start = d_index +1
		end

		if duration.include?("H")
			h_index = duration.index("H")
			if duration[start..h_index -1].to_i == 1
				unit = "Hour "
			else
				unit = "Hours "
			end
			ret_string = ret_string + duration[start...h_index] + ' '  + unit
			start = h_index +1

		end

		if duration.include?("M")
			m_index = duration.index("M")
			if duration[start..m_index -1].to_i == 1
				unit = "Minute"
			else
				unit = "Minutes"
			end
			ret_string = ret_string + duration[start...m_index] + ' '  + unit
			start = m_index +1

		end

		return ret_string



	end

end