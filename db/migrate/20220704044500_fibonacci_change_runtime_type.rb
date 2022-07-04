class FibonacciChangeRuntimeType < ActiveRecord::Migration[6.1]
  def change
    change_column(:fibonaccis, :runtime, :string)
  end
end
