require 'spec_helper'

describe User do
  let(:user) { create(:user) }

  subject { user }

  it { should have_db_column(:provider) }
  it { should have_db_column(:uid) }
  it { should have_db_column(:name) }
  it { should have_db_column(:email) }
  it { should have_db_column(:nickname) }
  it { should have_db_column(:admin) }

  specify { User.should respond_to(:from_omniauth) }
  specify { User.should respond_to(:create_from_omniauth) }

  describe ".from_omniauth" do

    it "finds user if user exists" do
      auth = { "provider" => user.provider,
               "uid" => user.uid,
               "info" => { :nickname => user.name}
             }
      new_user = User.from_omniauth(auth)
      new_user.should_not be_nil
    end
  end

  describe ".create_from_omniauth" do

    it "creates a new user" do
      auth = { "provider" => user.provider,
               "uid" => user.uid,
               "info" => { :nickname => user.name}
             }
      new_user = User.create_from_omniauth(auth)
      new_user.should be_valid
    end
  end
end