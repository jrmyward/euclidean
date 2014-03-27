# Euclidean

Euclidean adds classes and methods to handle basic geometry in Ruby.

The classes in this library are based on the Vector class provided in the Ruby Standard Library.
Geometric primitives are generally assumed to lie in 2-Dimensional space but are not necessarily
restricted to it.

Like Euclid himself, the work in this gem builds upon the work of others. Most notably:
   * [geometry](https://github.com/bfoz/geometry)
   * [ruby-geometry](https://github.com/DanielVartanov/ruby-geometry)

## Installation

Add this line to your application's Gemfile:

    gem 'euclidean'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install euclidean

## Defined Geometric Primitives
* Circle
* Edge
* Point
* Rectangle
* Size
* Vector

## Usage

### Point
```ruby
point = Euclidean::Point[3,4]    # 2D Point at coordinate 3, 4

# Copy constructors
point2 = Euclidean::Point[point]
point2 = Euclidean::Point[Vector[5,6]]

# Accessors
point.x
point.y
point[2]	# Same as point.z

# Zero
Euclidean::PointZero.new   # A Point full of zeros of unspecified length
Euclidean::Point.zero      # Another way to do the same thing
Euclidean::Point.zero(3)   # => Point[0,0,0]
```

### Circle
```ruby
# A circle at Point[1,2] with a radius of 3
circle = Euclidean::Circle.new [1,2], 3
circle = Euclidean::Circle.new center:[1,2], radius: 3

# A circle at Point[1,2] with a diameter of 3
circle = Euclidean::Circle.new center:[1,2], diameter: 3

# A circle at Point[0,0] with a diameter of 4
circle = Euclidean::Circle.new diameter: 4
```

### Rectangle
```ruby
# A Rectangle made from two corner points
rectangle = Euclidean::Rectangle.new [1,2], [2,3]
rectangle = Euclidean::Rectangle.new from:[1,2], to:[2,3]

rectangle = Euclidean::Rectangle.new center:[1,2], size:[1,1]	# Using a center point and a size
rectangle = Euclidean::Rectangle.new origin:[1,2], size:[1,1]	# Using an origin point and a size

# A Rectangle with its origin at [0, 0] and a size of [10, 20]
rectangle = Euclidean::Rectangle.new size: [10, 20]
rectangle = Euclidean::Rectangle.new size: Euclidean::Size[10, 20]
rectangle = Euclidean::Rectangle.new width: 10, height: 20
```

## Contributing

1. Fork it ( http://github.com/<my-github-username>/euclidean/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
