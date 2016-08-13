class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.references :attachable, polymorphic: true, index: true
      t.string :file

      t.timestamps null: false
    end
  end
end
