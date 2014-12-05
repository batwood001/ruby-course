require 'spec_helper'
require_relative '../exercises.rb'

describe 'Exercise 0' do
  it "Triples the length of a string" do
    result = Exercises.ex0("ha")
    expect(result).to eq("hahaha")
  end

  it "Returns 'nope' if the string is 'wishes'" do
    result = Exercises.ex0("wishes")
    expect(result).to eq("nope")
  end
end

describe 'Exercise 1' do
  it "Returns the number of elements in the array" do
    result = Exercises.ex1([3,4,5,6])
    expect(result).to eq(4)
  end
end

describe 'Exercise 2' do
  it "Returns the second element of an array" do
    result = Exercises.ex2([4,5,6,7])
    expect(result).to eq(5)
  end
end

describe 'Exercise 3' do
  it "Returns the sum of the given array of numbers" do
    result = Exercises.ex3([100,100,100])
    expect(result).to eq(300)
  end
end

describe 'Exercise 4' do
  it "Returns the max number of the given array" do
    result = Exercises.ex4([1,2,3,100])
    expect(result).to eq(100)
  end
end

describe 'Exercise 5' do
  it "Iterates through an array and `puts` each element" do
    STDOUT.should_receive(:puts).with("hi")
    STDOUT.should_receive(:puts).with("there")
    STDOUT.should_receive(:puts).with("timmy")
    Exercises.ex5(["hi","there","timmy"])
  end
end
 
describe 'Exercise 6' do
  it "Updates the last item in the array to 'panda'" do
    result = Exercises.ex6(["fun","games"])
    expect(result).to eq(["fun","panda"])
  end

  it "If the last item is already 'panda', update it to 'GODZILLA' instead" do
    result = Exercises.ex6(["broom", "panda"])
    expect(result).to eq(["broom", "GODZILLA"])
  end
end













