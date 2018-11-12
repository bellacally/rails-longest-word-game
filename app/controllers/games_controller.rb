require 'json'
require 'open-uri'
class GamesController < ApplicationController

  # def initialize

  # end

  def new
    @letters = Array.new(10){("A".."Z").to_a.sample}
  end

  def score
    @word = params[:word]
    @letters = params[:letters]
    if included?(@word, @letters)
      if english_words?(@word)
        @scores = "yes"
      else
        @scores = "not word"
      end
    else
      @scores = "not in grid"
    end
  end

  def english_words?(word)
    file= "https://wagon-dictionary.herokuapp.com/#{word}"
    serialized_score = open(file).read
    scores = JSON.parse(serialized_score)
    scores['found']
  end


private
  def included?(word, letters)
      word_letters = word.split
      word_letters.each do |letter|
        unless word_letters.count(letter) == letters.split(" ").count(letter)
          return false
        end
      end
      return true
    end
  end
