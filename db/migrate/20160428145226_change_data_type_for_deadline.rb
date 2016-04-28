class ChangeDataTypeForDeadline < ActiveRecord::Migration
  def self.up
  	change_table :tasks do |t|
  		t.change :deadline, :string
  	end
  end

  def self.down
  	change_table :tasks do |t|
  		t.change :deadline, :datetime
  	end
  end
end
