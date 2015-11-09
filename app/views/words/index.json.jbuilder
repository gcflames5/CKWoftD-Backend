json.array!(@words) do |word|
  json.extract! word, :id, :language, :chinese, :korean, :formality, :romanization, :english, :termDateJSON
  json.url word_url(word, format: :json)
end
