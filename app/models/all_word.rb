class AllWord < ApplicationRecord
    has_many :antonyms
    has_many :synonyms
    has_mane :definitions
    has_many :examples
end
