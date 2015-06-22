ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do

     panel "Recent Statuses" do 
        table_for Status.order("created_at desc").limit(15) do
            column "Status", :content do |status|
                link_to status.content, [:admin,status]
            end
            column "Author", :user
            column :created_at
            column :updated_at
        end
        strong (link_to "View All Statuses", :admin_statuses)
    end

  end # content
end
