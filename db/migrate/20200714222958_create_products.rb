# frozen_string_literal: true

class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.string :price, null: false
      t.string :site, null: false

      t.timestamps
    end
  end
end
