#!/usr/bin/env ruby

require "bundler/inline"

gemfile do
  source "https://rubygems.org"
  gem "rspec"
end

require "date"

module Calendar
  def self.name_of_month(year: Date.today.year, month: Date.today.month)
    "   #{Date.new(year,month).strftime("%B %Y")}"
  end

  def self.days_of_week
    "Su Mo Tu We Th Fr Sa"
  end

  def self.days_of_month(year: Date.today.year, month: Date.today.month)
    <<~CAL
                1  2  3  4
       5  6  7  8  9 10 11
      12 13 14 15 16 17 18
      19 20 21 22 23 24 25
      26 27 28 29 \e[31m30\e[0m
    CAL
  end

  def self.first_line_of_days_of_month(day: 0)
    " 1  2  3  4  5  6  7"
  end
end

require "rspec/autorun"

RSpec.describe "calendar" do
  it "prints the name of the month" do
    expect(Calendar.name_of_month).to eq "   November 2023"
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
      26 27 28 29 \e[31m30\e[0m
    CAL
  end

  it "prints the month for the year and month passed in" do
    expect(Calendar.name_of_month(year: 2020, month: 12)).to eq "   December 2020"
  end

  it "prints the days for the year and month passed it" do
    expect(Calendar.days_of_month(year: 2023, month: 12)).to eq(<<~CAL)
                      1  2
       3  4  5  6  7  8  9
      10 11 12 13 14 15 16
      17 18 19 20 21 22 23
      24 25 26 27 28 29 30
      31
    CAL
  end

  it "returns rest of the days of the week including whitespace before hand" do
    expect(Calendar.first_line_of_days_of_month(day: 1)).to eq(" 1  2  3  4  5  6  7")
    expect(Calendar.first_line_of_days_of_month(day: 2)).to eq("    1  2  3  4  5  6")
    expect(Calendar.first_line_of_days_of_month(day: 3)).to eq("       1  2  3  4  5")
    expect(Calendar.first_line_of_days_of_month(day: 4)).to eq("          1  2  3  4")
    expect(Calendar.first_line_of_days_of_month(day: 5)).to eq("             1  2  3")
    expect(Calendar.first_line_of_days_of_month(day: 6)).to eq("                1  2")
    expect(Calendar.first_line_of_days_of_month(day: 7)).to eq("                   1")
  end
end

puts Calendar.name_of_month
puts Calendar.days_of_week
puts Calendar.days_of_month
