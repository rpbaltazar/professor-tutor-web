class CreateTutorship < ActiveRecord::Migration[5.0]
  def change
    create_table :tutorships do |t|
      t.integer :student_id
      t.integer :professor_id
    end
  end
end
