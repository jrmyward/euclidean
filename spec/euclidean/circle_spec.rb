require 'spec_helper'
require 'euclidean/circle'

describe Euclidean::Circle do
  Circle     = Euclidean::Circle
  Point      = Euclidean::Point
  Rectangle  = Euclidean::Rectangle

  context "When contstructed with center and radius arguments" do
    let(:circle) { Circle.new [1,2], 3 }

    it "must create a Circle" do
      expect(circle).to be_an_instance_of Circle
    end

    it "must have a center point accessor" do
      expect(circle.center).to eq Point[1,2]
    end

    it "must have a radius accessor" do
      expect(circle.radius).to eq 3
    end

    it "must compare equal" do
      expect(circle).to eq Circle.new([1,2], 3)
    end
  end

  context "When constructed with named center and radius arguments" do
    let(:circle) { Circle.new :center => [1,2], :radius => 3 }

    it "must create a Circle" do
      expect(circle).to be_an_instance_of Euclidean::Circle
    end

    it "must have a center point accessor" do
      expect(circle.center).to eq Point[1,2]
    end

    it "must have a radius accessor" do
      expect(circle.radius).to eq 3
    end

    it "must compare equal" do
      expect((circle == Circle.new(:center => [1,2], :radius => 3))).to eq true
    end
  end

  context "When constructed with named center and diameter arguments" do
    let(:circle) { Circle.new center:[1,2], diameter:4 }

    it "must be a CenterDiameterCircle" do
      expect(circle).to be_an_instance_of Euclidean::CenterDiameterCircle
      expect(circle).to be_a_kind_of Euclidean::Circle
    end

    it "must have a center" do
      expect(circle.center).to eq Point[1,2]
    end

    it "must have a diameter" do
      expect(circle.diameter).to eq 4
    end

    it "must calculate the correct radius" do
      expect(circle.radius).to eq 2
    end

    it "must compare equal" do
      expect(circle).to eq Circle.new([1,2], :diameter => 4)
    end
  end

  context "When constructed with a diameter and no center" do
    let(:circle) { Circle.new :diameter => 4 }

    it "must be a CenterDiameterCircle" do
      expect(circle).to be_an_instance_of Euclidean::CenterDiameterCircle
      expect(circle).to be_a_kind_of Euclidean::Circle
    end

    it "must have a nil center" do
      expect(circle.center).to be_a_kind_of Euclidean::PointZero
    end

    it "must have a diameter" do
      expect(circle.diameter).to eq 4
    end

    it "must calculate the correct radius" do
      expect(circle.radius).to eq 2
    end
  end

  describe "Properties" do
    subject { Circle.new center:[1,2], :diameter => 4 }

    it "must have a bounds property that returns a Rectangle" do
      expect(subject.bounds).to eq Rectangle.new([-1,0], [3,4])
    end

    it "must have a minmax property that returns the corners of the bounding rectangle" do
      expect(subject.minmax).to eq [Point[-1,0], Point[3,4]]
    end

    it "must have a max property that returns the upper right corner of the bounding rectangle" do
      expect(subject.max).to eq Point[3,4]
    end

    it "must have a min property that returns the lower left corner of the bounding rectangle" do
      expect(subject.min).to eq Point[-1,0]
    end
  end

  describe "#intersects_circle?" do
    let(:circle_1) { Circle.new [1, 2], 3}
    let(:circle_2) { Circle.new [3, 0], 3}
    let(:circle_3) { Circle.new [9, 0], 3}
    let(:circle_4) { Circle.new diameter: 4 }

    context "When two circles intersect" do
      it "returns true" do
        expect(circle_1.intersects_circle?(circle_2)).to be true
      end
    end

    context "When two circles intersect at only one point" do
      it "returns true" do
        expect(circle_2.intersects_circle?(circle_3)).to be true
      end
    end

    context "When two circles do not intersect" do
      it "returns false" do
        expect(circle_1.intersects_circle?(circle_3)).to be false
      end
    end

    context "When compared to a non-circle" do
      it "raises an error" do
        rectangle = Rectangle.new([-1,0], [3,4])
        expect{ circle_1.intersects_circle?(rectangle) }.to raise_error TypeError
        expect{ circle_4.intersects_circle?(rectangle) }.to raise_error TypeError
      end
    end
  end

end
