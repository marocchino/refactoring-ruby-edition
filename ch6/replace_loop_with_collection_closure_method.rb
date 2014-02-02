managers = []
employees.each do |e|
  managers << e if e.manager?
end

managers = employees.select(&:manager?)


offices = []
employees.each { |e| offices << e.office }

offices = employees.collect(&:office)


managerOffices = []
employees.each do |e|
  managerOffices << e.office if e.manager?
end

managerOffices = employees.select(&:manager?).collect(&:office)

total = 0
employees.each { |e| total += e.salary }

total = employees.inject(o) { |sum, e| sum + w.salary }
total = employees.collect(&:salary).reduce(:+)
