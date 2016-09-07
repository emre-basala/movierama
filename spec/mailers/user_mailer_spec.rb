require "rails_helper"

RSpec.describe UserMailer do

  let!(:author) { User.create(uid: 'null|12345', name: 'Bob', email: "author@example.com") }

  let!(:movie) {
    Movie.create(
      title:        'Empire strikes back',
      description:  'Who\'s scruffy-looking?',
      date:         '1980-05-21',
      user: author
    )
  }

  before do
    ActionMailer::Base.delivery_method = :test
    ActionMailer::Base.perform_deliveries = true
    ActionMailer::Base.deliveries.clear
  end

  after do
    ActionMailer::Base.deliveries.clear
  end

  describe "notification_email when someone likes a movie" do
    it 'sends a notification email' do
      described_class.notification_email(movie: movie, vote: "like" ).deliver
      expect(ActionMailer::Base.deliveries.count).to eq(1)

      email = ActionMailer::Base.deliveries.first

      expect(email.subject).to eq("Someone likes your movie!")
      expect(email.to).to eq(["author@example.com"])
    end
  end
end
