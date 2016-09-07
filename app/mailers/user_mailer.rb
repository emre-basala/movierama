class UserMailer < ActionMailer::Base
  default from: "no-reply@movierama.dev"
  layout "mailer"

  def notification_email(movie:, vote:)
    @movie = movie
    @user = movie.user
    @vote = vote
    # mail(subject: subject_for(vote), to: @user.email)
    mail(subject: subject_for(vote), to: "emrebasala@gmail.com")
  end

  private

  def subject_for(vote)
    vote == "like" ? "Someone likes your movie!" : "Someone doesn't like your movie as much."
  end
end
