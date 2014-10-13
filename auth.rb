
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
