# frozen_string_literal: true

module Scheduler
  class Runner
    include CategorySetEvaluation
    include IncompleteCategory
    include CommitRecords
    include MathClasses

    attr_accessor :user, :complete, :incomplete, :math_classes, :used_courses,
                  :semester, :categories
    delegate :taken_courses, :transcripts, to: :user

    def initialize(user:, semester:, categories: nil)
      @user            = user
      @complete        = {}
      @incomplete      = {}
      @math_classes    = []
      @used_courses    = Set.new
      @semester        = semester
      @categories      =
        categories.blank? ? user.categories.to_a : Array.wrap(categories)
    end

    def perform
      categories.each do |category|
        evaluate_category(category)
      end

      add_needed_math_classes
    end
  end
end
