class GamesController < ApplicationController
    def new
        @letters = Array.new(10) { ('A'..'Z').to_a.sample }
    end

    def score
        @letters = params[:letters]
        @word = (params[:word] || "" ).upcase
        @included = included?(@word, @letters)
        @english_word = english_word?(@words)
    end

    private 
    
    def included?(word, letters)
        word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
    end

    def english_word?(word)
        response = open("https://wagon-dictionary.herokuapp.com/#{word}")
        json = JSON.parse(response.read)
        json('found')
    end
end
