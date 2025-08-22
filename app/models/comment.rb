class Comment < ApplicationRecord
  belongs_to :book
  belongs_to :author, optional: true 
  
end
