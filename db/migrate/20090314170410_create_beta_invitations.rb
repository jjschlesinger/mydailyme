class CreateBetaInvitations < ActiveRecord::Migration
  def self.up
    create_table :beta_invitations do |t|
      t.string :email
      t.string :invite_token

      t.timestamps
    end
  end

  def self.down
    drop_table :beta_invitations
  end
end
