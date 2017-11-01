class Grader

  attr_reader :grades, :answer_key

  def initialize(answer_key, options = {})

    @answer_key = answer_key
    @grades = options[:grades] || @grades = []

  end

  def score(answers)

    throw :ArgumentError if answers.length > @answer_key.length

    real_grades = 'A'.upto('D').to_a
    answers.each { |answer| throw :ArgumentError if !real_grades.include?(answer) && answer != nil }

    grade_check = Hash[@answer_key.zip(answers)]
    da_points = 100.0 / @answer_key.length
    da_score = 0
    grade_check.map { |k,v| k == v ? da_score += da_points : da_score += 0.0 }
    @grades << da_score
    return da_score

  end

  def self.letter_grade(grade_num)

    return 'A' if grade_num.between?(90, 100)
    return 'B' if grade_num.between?(80, 89)
    return 'C' if grade_num.between?(75, 79)
    return 'D' if grade_num.between?(70, 74)
    return 'F' if grade_num.between?(0, 69)

  end

  def curve_points
    100 - @grades.max
  end

  def curve
    curve = curve_points
    @grades.map! { |grade| grade + curve }
  end

  def average_score
    return @grades.inject(&:+) / @grades.length
  end

  def high_score
    return @grades.max
  end

  def low_score
    return @grades.min
  end

end



