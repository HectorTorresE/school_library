def title
  'THE SUN ALSO RISES'
end

def author
  'ERNEST HEMINGWAY'
end

def id
  123
end

def age
  23
end

def name
  'ROBERTO BANOS'
end

def label
  '101'
end

def date
  '2020/01/01'
end

def create_classroom
  Classroom.new(label)
end

def create_student(classroom = create_classroom)
  Student.new(age, classroom, name, id)
end

def create_book
  Book.new(title, author)
end

def create_rental
  Rental.new(date, create_book, create_person)
end

def book_json
  "{\"json_class\":\"Book\",\"data\":[\"#{title}\",\"#{author}\"]}"
end

def classroom_json
  "{\"json_class\":\"Classroom\",\"data\":[\"#{label}\"]}"
end

def rental_json
  "{\"json_class\":\"Rental\",\"data\":[\"#{date}\",{\"json_class\":\"Book\",\"data\":[\"#{title}\",\"#{author}\"]},{\"json_class\":\"Person\",\"data\":[#{age},\"#{name}\",#{id},true]}]}"
end

def create_person
  Person.new(age, name, id)
end

def person_json
  "{\"json_class\":\"Person\",\"data\":[#{age},\"#{name}\",#{id},true]}"
end

def specialization
  'Mathematics'
end

def student_json
  "{\"json_class\":\"Student\",\"data\":[#{age},{\"json_class\":\"Classroom\",\
\"data\":[\"101\"]},\"#{name}\",#{id},true]}"
end

def create_teacher
  Teacher.new(age, specialization, name, id)
end

def teacher_json
  "{\"json_class\":\"Teacher\",\"data\":[#{age},\"#{specialization}\",\"#{name}\",#{id}]}"
end
