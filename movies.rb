# your code, here
require 'time'

class Movie
  attr_accessor :title, :genre, :time

  def intialize(row_hash)
    @title = row_hash[:title]
    @genre = row_hash[:genre]
    @time = Time.parse(row_hash[:time].strip)
  end

  def showing_after?(arrival_time)
    @time >= Time.parse(arrival_time)
  end

  def showing_between?(early_time, late_time)
    @time.between?(Time.parse(start_time), Time.parse(end_time))
  end

  def comedy?
    @genre == "Comedy"
  end

  def to_s
    "#{@name} is a #{@genre} film that is showing at #{@time.strptime("%l-:%M %p")}"
  end




movies = [
  {title: "The Princess Bride", genre: "Comedy", time: "7:00PM"},
  {title: "Troll 2", genre: "Horror", time: "7:30PM"},
  {title: "Pet Cemetery", genre: "Horror", time: "8:15PM"},
  {title: "Flight of the Navigator", genre: "Adventure", time: "8:17PM"},
  {title: "Teen Witch", genre: "Comedy", time: "8:20PM"},
  {title: "The Goonies", genre: "Comedy", time: "8:30PM"},
  {title: "Better Off Dead" , genre: "Comedy" , time: "8:45PM"},
  {title: "Weekend at Bernies" , genre: "Comedy" , time: "9:00PM"},
  {title: "The Wizard" , genre: "Adventure" , time: "9:10PM"}
]

movie_objects = []

movies.each do |movie_hash|
  movie_objects << Movie.new(movie_hash)
end

puts "The following movies are comedies:"
puts movie_objects.select { |movie| movie.comedy? }

puts "-----------------------------------------"

time = "8:35 PM"
puts "The following movies are showing after #{time}:"
puts movie_objects.select { |movie| movie.showing_after?(time) }

puts "-----------------------------------------"

time_1 = "7:25 PM"
time_2 = "8:35 PM"
puts "The following movies are showing between #{time_1}-#{time_2}:"
puts movie_objects.select { |movie| movie.showing_between?(time_1, time_2) }
end
