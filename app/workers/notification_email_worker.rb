class NotificationEmailWorker
  include Sidekiq::Worker

  def perform(movie_id:, vote:)
    UserMailer.notification_email(movie: Movie[movie_id], vote: vote.to_s).deliver_later
  end
end
