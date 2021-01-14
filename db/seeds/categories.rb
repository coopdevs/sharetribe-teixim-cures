category = Category.find_or_create_by(url: 'mobiliario') do |category|
  category.community_id = 1
end
category.translations.find_or_create_by(name: 'Mobiliari') do |translation|
  translation.locale = 'ca'
end
category.translations.find_or_create_by(name: 'Mobiliario') do |translation|
  translation.locale = 'es'
end
