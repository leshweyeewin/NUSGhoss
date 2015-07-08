ActiveAdmin.register Status do
  actions :all, :except => [:new]
  permit_params :content, :user_id, :reported, :tag_list

  index do
    selectable_column
    id_column
    column "Status", :content
    column "Author", :user
    column "Tags", :tag_list
    column "Reported?", :reported 
    column :created_at
    column :updated_at
    actions
  end

  form do |f|
    f.inputs do
      f.input :reported
    end
    f.actions
  end
end
