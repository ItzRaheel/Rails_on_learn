class ProductListSerializer < ActiveModel::Serialization

attributes :id,:name, :short_description, :quick_summary

def short_description
    object.description.truncate(30) if object.description.present?
end
def quick_summary
    "Product ##{object.id}: #{object.name}"
end

end 