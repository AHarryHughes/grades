class Grader

  attr_reader :grades

  def initialize(answer_key, options = {})

    @answer_key = answer_key
    @grades = options[:grades] || @grades = []

  end

  def score(answers)

    throw :ArgumentError1 if answers.length > @answer_key.length

    real_grades = 'A'.upto('D').to_a
    answers.each { |answer| throw :ArgumentError2 if !real_grades.include?(answer) && answer != nil }

    grade_check = Hash[@answer_key.zip(answers)]
    da_points = 100.0/@answer_key.length
    da_score = 0
    grade_check.map { |k,v| k == v ? da_score += da_points : da_score += 0.0 }
    @grades << da_score
    return da_score

  end

  def letter_grade(grade_num)

    return 'A' if grade_num.between?(90, 100)
    return 'B' if grade_num.between?(80, 89)
    return 'C' if grade_num.between?(75, 79)
    return 'D' if grade_num.between?(70, 74)
    return 'F' if grade_num.between?(0, 69)

  end

  def curve_points
    return 100 - @grades.max
  end

   def curve
     curve = curve_points
     @grades.map! { |grade| grade + curve }
   end

end



grade1 = Grader.new(["A", "B", "C", "D"])

puts grade1.letter_grade(75.34)

puts grade1.score(["A", "B", "A", "A"])
puts grade1.score(["A", "B", "C", "A"])
puts grade1.score([nil, nil, nil, "A"])

puts grade1.grades

puts grade1.curve_points

grade1.curve

puts grade1.grades



