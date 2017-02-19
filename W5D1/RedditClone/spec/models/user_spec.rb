require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:password_digest) }
  it { should validate_length_of(:password)
        .is_at_least(6)
        .on(:create)}
  it { should have_many(:subs) }
  it { should have_many(:comments) }
  it { should have_many(:user_votes) }

  subject(:user) { User.new(name: 'Jesse', password: 'password') }

  describe "#is_password?" do
    context "when given the correct password" do
      it "returns true if given text is password" do
        expect(user.is_password?('password')).to be true
      end
    end

    context "when given an incorrect password" do
      it "returns false if given text is not password" do
        expect(user.is_password?('notpassword')).to be false
      end
    end
  end

  describe "#reset_session_token!" do
    it "returns a string" do
      expect(user.reset_session_token!).to be_an_instance_of(String)
    end

    it "calls save on the user" do
      expect(user).to receive(:save)
      user.reset_session_token!
    end

    it "changes the session_token attribute on the user" do
      first_token = user.session_token
      user.reset_session_token!
      expect(user.session_token).to_not eq(first_token)
    end
  end

  describe "::find_by_credentials" do
    context "with valid params" do
      it "returns the user" do
        User.create(name: 'Jesse', password: 'password')
        expect(User.find_by_credentials('Jesse', 'password')).to be_an_instance_of(User)
      end
    end
  end

end
