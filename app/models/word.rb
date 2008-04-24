class Word < DataMapper::Base
  property :name, :string
  property :interword, :string
  property :to_word, :string
  property :description, :text

  validates_presence_of :name, :interword
end
