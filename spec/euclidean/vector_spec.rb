require 'spec_helper'
require 'euclidean/vector'

describe Vector do
  context "Monkeypatch" do
    let(:left) { Vector[1,2] }
    let(:right) { Vector[3,4] }

    it "must have +@" do
      expect(+left).to eq Vector[1,2]
    end

    it "must have unary negation" do
      expect(-left).to eq Vector[-1,-2]
    end

    it "must cross product" do
      expect(left.cross(right)).to eq -2
      expect(Vector[1,2,3].cross(Vector[3,4,5])).to eq Vector[-2, 4, -2]
      expect((Vector[1,2,3] ** Vector[3,4,5])).to eq Vector[-2, 4, -2]
    end

    it "must have a constant representing the X axis" do
      expect(Vector::X).to eq Vector[1,0,0]
    end

    it "must have a constant representing the Y axis" do
      expect(Vector::Y).to eq Vector[0,1,0]
    end

    it "must have a constant representing the Z axis" do
      expect(Vector::Z).to eq Vector[0,0,1]
    end

    it "must not create global axis constants" do
      expect{ X }.to raise_error NameError
      expect{ Y }.to raise_error NameError
      expect{ Z }.to raise_error NameError
    end
  end
end
