class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.


  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses
  attr_accessor :word_with_guesses


  # Get a word from remote "random word" service
  def initialize()
    return initialize(self.get_random_word())
  end
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = 0
    @word_with_guesses = '-' * @word.length
    return self
  end

  def self.guess(letter)
    if guesses.include? letter
      return
    end
    if @word.include? letter 
      word_with_guesses[@word.index(letter)] = letter
    else 
      wrong_guesses += letter
    end
    guesses += letter
  end

  def self.check_win_or_lose() 
    if @word_with_guesses == @word 
      return :win
    elsif @wrong_guesses >= 7
      return :lose
    else
      return :play
    end
  end

  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end

end
