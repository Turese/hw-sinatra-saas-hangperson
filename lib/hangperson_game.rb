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
    @guesses = ""
    @wrong_guesses = ""
    @word_with_guesses = "-" * @word.length
    return self
  end

  def guess(letter)
    if letter == nil or letter == "" or !(letter =~ /[A-Za-z]/)
      raise(ArgumentError, "Must guess a single letter.")
    end
    letter = letter.downcase
    if guesses.include? letter or wrong_guesses.include? letter
      return false
    end
    if @word.include? letter 
      letterindices = (0 ... word.length).find_all { |i| word[i] == letter }
      letterindices.each do |index|
        word_with_guesses[index] = letter
      end
      setguesses(letter)
    else 
      setwrong(letter)
    end
    return true
  end

  def setguesses(letter)
    self.guesses += letter unless guesses == nil else guesses = letter
  end

  def setwrong(letter)
    self.wrong_guesses += letter unless wrong_guesses == nil else wrong_guesses = letter
  end

  def check_win_or_lose() 
    if @word_with_guesses == @word 
      return :win
    elsif @wrong_guesses.length >= 7
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
