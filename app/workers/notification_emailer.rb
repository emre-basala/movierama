class NotificationEmailer
  include Sidekiq::Worker

  def perform(vote:, movie_id:)
  end
end
