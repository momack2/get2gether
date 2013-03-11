class CreateAppts < ActiveRecord::Migration
  def up
        create_table :appts do |t|
            t.column :user_id,       	:integer
            t.column :start_time,       :string
            t.column :end_time,      	:string
            t.column :description,		:string
            t.column :event_name,		:string
            t.column :booker_name, 		:string
            t.column :booker_message,	:string
            t.column :booked,			:boolean
            t.column :other,			:string
        end
    end
    
    def down
        drop_table :users
    end

end
