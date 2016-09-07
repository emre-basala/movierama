class UserMailerPreview < ActionMailer::Preview

  def when_someone_likes_a_movie
    UserMailer.notification_email(movie: Movie[1], vote: "like")
  end

  def when_someone_hates_a_movie
    UserMailer.notification_email(movie: Movie[1], vote: "hate")
  end

end
