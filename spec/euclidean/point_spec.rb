require 'spec_helper'
require 'euclidean/point'

describe Euclidean::Point do
  PointZero = Euclidean::PointZero
  Point     = Euclidean::Point

  it "must generate a PointZero" do
    expect(Point.zero).to be_an_instance_of(PointZero)
  end

  it "must generate a Point full of zeros" do
    expect( Point.zero(3) ).to eq Point[0,0,0]
  end

  describe "constructor" do
    it "must return the Point when constructed from a Point" do
      original_point = Point[3,4]
      point = Point[original_point]
      expect( point ).to eq original_point
      expect( point.size ).to eq 2
      expect( point.x ).to eq 3
      expect( point.y ).to eq 4
    end

    it "must return the PointZero when constructed from a PointZero" do
      original_point = PointZero.new
      point = Point[original_point]
      expect( point ).to eq original_point
    end
  end

  it "create a Point object from an array" do
    point = Point[[3,4]]
    expect(point.size).to eq 2
    expect(point.x).to eq 3
    expect(point.y).to eq 4
  end

  it "create a Point object from individual parameters" do
    point = Point[3,4]
    expect(point.size).to eq 2
    expect(point.x).to eq 3
    expect(point.y).to eq 4
  end

  it "create a Point object from a Vector" do
    point = Point[Vector[3,4]]
    expect(point.size).to eq 2
    expect(point.x).to eq 3
    expect(point.y).to eq 4
  end

  it "create a Point object from a Point using list syntax" do
    point = Point[Point[13,14]]
    expect(point.size).to eq 2
    expect(point.x).to eq 13
    expect(point.y).to eq 14
  end

  it "allow indexed element access" do
    point = Point[5,6]
    expect(point.size).to eq 2
    expect(point[0]).to eq 5
    expect(point[1]).to eq 6
  end

  it "allow named element access" do
    point = Point[5,6,7]
    expect(point.size).to eq 3
    expect(point.x).to eq 5
    expect(point.y).to eq 6
    expect(point.z).to eq 7
  end

  it "implement inspect" do
    point = Point[8,9]
    expect(point.inspect).to eq 'Point[8, 9]'
  end

  it "implement to_s" do
    point = Point[10,11]
    expect(point.to_s).to eq 'Point[10, 11]'
  end

  it "must support array access" do
    expect( Point[1,2][0] ).to eq 1
    expect( Point[1,2][1] ).to eq 2
    expect( Point[1,2][2] ).to eq nil
  end

  it "must clone" do
    expect(Point[1,2].clone).to be_an_instance_of(Point)
    expect( Point[1,2].clone ).to eq Point[1,2]
  end

  it "must duplicate" do
    expect(Point[1,2].dup).to be_an_instance_of(Point)
    expect( Point[1,2].dup ).to eq Point[1,2]
  end

  describe "Artrithmetic" do
    let(:left) { Point[1,2] }
    let(:right) { Point[3,4] }

    it "must have +@" do
      expect(+left).to eq Point[1,2]
      expect(+left).to be_an_instance_of(Point)
    end

    it "must have unary negation" do
      expect(-left).to eq Point[-1,-2]
      expect(-left).to be_an_instance_of(Point)
    end

    context "When adding" do
      it "return a Point when adding two Points" do
        expect(left+right).to be_a_kind_of Point
      end

      it "must return a Point when adding an array to a Point" do
        expect(left + [5,6]).to eq Point[6,8]
      end

      it "must add a Numeric to all elements" do
        expect(left + 2).to eq Point[3,4]
        expect(2 + left).to eq Point[3,4]
      end

      it "must raise an exception when adding mismatched sizes" do
        expect { left + [1,2,3,4] }.to raise_error Euclidean::DimensionMismatch
      end

      it "must return a Point when adding a Vector" do
        expect(left + Vector[5,6]).to eq Point[6,8]
        expect(Vector[5,6] + right).to eq Vector[8,10]
      end

      it "must return self when adding a PointZero" do
        expect(left + Point.zero).to eq left
      end

      it "must return self when adding a NilClass" do
        expect(left + nil).to eq left
      end
    end

    context "When subtracting" do
      it "return a Point when subtracting two Points" do
        expect(left-right).to be_a_kind_of Point
      end

      it "must return a Point when subtracting an array from a Point" do
        expect(left - [5,6]).to eq Point[-4, -4]
      end

      it "must subtract a Numeric from all elements" do
        expect(left - 2).to eq Point[-1, 0]
        expect(2 - left).to eq Point[1,0]
      end

      it "must raise an exception when subtracting mismatched sizes" do
        expect{ left - [1,2,3,4] }.to raise_error Euclidean::DimensionMismatch
      end

      it "must return self when subtracting a PointZero" do
        expect(left - Point.zero).to eq left
      end

      it "must return self when subtracting a NilClass" do
        expect(left - nil).to eq left
      end
    end

    context "When multiplying" do
      it "must return a Point when multiplied by a Matrix" do
        expect(Matrix[[1,2],[3,4]]*Point[5,6]).to eq Point[17, 39]
      end
    end

  end

  describe "Coercion" do
    subject { Point[1,2] }

    it "must coerce Arrays into Points" do
      expect( subject.coerce([3,4]) ).to eq [Point[3,4], subject]
    end

    it "must coerce Vectors into Points" do
      expect( subject.coerce(Vector[3,4]) ).to eq [Point[3,4], subject]
    end

    it "must coerce a Numeric into a Point" do
      expect( subject.coerce(42) ).to eq [Point[42,42], subject]
    end

    it "must reject anything that can't be coerced" do
      expect{ subject.coerce(NilClass) }.to raise_error TypeError
    end
  end

  describe "Comparison" do
    let(:point) { Point[1,2] }

    it "must compare equal to an equal Array" do
      expect(point).to eq [1,2]
      expect(point).to eql [1,2]
      expect([1,2]).to eq point.to_a
    end

    it "must not compare equal to an unequal Array" do
      expect(point==[3,2]).to be false
      expect([3,2]==point).to be false
    end

    it "must compare equal to an equal Point" do
      expect(point).to eq Point[1,2]
      expect(point).to eql Point[1,2]
      expect(Point[1,2]).to eq point
    end

    it "must not compare equal to an unequal Point" do
      expect(point==Point[3,2]).to be false
      expect(Point[3,2]==point).to be false
    end

    it "must compare equal to an equal Vector" do
      expect(point).to eq Vector[1,2]
      expect(Vector[1,2]).to eq point
    end

    it "must not compare equal to an unequal Vector" do
      expect(point == Vector[3,2]).to be false
      expect(Vector[3,2] == point).to be false
    end

    it "must think that floats == ints" do
      expect(Point[1,2]).to eq Point[1.0,2.0]
      expect(Point[1.0,2.0]).to eq Point[1,2]
    end

    it "must not think that floats eql? ints" do
      expect(Point[1,2].eql? Point[1.0,2.0]).to be false
      expect(Point[1.0,2.0].eql? Point[1,2]).to be false
    end
  end

  describe "spaceship" do
    it "must spaceship with another Point of the same length" do
      expect(Point[1,2] <=> Point[0,3]).to eq Point[1,-1]
    end

    it "must spaceship with another Point of different length" do
      expect(Point[1,2] <=> Point[0,3,4]).to eq Point[1,-1]
      expect(Point[1,2,4] <=> Point[0,3]).to eq Point[1,-1]
    end

    it "must spaceship with an Array" do
      expect(Point[1,2] <=> [0,3]).to eq Point[1,-1]
    end
  end

end
