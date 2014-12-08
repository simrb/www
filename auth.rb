
# before '/file/*' do
# 	if request.path == '/file/upload'
# 		view_level? _var(:upload_level, :file)
# 	end
# end

before '/www/edit/post' do
	view_login?
end

before '/view/operate/*' do
	if params[:_name] == 'www_posts'
		view_level? _var(:post_level, :www)
	elsif params[:_name] == 'www_comments'
		if _var3(:comment_open, :www)
			view_level? _var(:comment_level, :www)
		else
			redirect back
		end
	else
 		view_level? _var(:view_post_level)
	end
end

