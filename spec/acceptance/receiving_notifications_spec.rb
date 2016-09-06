require 'rails_helper'
require 'capybara/rails'
require 'support/pages/movie_list'
require 'support/pages/movie_new'
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
      expect(NotificationEmailer).to have_enqueued_job(vote: "like", movie_id: movie.id.to_s)
    end
  end

  context 'when a user hates a movie' do

    with_logged_in_user

    it 'enqueues a notification email' do
       page.hate(movie.title)
      expect(NotificationEmailer).to have_enqueued_job(vote: "hate", movie_id: movie.id.to_s)
    end
  end

end
