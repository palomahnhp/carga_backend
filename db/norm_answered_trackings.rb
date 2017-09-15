puts "--- Comienzo de normalización del campo 'any_answer' de units ---"

Unit.all.each do |unit|
	unit_update = false
	unit.positions.each do |position|
		position.users.each do |user| 
			if user.responses.any?
				unit_update = true
				break
			end
		end
		if unit_update
			break
		end
	end
	if unit_update
		unit.update_attributes(any_answer: true)
	else
		unit.update_attributes(any_answer: false)
	end
end

puts "--- Campo normalizado ---"