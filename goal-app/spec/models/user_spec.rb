# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:password_digest) }
  it { should validate_presence_of(:session_token) }
  it { should validate_length_of(:password).is_at_least(6) }

  it 'finds a user based on their credentials' do
    user = User.create(username: 'mike', password: '123456')

    expect(User.find_by_credentials(user.username, user.password)).to eq(user)
  end

  it "validates a user's password" do
    user = User.create(username: 'mike', password: '123456')
    
    expect(user.is_password?(user.password)).to be(true)
  end

  describe 'uniqueness' do
    before :each do
      create(:user)
    end

    it { should validate_uniqueness_of(:username) }
    it { should validate_uniqueness_of(:session_token) }
  end
end
