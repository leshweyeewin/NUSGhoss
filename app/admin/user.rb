ActiveAdmin.register User do
  actions :all, :except => [:new, :edit]
  permit_params :ivle_id, :ivle_name, :profile_name, :email, :password, :password_confirmation

  index do
    selectable_column
    id_column
    column "User ID", :ivle_id
    column "User Name", :ivle_name
    column :profile_name
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column "Member Since", :created_at
    actions
  end
  
  filter :ivle_id
  filter :ivle_name
  filter :profile_name
  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs "User Details" do
      f.input :profile_name
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end
end
