class CreateStudyHours < ActiveRecord::Migration[5.0]
  def change
    create_table :study_hours do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.string :description
      t.datetime :started_at
      t.datetime :completed_at
      t.references :user, index: { name: 'index_study_hours_on_user_id' }
      t.timestamps
    end
  end
end
