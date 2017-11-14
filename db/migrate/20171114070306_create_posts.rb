class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.string :subject_name, :null => true
      t.string :professor, :null => true
      t.string :time, :null => true
      t.string :place, :null => true

      t.timestamps
    end
  end
end
