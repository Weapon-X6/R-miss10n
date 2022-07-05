class Fibonacci < ApplicationRecord
    validates :value, :result, :runtime, presence: true
end
