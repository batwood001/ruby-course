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

describe 'Exercise 7' do
  it "If the string `str` exists in the array, add `str` to the end of the array" do
    result = Exercises.ex7(["porridge", 2, "str"], "str")
    expect(result).to eq(["porridge", 2, "str", "str"])
  end

  it "ditto" do
    result = Exercises.ex7(["porridge", 2, "fun"],"str")
    expect(result).to eq(["porridge", 2, "fun"])
  end

  it "ditto" do
    result = Exercises.ex7(["str"],"str")
    expect(result).to eq(["str","str"]) #There could really be so many more tests
  end
end

describe 'Exercise 8' do
  it "`people` is an array of hashes. Each hash is like the following: 
    { :name => 'Bob', :occupation => 'Builder' }
    Iterate through `people` and print out their name and occupation." do
    STDOUT.should_receive(:puts).with("Bob, Builder")
    STDOUT.should_receive(:puts).with("Carl, Climber")

    Exercises.ex8([{ :name => "Bob", :occupation => "Builder"}, { :name => "Carl", :occupation => "Climber"}])
  end
end

describe 'Exercise 9' do
  it "Returns `true` if the given time is in a leap year, otherwise returns `false`" do
    result = Exercises.ex9(1837)
    expect(result).to eq(false)
  end

  it "ditto" do
    result = Exercises.ex9(1836)
    expect(result).to eq(true)
  end

   it "ditto" do
    result = Exercises.ex9(1953)
    expect(result).to eq(false)
  end

   it "ditto" do
    result = Exercises.ex9(1952)
    expect(result).to eq(true)
  end
end

# describe 'Exercise 10' do
#   it "returns 'happy hour' if it is between 4 and 6pm, otherwise returns 'normal prices'" do
#     result = 

# describe 'Exercise 11' do
#   it ... do

#   end
# end

describe 'Exercise 12' do
  it "Raises an error" do
    expect { Exercises.ex12 }.to raise_error
  end
end













