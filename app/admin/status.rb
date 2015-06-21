ActiveAdmin.register Status do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :content, :user_id
#menu :label => "Blog Posts"

index do
	column :id
	column :content
	column "Author", :user
	column :created_at
	actions
end

#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if resource.something?
#   permitted
# end


end
