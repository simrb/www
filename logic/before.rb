
# before '/file/*' do
# 	if request.path == '/file/upload'
# 		view_level? _var(:upload_level, :file)
# 	end
# end

# before '/www/edit/post' do
# 	view_login?
# end

before '/view/operate/*' do
	if params[:_name] == 'www_comments'
		redirect back unless _var3(:comment_open, :www)
	end
end

