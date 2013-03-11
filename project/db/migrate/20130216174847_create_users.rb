class CreateUsers < ActiveRecord::Migration
  def up
        create_table :users do |t|
            t.column :first_name,       :string
            t.column :last_name,        :string
            t.column :login,			:string
            t.column :salt,				:integer
            t.column :password,			:string
            t.column :email,			:string
            t.column :cal_id,			:string
            t.column :phone,			:string
            t.column :other,			:string
            t.column :photo_file,		:string
        end
    end
    
    def down
        drop_table :users
    end
end
