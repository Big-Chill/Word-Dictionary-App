class AllWord < ApplicationRecord
  has_many :antonyms
  has_many :synonyms
  has_many :definitions
  has_many :examples
end
