require "rails_helper"

RSpec.describe UserRegistration do
  let(:auth_hash_json) { File.read(File.join("spec", "fixtures", "auth_hash.json")) }
  let(:user_registration) { described_class.new(JSON.parse(auth_hash_json)) }

  describe "user" do
    context "when the user doesn't exist" do
      it "creates a user with the given auth_hash" do
        user = user_registration.user
        expect(user.uid).to eq("github|2251521")
        expect(user.name).to eq("example-user")
        expect(user.email).to eq("example-user@gmail.com")
      end
    end

    context "when the user already exists" do
      before do
        User.create(uid: "github|2251521", name: "already-existing-user" )
      end

      it "finds the user using the given auth_hash" do
        user = user_registration.user
        expect(user.uid).to eq("github|2251521")
        expect(user.name).to eq("already-existing-user")
      end
    end
  end
end
