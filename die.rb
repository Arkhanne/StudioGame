# frozen_string_literal: true

require_relative 'auditable'

#
# Die
#
class Die
  include Auditable

  attr_reader :number

  def roll
    @number = rand(1..6)
    audit
    @number
  end
end
