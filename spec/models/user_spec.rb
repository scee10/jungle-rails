require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do

    before (:each) do
      @user = User.new
      @user_one = User.new(
        email: "test@gmail.com",
        name: "Stefani",
        password: "orange",
        password_confirmation: "orange"
      )
    end

    it "is valid" do
      @user = User.new(
        email: "hey@gmail.com",
        name: "stefani chhor",
        password: "orange",
        password_confirmation: "orange"
      )
      expect(@user).to be_valid
    end

    it "passwords need to match" do
      @user.password = "orange"
      @user.password_confirmation = "cat"
      expect(@user).to_not be_valid
    end

    it "email must be unique" do
      @user_one.save
      @user.email = "TEST@gmail.com"
      @user.validate

      expect(@user.errors[:email]).to include('has already been taken')
    end

    it "should fail without a name" do 
      @user.name = nil
      expect(@user).to_not be_valid
    end

    it "should fail without an email" do 
      @user.email = nil
      expect(@user).to_not be_valid
    end

    it "should fail if password is not a minimum of 6 characters" do 
      @user.password = "cat"
      expect(@user).to_not be_valid
    end
  end

  describe '.authenticate_with_credentials' do
    # examples for this class method here

    it "should be valid" do
      @user = User.create!(
        email: "hey@gmail.com",
        name: "stefani",
        password: "orange",
        password_confirmation: "orange"
      )

    @new_user = User.authenticate_with_credentials("hey@gmail.com", "orange")
    expect(@user).to eq(@new_user) 
    end

    it "should fail if password is incorrect" do
      @user = User.create!(
        email: "hey@gmail.com",
        name: "stefani",
        password: "orange",
        password_confirmation: "orange"
      )

    @user = User.authenticate_with_credentials("hey@gmail.com", "cat")
    expect(@user).to eq(nil) 
    end

    it "should pass if email has uppercase letters" do
      @user = User.create!(
        email: "hey@gmail.com",
        name: "stefani",
        password: "orange",
        password_confirmation: "orange"
      )

    @fetched_user = User.authenticate_with_credentials("HEY@gmail.com", "orange")
    expect(@user).to eq(@fetched_user) 
    end

    it "should pass if input email has leading spaces" do
      @user = User.create!(
        email: "hey@gmail.com",
        name: "stefani",
        password: "orange",
        password_confirmation: "orange"
      )

    @fetched_user = User.authenticate_with_credentials("   HEY@gmail.com  ", "orange")
    expect(@user).to eq(@fetched_user) 
    end

  end
end
