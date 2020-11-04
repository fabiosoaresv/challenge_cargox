5.times do |i|
  Foundator.create(name: "Fabio #{i + 1}", surname: "Soares #{i + 1}", age: i + 1)
end

5.times do |i|
  Leader.create!(name: "Leader #{i + 1}", surname: "Surname #{i + 1}", age: i + 1, foundator_id: Foundator.last.id)
end

5.times do |i|
  Company.create!(name: "Company #{i + 1}", cnpj: "1234#{i + 1}", foundation: Date.today, foundator_id: Foundator.last.id)
end

5.times do |i|
  Coordinator.create!(name: "Coordinator #{i + 1}", surname: "Surname #{i + 1}", age: i + 1, leader_id: Leader.last.id, hired_at: '20/02/1997')
end

5.times do |i|
  Employee.create!(name: "Employee #{i + 1}", surname: "Junior #{i + 1}", age: i + 1, coordinator_id: Coordinator.last.id, hired_at: '20/02/1997', in_experience: true, level: 'Junior', salary: '10000.99')
  Employee.create!(name: "Employee #{i + 1}", surname: "Senior #{i + 1}", age: i + 1, coordinator_id: Coordinator.last.id, hired_at: '20/02/1997', in_experience: true, level: 'Senior', salary: '10000.99')
end
