
# before '/file/*' do
# 	if request.path == '/file/upload'
# 		view_level? _var(:upload_level, :file)
# 	end
# end

#['/view/operate', '/admin/*', '/www/edit/post', '/www/comment'].each do | path |
['/view/operate', '/admin/*', '/www/edit/post'].each do | path |
	before path do
		view_login?
# 		view_level? _var(:form_submit_level)
	end
end

before '/www/comment' do
	unless _var(:www_comment_open) == 'on'
		redirect back
	end
end

before '/view/operate' do
	if params[:_name] == 'www_posts'
		# set the allowed level of submit post
	else
		view_level? _var(:admin_level)
	end
end

before '/admin/*' do
	view_level? _var(:admin_level)
end
