class ProductDetailSerializer < ActiveModel::Serializer
  # Full data for single product view
  attributes :id, :name, :description, :created_at, :updated_at, 
             :formatted_date, :character_count, :word_count

  def formatted_date
    object.created_at.strftime("%B %d, %Y at %I:%M %p")
  end

  def character_count
    object.description&.length || 0
  end

  def word_count
    object.description&.split&.length || 0
  end
end