# frozen_string_literal: true

module CoursesHelper
  def paginated_letters
    @paginated_letters ||= Course.paginated_letters
  end

  def previous_letter(current_letter)
    return if current_letter.blank? ||
      (current_index = paginated_letters.index(current_letter)).zero?

    paginated_letters[current_index - 1]
  end

  def next_letter(current_letter)
    current_index = paginated_letters.index(current_letter)

    paginated_letters[current_index.to_i + 1]
  end

  def paginated_letter_attrs
    {
      class: "mdc-ripple-surface layout vertical center-center black-text",
      "data-mdc-ripple-is-unbounded" => true
    }
  end

  def letter_path(letter)
    courses_path(letter: letter)
  end
end
