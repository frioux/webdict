class Word < DataMapper::Base
  property :name, :string
  property :to_word, :string
  property :description, :text

  validates_presence_of :name, :to_word
end
