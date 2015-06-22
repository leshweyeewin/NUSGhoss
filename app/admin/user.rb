ActiveAdmin.register User do

  permit_params :first_name, :last_name, :profile_name, :email, :password, :password_confirmation

  index do
    selectable_column
    id_column
    column :first_name
    column :last_name
    column :profile_name
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column "Member Since", :created_at
    actions
  end

end
