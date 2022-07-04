class FibonacciChangeRuntimeFloat < ActiveRecord::Migration[6.1]
  def change
    change_column(:fibonaccis, :runtime, :float)
  end
end
