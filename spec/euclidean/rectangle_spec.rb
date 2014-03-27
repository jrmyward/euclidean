require 'spec_helper'
require 'euclidean/rectangle'

def Rectangle(*args)
  Euclidean::Rectangle.new(*args)
end

describe Euclidean::Rectangle do
  Rectangle = Euclidean::Rectangle
  Point     = Euclidean::Point
  Size      = Euclidean::Size

  it "must accept two corners as Arrays" do
    rectangle = Rectangle.new [1,2], [2,3]
    expect(rectangle).to be_a_kind_of Euclidean::Rectangle
    expect(rectangle.height).to eq 1
    expect(rectangle.width).to eq 1
    expect(rectangle.origin).to eq Point[1,2]
  end

  it "must accept two named corners as Arrays" do
    rectangle = Rectangle.new from:[1,2], to:[2,3]
    expect(rectangle).to be_a_kind_of Euclidean::Rectangle
    expect(rectangle.height).to eq 1
    expect(rectangle.width).to eq 1
    expect(rectangle.origin).to eq Point[1,2]
  end

  it "must accept named center point and size arguments" do
    rectangle = Rectangle.new center:[1,2], size:[3,4]
    expect(rectangle).to be_a_kind_of Euclidean::Rectangle
    expect(rectangle.height).to eq 4
    expect(rectangle.width).to eq 3
    expect(rectangle.center).to eq Point[1,2]
  end

  it "must reject a named center argument with no size argument" do
    expect{ Rectangle.new center:[1,2] }.to raise_error ArgumentError
  end

  it "must accept named origin point and size arguments" do
    rectangle = Rectangle.new origin:[1,2], size:[3,4]
    expect(rectangle).to be_a_kind_of Euclidean::Rectangle
    expect(rectangle.height).to eq 4
    expect(rectangle.width).to eq 3
    expect(rectangle.origin).to eq Point[1,2]
  end

  it "must reject a named origin argument with no size argument" do
    expect{ Rectangle.new origin:[1,2] }.to raise_error ArgumentError
  end

  it "must accept a sole named size argument that is an Array" do
    rectangle = Rectangle.new size:[1,2]
    expect(rectangle).to be_a_kind_of Euclidean::Rectangle
    expect(rectangle.origin).to eq Point[0,0]
    expect(rectangle.height).to eq 2
    expect(rectangle.width).to eq 1
  end

  it "must accept a sole named size argument that is a Size" do
    rectangle = Rectangle.new size:Size[1,2]
    expect(rectangle).to be_a_kind_of Euclidean::Rectangle
    expect(rectangle.origin).to eq Point[0,0]
    expect(rectangle.height).to eq 2
    expect(rectangle.width).to eq 1
  end

  it "must accept named width and height arguments" do
    rectangle = Rectangle.new width:1, height:3
    expect(rectangle).to be_a_kind_of Euclidean::Rectangle
    expect(rectangle.height).to eq 3
    expect(rectangle.width).to eq 1
  end

  it "must reject width or height by themselves" do
    expect{ Rectangle.new height:1 }.to raise_error ArgumentError
    expect{ Rectangle.new width:1 }.to raise_error ArgumentError
  end

  describe "Comparison" do
    it "must compare equal" do
	    rectangle = Rectangle [1,2], [3,4]
	    expect(rectangle).to eq Rectangle([1,2], [3, 4])
	  end
  end

  describe "Inset" do
    subject { Rectangle.new [0,0], [10,10] }

    it "must inset equally" do
      expect( subject.inset(1) ).to eq Rectangle.new [1,1], [9,9]
    end

    it "must inset vertically and horizontally" do
      expect( subject.inset(1,2) ).to eq Rectangle.new [1,2], [9,8]
      expect( subject.inset(x:1, y:2) ).to eq Rectangle.new [1,2], [9,8]
    end

    it "must inset from individual sides" do
      expect( subject.inset(1,2,3,4) ).to eq Rectangle.new [2,3], [6,9]
      expect( subject.inset(top:1, left:2, bottom:3, right:4) ).to eq Rectangle.new [2,3], [6,9]
    end
  end

  describe "Properties" do
    subject { Rectangle.new [1,2], [3,4] }
    let(:rectangle) { Rectangle [1,2], [3,4] }

    it "have a center point property" do
      expect(rectangle.center).to eq Point[2,3]
    end

    it "have a width property" do
      expect(rectangle.width).to eq 2
    end

    it "have a height property" do
      expect(rectangle.height).to eq 2
    end

    it "have an origin property" do
      expect(rectangle.origin).to eq Point[1,2]
    end

    it "have an edges property that returns 4 edges" do
      edges = rectangle.edges
      expect(edges.size).to eq 4
      edges.each { |edge| expect(edge).to be_a_kind_of Euclidean::Edge }
    end

    it "have a points property that returns 4 points" do
      points = rectangle.points
      expect(points.size).to eq 4
      points.each { |point| expect(point).to be_a_kind_of Euclidean::Point }
    end

    it "must have a bounds property that returns a Rectangle" do
      expect(subject.bounds).to eq Rectangle.new([1,2], [3,4])
    end

    it "must have a minmax property that returns the corners of the bounding rectangle" do
      expect(subject.minmax).to eq [Point[1,2], Point[3,4]]
    end

    it "must have a max property that returns the upper right corner of the bounding rectangle" do
      expect(subject.max).to eq Point[3,4]
    end

    it "must have a min property that returns the lower left corner of the bounding rectangle" do
      expect(subject.min).to eq Point[1,2]
    end
  end

end
