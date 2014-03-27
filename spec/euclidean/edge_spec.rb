require 'spec_helper'
require 'euclidean/edge'

describe Euclidean::Edge do
  Edge = Euclidean::Edge
  subject { Edge.new [0,0], [1,1] }

  it "must create an Edge object" do
    edge = Edge.new([0,0], [1,0])
    expect(edge).to be_a_kind_of Euclidean::Edge
    expect(edge.first).to eq Euclidean::Point[0,0]
    expect(edge.last).to eq Euclidean::Point[1,0]
  end

  it "must handle equality" do
    edge1 = Edge.new([1,0], [0,1])
    edge2 = Edge.new([1,0], [0,1])
    edge3 = Edge.new([1,1], [5,5])
    expect(edge1==edge2).to be true
    expect(edge1==edge3).to be false
  end

  it "must return the height of the edge" do
    edge = Edge([0,0], [1,1])
    expect(edge.height).to eq 1
  end

  it "must return the width of the edge" do
    edge = Edge([0,0], [1,1])
    expect(edge.width).to eq 1
  end

  it "must convert an Edge to a Vector" do
    expect(Edge.new([0,0], [1,0]).vector).to eq Vector[1,0]
  end

  it "must return the normalized direction of a vector" do
    expect(Edge.new([0,0], [1,0]).direction).to eq Vector[1,0]
  end

  it "must return true for parallel edges" do
    expect( Edge.new([0,0], [1,0]).parallel?(Edge.new([0,0], [1,0])) ).to be true
    expect( Edge.new([0,0], [1,0]).parallel?(Edge.new([1,0], [2,0])) ).to be true
    expect( Edge.new([0,0], [1,0]).parallel?(Edge.new([3,0], [4,0])) ).to be true
    expect( Edge.new([0,0], [1,0]).parallel?(Edge.new([3,1], [4,1])) ).to be true
  end

  it "must return false for non-parallel edges" do
    expect( Edge.new([0,0], [2,0]).parallel?(Edge.new([1,-1], [1,1])) ).to be false
  end

  it "must clone and reverse" do
    reversed = subject.reverse
    expect(reversed.to_a).to eq subject.to_a.reverse
    expect(reversed==subject).to be false
  end

  it "must reverse itself" do
    original = subject.to_a
    subject.reverse!
    expect(subject.to_a).to eq original.reverse
  end

  describe "Spaceship" do
    it "ascending with a Point" do
      edge = Edge.new [0,0], [1,1]
      expect(edge <=> Point[0,0]).to eq 0
      expect(edge <=> Point[1,0]).to eq -1
      expect(edge <=> Point[0,1]).to eq 1
      expect(edge <=> Point[2,2]).to be_nil
    end

    it "descending with a Point" do
      edge = Edge.new [1,1], [0,0]
      expect(edge <=> Point[0,0]).to eq 0
      expect(edge <=> Point[1,0]).to eq 1
      expect(edge <=> Point[0,1]).to eq -1
      expect(edge <=> Point[2,2]).to be_nil
    end
  end

  describe "Intersection" do
    it "must find the intersection of two end-intersecting Edges" do
      intersection = Edge.new([0,0],[1,1]).intersection(Edge.new([0,1],[1,1]))
      expect(intersection).to be_a_kind_of Euclidean::Point
      expect(intersection).to eq Euclidean::Point[1,1]
    end

    it "must find the intersection of two collinear end-intersecting Edges" do
      intersection = Edge.new([2,2], [0,2]).intersection(Edge.new([3,2], [2,2]))
      expect(intersection).to be_a_kind_of Euclidean::Point
      expect(intersection).to eq Euclidean::Point[2,2]

      intersection = Edge.new([0,2], [2,2]).intersection(Edge.new([2,2], [3,2]))
      expect(intersection).to be_a_kind_of Euclidean::Point
      expect(intersection).to eq Euclidean::Point[2,2]
    end

    it "must find the itersection of two crossed Edges" do
      edge1 = Edge.new [0.0, 0], [2.0, 2.0]
      edge2 = Edge.new [2.0, 0], [0.0, 2.0]
      intersection = edge1.intersection edge2
      expect(intersection).to be_a_kind_of Euclidean::Point
      expect(intersection).to eq Euclidean::Point[1,1]
    end

    it "must return nil for two edges that do not intersect" do
      expect( Edge.new([0,0],[1,0]).intersection(Edge.new([0,1],[1,1])) ).to be_nil
    end

    it "must return true for two collinear and overlapping edges" do
      expect( Edge.new([0,0],[2,0]).intersection(Edge.new([1,0],[3,0])) ).to be true
    end

    it "must return false for collinear but non-overlapping edges" do
      expect( Edge.new([0,0],[2,0]).intersection(Edge.new([3,0],[4,0])) ).to be false
      expect( Edge.new([0,0],[0,2]).intersection(Edge.new([0,3],[0,4])) ).to be false
    end

    it "must return nil for two parallel but not collinear edges" do
      expect( Edge.new([0,0],[2,0]).intersection(Edge.new([1,1],[3,1])) ).to be_nil
    end

    it "must return nil for two perpendicular but not interseting edges" do
      expect( Edge.new([0, 0], [2, 0]).intersection(Edge.new([3, 3], [3, 1])) ).to be_nil
    end
  end

end
