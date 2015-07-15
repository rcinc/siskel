require 'httparty'

class Siskel
  attr_reader :title
  attr_reader :rating
  attr_accessor :year
  attr_reader :plot

  def initialize(title, year: "", plot: :short)
    @movie = HTTParty.get("http://www.omdbapi.com/?t=#{title}&y=#{year}&plot=#{plot}&tomatoes=true")
    @title = @movie['Title']
    @rating = @movie['Rated']
    @year = @movie['Year']
    @plot = @movie['Plot']
    @error = @movie['Error']
  end

  def title
    if @movie['Title'].nil?
       @error
     else
      @movie['Title']
    end
  end

  def consensus
    if @movie['tomatoMeter'].to_i <= 25
      "Two Thumbs Down"
    elsif @movie['tomatoMeter'].to_i <= 50
      "Thumbs Down"
    elsif @movie['tomatoMeter'].to_i <= 75
      "Thumbs Up"
    else
      "Two Thumbs Up"
    end
  end

end
