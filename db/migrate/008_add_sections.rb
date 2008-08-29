class AddSections < ActiveRecord::Migration
  def self.up
    Section.create(:name=>"Lately I'm Thinking")
    Section.create(:name=>"Currently Reading")
    Section.create(:name=>"This is Really Interesting")
    Section.create(:name=>"Currently Watching")
    Section.create(:name=>"Currently Listening To")
    Section.create(:name=>"Shout Out To")
    Section.create(:name=>"This is Bullshit")
  end

  def self.down
    Section.delete_all
  end
end
