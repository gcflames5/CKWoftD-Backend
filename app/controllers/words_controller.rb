class WordsController < ApplicationController
  before_action :set_word, only: [:show, :edit, :update, :destroy]
  skip_before_filter  :verify_authenticity_token
  # GET /words
  # GET /words.json
  def index
    @words = Word.all
  end

  # GET /words/1
  # GET /words/1.json
  def show
  end

  # GET /words/new
  def new
    @word = Word.new
  end

  # GET /words/1/edit
  def edit
  end

  # POST /words
  # POST /words.json
  def create
    @word = Word.new(word_params)
    @word.updated_at = @word.termDateJSON.to_date
    respond_to do |format|
      if @word.save
        format.html { redirect_to @word, notice: 'Word was successfully created.' }
        format.json { render json: [@word.id.to_s, @word.created_at] }
      else
        format.html { render :new }
        format.json { render json: @word.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /words/1
  # PATCH/PUT /words/1.json
  def update
    respond_to do |format|
      if @word.update(word_params)
        format.html { redirect_to @word, notice: 'Word was successfully updated.' }
        format.json { render :show, status: :ok, location: @word }
      else
        format.html { render :edit }
        format.json { render json: @word.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /words/1
  # DELETE /words/1.json
  def destroy
    success = @word.destroy
    respond_to do |format|
      format.html { redirect_to words_url, notice: 'Word was successfully destroyed.' }
      format.json { render json: { status: success }
    end
  end

  def fetch_new
    id = params[:last_id]
    to_return = Array.new
    if params[:last_id] == -1
      to_return = Word.all
    else
      words = Word.order_by(:created_at.asc)
      words.reverse_each do |word|
        break if id == word.id.to_s
        to_return << word
      end
    end
    render json: to_return.map{ |word| {id: word.id.to_s, language: word.language, chinese: word.chinese, korean: word.korean, formality: word.formality, romanization: word.romanization, english: word.english, termDateJSON: word.termDateJSON, created_at: word.created_at } }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_word
      @word = Word.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def word_params
      params.require(:word).permit(:language, :chinese, :korean, :formality, :romanization, :english, :termDateJSON)
    end
end
