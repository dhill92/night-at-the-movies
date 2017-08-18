### Part I - A List of Movies

Let's catch a movie!

In order to pick the awesomely 80's movie that you want to see, you really need to break down each movie into a Ruby instance. Here's the list of movies playing at the local theatre tonight:

```no-highlight
The Princess Bride, Comedy, 7:00PM
Troll 2, Horror, 7:30PM
Pet Cemetery, Horror, 8:15PM
Flight of the Navigator, Adventure, 8:17PM
Teen Witch, Comedy, 8:20PM
The Goonies, Comedy, 8:30PM
Better Off Dead, Comedy, 8:45PM
Weekend at Bernies, Comedy, 9:00PM
The Wizard, Adventure, 9:10PM
```

**Create an array of movie objects** to store all the information in this list. Ensure that each stored instance provides us with a way to access the title, genre, and start time of the movie.

Tip: Figure out a way to create a single movie object first with a single row of data from above.
Then figure out how to do that for _each_ row of data, and then populate the new array with new movie objects.

An additional note: In the subsequent steps in this lesson, you will be comparing the movie start time other times of the day. It would be difficult to compare strings like `"8:45AM"` and `"9:00PM"` to determine which comes first. We want to convert our string representing a time into a Time object. Then we want take that time object and store it in an instance variable instead of a storing the string. This will make working with time-based data much easier!

The recommendation is to use `Time.parse` ([docs here](http://ruby-doc.org/stdlib-2.2.0/libdoc/time/rdoc/Time.html)) to convert your strings to Time objects. As you'll see from the docs, you should also `require 'time'` to use the `Time` class.


```ruby
require 'time'

time = "7:00PM"
parsed_time = Time.parse(time)
=> 2017-01-20 19:00:00 -0500

parsed_time.strftime("%-l:%M %p")
=> "7:00 PM"
```

### Part II

Implement a `showing_after?` instance method that takes a single, string
argument that represents the time you'll arrive at the theatre. This
method should return `true` if the start time begins on or after the specified
time. Again, you'll want to use `Time.parse` to be working with the right data
type.

```ruby
# when movie is a movie instance
movie.showing_after?("7:00PM")
#=> returns true or false
```

Also, we really like comedies. Implement a `comedy?` instance method that
returns `true` if the movie has the genre `Comedy`, but returns false otherwise.

### Part III

Implement a `showing_between?` instance method that takes two string arguments
that represents desirable times for when the movie begins. It should return
`true` if the movie's start time fits between the two specified times.

{% show_solution %}
```ruby
require 'time'

class Movie
  attr_accessor :name, :genre, :start_time

  def initialize(row_hash)
    @name = row_hash[:name]
    @genre = row_hash[:genre]
    @start_time = Time.parse(row_hash[:start_time].strip)
  end

  def showing_after?(arrival_time)
    @start_time >= Time.parse(arrival_time)
  end

  def showing_between?(early_time, late_time)
    @start_time.between?(Time.parse(early_time), Time.parse(late_time))
  end

  def comedy?
    @genre == 'Comedy'
  end

  def to_s
    "#{@name} is a #{@genre} film and starts at #{@start_time.strftime("%-l:%M %p")}"
  end
end

movies = [
  { name: "The Princess Bride", genre: "Comedy", start_time: "7:00PM" },
  { name: "Troll 2", genre: "Horror", start_time: "7:30PM" },
  { name: "Pet Cemetery", genre: "Horror", start_time: "8:15PM" },
  { name: "Flight of the Navigator", genre: "Adventure", start_time: "8:17PM" },
  { name: "Teen Witch", genre: "Comedy", start_time: "8:20PM" },
  { name: "The Goonies", genre: "Comedy", start_time: "8:30PM" },
  { name: "Better Off Dead", genre: "Comedy", start_time: "8:45PM" },
  { name: "Weekend at Bernies", genre: "Comedy", start_time: "9:00PM" },
  { name: "The Wizard", genre: "Adventure", start_time: "9:10PM" }
]

movie_objects = []

movies.each do |movie_hash|
  movie_objects << Movie.new(movie_hash)
end

movie_objects #=>
# [
#   <Movie:0x007fb9c9be23e8 @genre="Comedy", @name="The Princess Bride", @start_time=2016-06-13 19:00:00 -0400>,
#   <Movie:0x007fb9c9be1b78 @genre="Horror", @name="Troll 2", @start_time=2016-06-13 19:30:00 -0400>,
#   <Movie:0x007fb9c9be1718 @genre="Horror", @name="Pet Cemetery", @start_time=2016-06-13 20:15:00 -0400>,
#   <Movie:0x007fb9c9be12e0 @genre="Adventure", @name="Flight of the Navigator", @start_time=2016-06-13 20:17:00 -0400>,
#   <Movie:0x007fb9c9be0c78 @genre="Comedy", @name="Teen Witch", @start_time=2016-06-13 20:20:00 -0400>,
#   <Movie:0x007fb9c9be0d40 @genre="Comedy", @name="The Goonies", @start_time=2016-06-13 20:30:00 -0400>,
#   <Movie:0x007fb9c9bdb408 @genre="Comedy", @name="Better Off Dead", @start_time=2016-06-13 20:45:00 -0400>,
#   <Movie:0x007fb9c9bdaaf8 @genre="Comedy", @name="Weekend at Bernies", @start_time=2016-06-13 21:00:00 -0400>,
#   <Movie:0x007fb9c9bda580 @genre="Adventure", @name="The Wizard", @start_time=2016-06-13 21:10:00 -0400>
# ]

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
```
{% endshow_solution %}
