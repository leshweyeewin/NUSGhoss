ActiveAdmin.register Status do
  actions :all, :except => [:new, :edit]
  permit_params :content, :user_id, :tag_list

  index do
    selectable_column
    id_column
    column "Status", :content
    column "Author", :user
    column "Tags", :tag_list
    column :created_at
    column :updated_at
    actions
  end

  form do |f|
    f.inputs do
      f.input :user
      f.input :tag_list
      f.input :content
    end
    f.actions
  end
end
