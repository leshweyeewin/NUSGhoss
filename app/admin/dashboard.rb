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

    panel "Popular Statuses" do 
        table_for Status.joins("LEFT OUTER JOIN Votes ON votes.votable_id = statuses.id").group("statuses.id").order("COUNT(votes.id) DESC").having("COUNT(votes.id) != 0").limit(15) do
            column "Status", :content do |status|
                link_to status.content, [:admin,status]
            end
            column "Author", :user
            column :created_at
            column :updated_at
        end
        /
        table_for ActsAsVotable::Vote.order(:vote_weight).limit(15) do
            column "Status", :votable_id do |vote|
                link_to Status.find(vote.votable_id).content, [:admin,Status.find(vote.votable_id)]
            end
            column "Voters", :voter_id do |vote|
                link_to User.find(vote.voter_id).full_name, [:admin, User.find(vote.voter_id)]
            end
        end/
    end

    panel "Reported Statuses" do 
        table_for Status.where(reported: true).order("created_at desc") do
            column "Status", :content do |status|
                link_to status.content, [:admin,status]
            end
            column "Author", :user
            column :created_at
            column :updated_at
        end
    end

    panel "Popular Tags" do 
        table_for ActsAsTaggableOn::Tag.most_used(15).where.not(:taggings_count => 0) do
            column "Tag", :name 
        end
    end
    
  end # content
end
