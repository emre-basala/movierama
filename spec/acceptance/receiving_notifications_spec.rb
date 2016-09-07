require 'rails_helper'
require 'support/pages/movie_list'
require 'support/with_user'

RSpec.describe 'receiving notifications', type: :feature do
  let(:page) { Pages::MovieList.new }
  let!(:author) { User.create(uid: 'null|12345', name: 'Bob') }
  let!(:movie) {
    Movie.create(title: 'Empire strikes back',
      description: 'Who\'s scruffy-looking?',
      date: '1980-05-21',
      user: author)
  }

  before do
    page.open
  end

  context 'when a user likes a movie' do
    with_logged_in_user
    it 'enqueues a notification email' do
      page.like(movie.title)
      expect(NotificationEmailWorker).to have_enqueued_job( movie.id.to_s, "like")
    end
  end

  context 'when a user hates a movie' do
    with_logged_in_user
    it 'enqueues a notification email' do
       page.hate(movie.title)
      expect(NotificationEmailWorker).to have_enqueued_job( movie.id.to_s, "hate")
    end
  end
end
