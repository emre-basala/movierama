require "rails_helper"

RSpec.describe User do
  subject { User.create(uid: "some-uid", name: "foo bar", email: "foo_bar@example.com", token: "abc" ) }

  describe "attributes" do
    its(:uid) { is_expected.to eq("some-uid") }
    its(:name) { is_expected.to eq("foo bar") }
    its(:email) { is_expected.to eq("foo_bar@example.com") }
    its(:token) { is_expected.to eq("abc") }
  end

  describe "validations" do
    it "validates that uid is unique" do
      expect{
        User.create(uid: subject.uid)
      }.to raise_error Ohm::UniqueIndexViolation
    end

    it "validates that email is unique" do
      expect{
        User.create(email: subject.email)
      }.to raise_error Ohm::UniqueIndexViolation
    end
  end
end
