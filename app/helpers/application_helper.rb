module ApplicationHelper
	def format_date(datetime)
		datetime.nil? ? nil : datetime.strftime("%d-%m-%Y")
	end
end
