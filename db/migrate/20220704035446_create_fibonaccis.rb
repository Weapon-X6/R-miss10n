class CreateFibonaccis < ActiveRecord::Migration[6.1]
  def change
    create_table :fibonaccis do |t|
      t.integer :value
      t.integer :result
      t.string :runtime

      t.datetime :created_at
    end
  end
end
