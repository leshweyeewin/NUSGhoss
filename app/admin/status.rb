ActiveAdmin.register Status do
permit_params :content, :user_id


  index do
    selectable_column
    id_column
    column :content
    column "Author", :user
    column :created_at
    column :updated_at
    actions
  end

end
