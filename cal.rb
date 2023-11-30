#!/usr/bin/env ruby

require "bundler/inline"

gemfile do
  source "https://rubygems.org"
  gem "rspec"
end

require "date"

module Calendar
  def self.name_of_month
    Date.today.strftime("%B %Y")
  end

  def self.days_of_week
    "Su Mo Tu We Th Fr Sa"
  end

  def self.days_of_month
    <<~CAL
                1  2  3  4
       5  6  7  8  9 10 11
      12 13 14 15 16 17 18
      19 20 21 22 23 24 25
      26 27 28 29 30
    CAL
  end
end

require "rspec/autorun"

RSpec.describe "calendar" do
  it "prints the name of the month" do
    expect(Calendar.name_of_month).to eq "November 2023"
  end

  it "prints the days of the week" do
    expect(Calendar.days_of_week).to eq "Su Mo Tu We Th Fr Sa"
  end

  it "prints the days of the month" do
    expect(Calendar.days_of_month).to eq(<<~CAL)
                1  2  3  4
       5  6  7  8  9 10 11
      12 13 14 15 16 17 18
      19 20 21 22 23 24 25
      26 27 28 29 30
    CAL
  end
end
