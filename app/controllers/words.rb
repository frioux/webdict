class Words < Application

  def index
    @title = "Index"
    @words = Word.paginate :page => params[:page], :per_page => 20, :order => 'name COLLATE NOCASE'
    render
  end

  def show
    @word = Word.find(params[:id])
    @title = @word.name
    render
  end

  def find
    @title = "Find word"
    render
  end

  def speed_search
    @words = Word.all(:to_word.like => "%#{params[:word]}%").paginate :page => params[:page], :per_page => 20, :order => 'name COLLATE NOCASE'
    @title = params[:word]
    if @words.size == 1
      @word = @words.first
      render :template => 'words/show.html'
    else
      render :template => 'words/index.html'
    end
  end

  def eng_search
    @words = Word.all(:name.like => "%#{params[:word]}%").paginate :page => params[:page], :per_page => 20, :order => 'name COLLATE NOCASE'
    @title = params[:word]
    render :template => 'words/index.html'
    if @words.size == 1
      @word = @words.first
      render :template => 'words/show.html'
    else
      render :template => 'words/index.html'
    end
  end

  def speed_find
    @word = Word.first(:to_word => params[:word])
    @title = @word.to_word
    render :template => 'words/show.html'
  end

  def eng_find
    @word = Word.first(:name => params[:word])
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
      render :template => 'words/form.html'
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

  def delete
    @word = Word.find(params[:word])
    @word.destroy!
    redirect url(:index)
  end

  def import
    @title = "Import Dictionary"
    return render unless request.post?
    params[:file][:tempfile].to_a.map {|v| v.chomp.split("\t") }.delete_if {|v| v == [] }.each do |word|
      Word.new(:name => word[1], :interword => word[0], :to_word => word[0].delete("-")).save
    end
    redirect(url(:index))
  end


end
