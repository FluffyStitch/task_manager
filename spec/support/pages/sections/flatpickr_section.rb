# frozen_string_literal: true

class Flatpickr < SitePrism::Section
  element :next_month, '.flatpickr-next-month'
  element :day, :xpath, '//span[contains(text(), "15")]'
end
