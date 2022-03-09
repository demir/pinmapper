Rails.configuration.to_prepare do
  ActiveRecord::Base.include ActiveRecord::FindByOrderedIds
end
