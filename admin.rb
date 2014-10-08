get '/admin/www' do
	@posts 		= Sdb[:www_posts].count
	@comments 	= Sdb[:www_comments].count
	admin_page :www_admin
end

