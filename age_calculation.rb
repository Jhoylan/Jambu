class CalculateAge
	def main 
		integer_birthday_array = self.user_entry
		input_is_correct = self.input_is_correct integer_birthday_array
		birthday_is_in_future = self.birthday_is_in_future integer_birthday_array
		
		if !birthday_is_in_future && input_is_correct
			years_and_months = self.months_and_years_calculation integer_birthday_array
			self.show_message true, years_and_months
		else
			self.show_message false, years_and_months
		end
	end
	
	private
	def user_entry
		puts "Enter a birthday in the format yyyy/mm/dd"
		input = gets.chomp
		string_birthday_array = input.split '/'
		date_is_in_correct_format = true
		integer_birthday_array = []

		string_birthday_array.each do |element|
			if element.to_i == 0 
				date_is_in_correct_format = false
				break
			else
				integer_birthday_array.push element.to_i
			end
		end

		return integer_birthday_array
	end
	
	def input_is_correct integer_birthday_array
		if integer_birthday_array.length() < 3
			return false
		end

		birth_year, birth_month, birth_day = integer_birthday_array
		
		valid_year = birth_year.digits.count <= 4 && birth_year > 0
		valid_month = birth_month.digits.count <= 2 && birth_month > 0 && birth_month <= 12
		last_day = self.last_moth_day birth_month,birth_year
		valid_day = birth_day.digits.count <= 2 && birth_day > 0 && birth_day <= last_day

		if valid_year && valid_month && valid_day
			return true
		else
			return false
		end
	end

	def birthday_is_in_future integer_birthday_array
		if integer_birthday_array.length() < 3
			return true
		end

		birth_year, birth_month, birth_day = integer_birthday_array
		future_year, same_year_future_month, same_year_same_month_future_day = [false, false, false]
		current_time = Time.now

		if birth_year > current_time.year 
			future_year = true
		end
		
		if birth_year == current_time.year && birth_month > current_time.month  
			same_year_future_month = true
		end
		
		if birth_year == current_time.year && birth_month == current_time.month && birth_day > current_time.day 
			same_year_same_month_future_day = true
		end
		
		if !future_year && !same_year_future_month && !same_year_same_month_future_day
			return false 
		else
			return true
		end
	end

	def months_and_years_calculation integer_birthday_array
		current_time = Time.now 
		birth_year, birth_month, birth_day = integer_birthday_array
		already_made_birthday = (current_time.day >= birth_day && current_time.month == birth_month) || 								current_time.month > birth_month 
		years_and_months = []		


		if already_made_birthday
			year = current_time.year - birth_year 
			years_and_months.push(year)

			if current_time.day >= birth_day
				month = current_time.month - birth_month
				years_and_months.push(month)
			else
				month = current_time.month - birth_month - 1
				years_and_months.push(month)
			end
		else
			year = current_time.year - birth_year - 1 
			years_and_months.push(year)
			if current_time.day >= birth_day
				month = current_time.month + 12 - birth_month
				years_and_months.push(month)
			else
				month = current_time.month + 12 - birth_month - 1
				years_and_months.push(month)
			end
		end
		
		return years_and_months
	end

	def show_message date_is_in_correct_format, years_and_months
		years, months = years_and_months
		if date_is_in_correct_format
			puts "You have #{years} years and #{months} months"  
		else
			puts 'The date is in wrong format'
		end
	end	

	def isLeap year
		if (year % 400 == 0) || ((year % 4 == 0) && (year % 100 != 0))
			return true
		else
			return false
		end
	end

	def last_moth_day month, year
		max_day = 0
		is_leap_year = self.isLeap year
		last_february_day = 0

		if is_leap_year
			last_february_day = 29
		else
			last_february_day = 28
		end

		case month
		when 1
			max_day = 31
		when 2
			max_day = last_february_day
		when 3
			max_day = 31
		when 4
			max_day = 30
		when 5
			max_day = 31
		when 6
			max_day = 30
		when 7
			max_day = 31
			when 8
			max_day = 31
		when 9
			max_day = 30
		when 10
			max_day = 31
		when 11
			max_day = 30
		when 12
			max_day = 31
		else
			max_day = 0
		end
			return max_day
	end	
end

age = CalculateAge.new 
age.main
