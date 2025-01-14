require 'rails_helper'

RSpec.describe Lab do
  it {should have_many :scientists}
  it {should have_many(:experiments).through(:scientists)}

  before(:each) do
    @radcliffe = Lab.create!(name: "Radcliffe College")
    @other = Lab.create!(name: "Other")

    @payne = Scientist.create(name: "Cecila Payne", specialty: "Astronomy", university: "Harvard", lab: @radcliffe)
    @russell = Scientist.create(name: "Russell", specialty: "Plagarism", university: "other", lab: @radcliffe)
    @sergei = Scientist.create(name: "Sergei Gaposchkin", specialty: "Plagarism", university: "other", lab: @radcliffe)

    @composition = Experiment.create(name: "Composition", objective: "what a star is made of", num_months: 3)
    @break = Experiment.create(name: "Break Glass Ceiling", objective: "be awesome", num_months: 24)
    @stars = Experiment.create(name: "Stars", objective: "more star stuff", num_months: 6)
    @space = Experiment.create(name: "Space", objective: "everything", num_months: 9)
    @planets = Experiment.create(name: "Planets", objective: "planets", num_months: 5)
    @credit = Experiment.create(name: "Payne's paper", objective: "stealing", num_months: 7)
  
    ExperimentScientist.create(scientist: @payne, experiment: @composition)
    ExperimentScientist.create(scientist: @payne, experiment: @break)
    ExperimentScientist.create(scientist: @payne, experiment: @stars)
    ExperimentScientist.create(scientist: @payne, experiment: @space)

    ExperimentScientist.create(scientist: @russell, experiment: @credit)

    ExperimentScientist.create(scientist: @sergei, experiment: @space)
    ExperimentScientist.create(scientist: @sergei, experiment: @stars)
    ExperimentScientist.create(scientist: @sergei, experiment: @planets)
  end

  describe "with_count" do
    it "makes a virtual count column and displays them in order from great count to least" do
      expect(@radcliffe.with_count.first.count).to eq(4)
      expect(@radcliffe.with_count).to eq([@payne, @sergei, @russell])
    end
  end
end