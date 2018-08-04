class AddRefToMessage < ActiveRecord::Migration[5.1]
  def change
    add_reference :messages, :pro, foreign_key: true
  end
end
