require 'spec_helper'

describe "parse file" do
  let (:test_file) { "spec/menu.txt"}

  before { @file = Parser.new(test_file)}

  it "should extract the target price" do
    expect(@file.target).to eq(1765)
  end

  it "should return a hash of menu items" do
    expect(@file.item_hash).to be_kind_of(Hash)
  end

  it "should correctly parse the target price" do
    file_price = File.open(test_file, &:readline)
    converted_price = Permutationator.currency_to_number(file_price.strip)
    expect(converted_price).to eq(@file.target)
  end
end

describe "a permutation" do

  let (:test_file) { "spec/menu.txt"}
  let (:target) { 1420 }

  before  do
    @file = Parser.new(test_file)
    @target = @file.target
    @menu_hash = @file.item_hash
    @perm = Permutationator.new(@file.item_hash, target)
  end

  subject { @perm }

  it "should sum the array" do
    expect(@perm.instance_eval{ sum_values([420, 420, 355, 355, 215]) }).to eq(1765)
  end

  it "should return an array of possible combinations" do
    expect(@perm.combos).to be_kind_of(Array)
  end

  it "should convert a string currency to an integer" do
    expect(Permutationator.currency_to_number('$15.25')).to eq(1525)
  end

  it "should produce an Array for the solution" do
    combos = @perm.combos
    expect(@perm.evaluate(combos)).to be_kind_of(Array)
  end

  it "should give the correct answer" do
    combos = @perm.combos
    answer = @perm.evaluate(combos)
    expect(answer.inject(:+)).to eq(target)
  end

  it "should return false if no valid combinations" do
    @no_answer = Permutationator.new(@menu_hash, 1506)
    combos = @no_answer.combos
    expect(@no_answer.evaluate(combos)).to eq(false)
  end
end
