class Words < Application

  def index
    @title = "Index"
    @words = Word.find(:all).sort_by { |o| o.name }
    render
  end

  def show
    @word = Word.find(params[:id])
    @title = @word.name
    render
  end

  def find
    render
  end

  def speed_find
    @word = Word.find(:first, :conditions => ['to_word = ?', params[:word]])
    @title = @word.to_word
    render :template => 'words/show.html'
  end

  def eng_find
    @word = Word.find(:first, :conditions => ['name = ?', params[:word]])
    @title = @word.name
    render :template => 'words/show.html'
  end

  def edit
    @header = "Editing a word"
    @title = "Editing a word"
    @word   = Word.find(params[:id])
    render :template => 'words/form.html'
  end

  def update
    @word = Word.find(params[:id])
    if @word.update_attributes(params[:word])
      redirect url(:word, @word)
    else
      render :template => 'words/word_form.html'
    end
  end

  def new
    @title = "Adding a New Word"
    @header = "Adding a new word"
    @word = Word.new
    render :template => 'words/form.html'
  end

  def create
    @word = Word.new(params[:word])
    if @word.save
      redirect url(:word,@word)
    else
      render :action =>'new'
    end
  end


end
