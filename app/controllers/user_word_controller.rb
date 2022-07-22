class UserWordController < ApplicationController
  before_action :validate_api_key
  before_action :check_daily_limit
  before_action :load_word, except: [:getAWord]

  def getAWord
    all_ids = AllWord.ids.shuffle!.first
    word = AllWord.find_by(id: all_ids).word_name
    render json: word
  end
 
  def getADefinition
    definitions = @word.definitions.map { |definition| definition['text'] }
    render json: { word: @word.word_name, definitions: definitions }
  end

  def getAExample
    current_word = @user_params[:word]
    word_id = AllWord.find_by(word_name: current_word).id
    @example = Example.where(all_word_id: word_id)
    example_arr = []
    @example.each do |example|
      example_arr.push(example["text"])
    end
    render json: {"word": current_word, "examples": example_arr}
  end

  def getSynonym
    current_word = @user_params[:word]
    word_id = AllWord.find_by(word_name: current_word).id
    @synonym = Synonym.where(all_word_id: word_id)
    synonym_arr = []
    @synonym.each do |synonym|
      synonym_arr.push(synonym["text"])
    end
    render json: {"word": current_word, "synonyms": synonym_arr}
  end

  def getAntonym
    current_word = @user_params[:word]
    word_id = AllWord.find_by(word_name: current_word).id
    @antonym = Antonym.where(all_word_id: word_id)
    antonym_arr = []
    @antonym.each do |antonym|
      antonym_arr.push(antonym["text"])
    end
    render json: {"word": current_word, "antonyms": antonym_arr}
  end

  private

  def load_word
    @word = AllWord.find_by(word_name: params[:word])
    if @word.nil?
      render json: {error: 'Invalid word'}, status: 401
    end
  end

  def validate_api_key
    @api_key = AllKey.find_by(api_key: params[:api_key])

    if @api_key.nil?
      render json: {error: 'Invalid API key'}, status: 401
    end
  end

  def check_daily_limit
    if @api_key.daily_limit_reached?
      return render json: { error: 'Daily limit reached' }, status: 401
    end

    @api_key.increment_usage!
  end   
end