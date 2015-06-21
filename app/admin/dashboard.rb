ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do

     panel "Recent Statuses" do 
        table_for Status.order("id desc").limit(15) do
            column :id
            column "Status Content", :content do |status|
                link_to status.content, [:admin,status]
            end
            column "Author", :user
            column :created_at
        end
        strong (link_to "Show All Statuses", :admin_statuses)
    end

  end # content
end
