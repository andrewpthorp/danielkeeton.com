ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }

  content :title => "Dashboard" do
    columns do
      column do
        panel "Recent Blog Posts" do
          ul do
            Post.order("created_at DESC").limit(5).each do |post|
              li link_to(post.title, admin_post_path(post))
            end
          end
        end
      end

      column do
        panel "Recent Listings" do
          ul do
            Listing.order("created_at DESC").limit(5).each do |listing|
              li link_to(listing.title, admin_listing_path(listing))
            end
          end
        end
      end
    end
  end
end
