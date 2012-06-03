# coding: utf-8
class Director::StudentsController < ApplicationController

  before_filter :authenticate_director!

  def top
    @first_grade_students = current_director.school.best_active_students_by_grade(1)
    @second_grade_students = current_director.school.best_active_students_by_grade(2)
    @third_grade_students = current_director.school.best_active_students_by_grade(3)
    @fourth_grade_students = current_director.school.best_active_students_by_grade(4)
  end

end
