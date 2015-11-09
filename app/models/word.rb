class Word
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  include Mongoid::Timestamps::Updated

  field :language, type: String
  field :chinese, type: String
  field :korean, type: String
  field :formality, type: String
  field :romanization, type: String
  field :english, type: String
  field :termDateJSON, type: String
end
