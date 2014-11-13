
# before '/file/*' do
# 	if request.path == '/file/upload'
# 		view_level? _var(:upload_level, :file)
# 	end
# end

# for user login
#['/view/operate', '/admin/*', '/www/edit/post', '/www/comment'].each do | path |
# ['/admin/*', '/www/edit/post'].each do | path |
# 	before path do
# 		view_login?
# 	end
# end

before '/www/edit/post' do
	view_login?
end

before '/view/operate' do
	if params[:_name] == 'www_posts'
		view_level? _var(:www_post_level)
	elsif params[:_name] == 'www_comments'
		if _var3(:www_comment_open)
			view_level? _var(:www_comment_level)
		else
			redirect back
		end
	else
 		view_level? _var(:view_post_level)
	end
end

before '/admin/*' do
	view_level? _var(:admin_level)
end
