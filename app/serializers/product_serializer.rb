class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :description,:product_url, :summary

  def product_url
    Rails.application.routes.url_helpers.api_v1_product_url(object,host: 'localhost', port: 3000)
  end
  def summary 
    return "NO description avaible " if object.description.blank?
    if object.description.length > 50
       "#{object.description.truncate(50)} ..."
    else
      object.description
    end
  end
end
