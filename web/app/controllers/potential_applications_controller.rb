class PotentialApplicationsController < ApplicationController
  def index
    case params[:potential_application]
      when 'live_data'
        @title = 'Collect live data from your audience'
        @subtitle = 'Ask questions and see the results rendered directly on your slide'
        @potential_application = 'live_data'
        @video_orientation = :horizontal
        @video_id = 'jHJl-b3U40w'
      when 'slide_saver'
        @title = 'Preview, review, and save slides'
        @subtitle = 'Preview upcoming slides, review slides during Q&A, and save important slides for later'
        @potential_application = 'slide_saver'
        @video_orientation = :vertical
        @video_id = 'L4rETpPWgtY'
      when 'whats_next'
        @title = 'Find unique experiences near you'
        @subtitle = 'Get inspired! Browse and recommend cool experiences near you.'
        @potential_application = 'whats_next'
        @video_orientation = :horizontal
        @video_id = 'WlYT7sVoZmk'
    end
  end
end