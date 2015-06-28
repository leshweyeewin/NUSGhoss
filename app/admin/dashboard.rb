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

    panel "Popular Tags" do 
        table_for ActsAsTaggableOn::Tag.most_used(15) do
            column "Tag", :name 
        end
    end

    panel "Facilities" do 
        table_for Facility.order("created_at desc").limit(15) do
            column "Facility", :name do |facility|
                link_to facility.name, [:admin,facility]
            end
            column :created_at
            column :updated_at
        end
        strong (link_to "View All Facilities", :admin_facilities)
    end
  end # content
end
