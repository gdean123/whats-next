module PotentialApplicationsHelper
  def youtube_tag(video_id, video_orientation)
    case video_orientation
      when :horizontal
        width = 360
        height = 480
      when :vertical
        width = 480
        height = 360
    end

    tag("iframe",
        :width => width, :height => height,
        :src=> "http://www.youtube.com/embed/#{video_id}",
        :frameborder => 0, :allowfullscreen => true)
  end
end