require 'spec_helper'
require 'euclidean/size'

describe Euclidean::Size do
  it "creates a Size object using list syntax" do
    size = Euclidean::Size[2,1]
    expect(size.size).to eq 2
    expect(size.x).to eq 2
    expect(size.y).to eq 1
  end

  it "creates a Size object from an array" do
    size = Euclidean::Size[[3,4]]
    expect(size.size).to eq 2
    expect(size.x).to eq 3
    expect(size.y).to eq 4
  end

  it "creates a Size object from individual parameters" do
    size = Euclidean::Size[3,4]
    expect(size.size).to eq 2
    expect(size.x).to eq 3
    expect(size.y).to eq 4
  end

  it "creates a Size object from a Size" do
    size = Euclidean::Size[Euclidean::Size[3,4]]
    expect(size.size).to eq 2
    expect(size.x).to eq 3
    expect(size.y).to eq 4
  end

  it "creates a Size object from a Vector" do
    size = Euclidean::Size[Vector[3,4]]
    expect(size.size).to eq 2
    expect(size.x).to eq 3
    expect(size.y).to eq 4
  end

  it "allows indexed element access" do
    size = Euclidean::Size[5,6]
    expect(size.size).to eq 2
    expect(size[0]).to eq 5
    expect(size[1]).to eq 6
  end

  it "allows named element access" do
    size = Euclidean::Size[5,6,7]
    expect(size.size).to eq 3
    expect(size.x).to eq 5
    expect(size.y).to eq 6
    expect(size.z).to eq 7
  end

  it "has a width accessor" do
    size = Euclidean::Size[5,6,7]
    expect(size.width).to eq 5
  end

  it "has a height accessor" do
    size = Euclidean::Size[5,6,7]
    expect(size.height).to eq 6
  end

  it "has a depth accessor" do
    size = Euclidean::Size[5,6,7]
    expect(size.depth).to eq 7
  end

  it "compares equal" do
    size1 = Euclidean::Size[1,2]
    size2 = Euclidean::Size[1,2]
    size3 = Euclidean::Size[3,4]
    expect(size1==size2).to be true
    expect(size2==size3).to be false
  end

  it "compares equal to an array with equal elements" do
    size1 = Euclidean::Size[1,2]
    expect(size1).to eq [1,2]
  end

  it "does not compare equal to an array with unequal elements" do
    size1 = Euclidean::Size[1,2]
    size1.should_not eq [3,2]
  end

  it "implements inspect" do
    size = Euclidean::Size[8,9]
    expect(size.inspect).to eq('Size[8, 9]')
  end

  it "implements to_s" do
    size = Euclidean::Size[10,11]
    expect(size.to_s).to eq('Size[10, 11]')
  end

end
