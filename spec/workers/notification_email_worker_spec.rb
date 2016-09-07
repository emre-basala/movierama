require "rails_helper"

RSpec.describe NotificationEmailWorker do
  let(:vote) { "like" }

  let!(:movie) {
    Movie.create(
      title:        'Empire strikes back',
      description:  'Who\'s scruffy-looking?',
      date:         '1980-05-21'
    )
  }

  describe "perform" do
    let(:notification_email) { double(:notification_email) }
    it "delegates email sending to UserMailer" do
      expect(UserMailer).to receive(:notification_email).with(movie: movie, vote: "like").and_return(notification_email)
      expect(notification_email).to receive(:deliver_later)

      subject.perform(movie_id: movie.id, vote: vote)
    end
  end
end
