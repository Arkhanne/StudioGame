# frozen_string_literal: true

#
# Auditable
#
module Auditable
  def audit
    puts "Rolled a #{number} (#{self.class})"
  end
end
