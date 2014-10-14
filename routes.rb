# list the posts by tag
get '/www/list/:name' do
	@tag 				= params[:name]
	@page_size			= 20
 	@posts 				= www_list @tag, @page_size
	@t[:title]			= @tag
	www_page :www_list
end

# get the post list by ajax
get '/www_get_posts' do
	@tag 				= @qs[:ctid]
	@page_size			= 20
	@page_number		= @qs[:page_number].to_i
 	@posts 				= www_list @tag, @page_size, @page_number
	@posts.count > 0 ? _tpl(:www_list) : ''
end

# fetch a post and display the view as a page
get '/www/page/:cpid' do
	data_markdown_load
	cpid				= params[:cpid]
 	@post 				= Sdb[:www_posts].filter(:cpid => cpid).first

	if @post == nil
		www_error Sl[:'No post']
	else
		@t[:title]			= @post[:title]
		@t[:description]	= www_cut @post[:body], 100
		www_page :www_page
	end
end

# fetch a post and association comments
get '/www/post/:cpid' do
	data_markdown_load
	cpid				= params[:cpid]
 	@post 				= Sdb[:www_posts].filter(:cpid => cpid).first
 	@comments 			= Sdb[:www_comments].filter(:cpid => cpid).reverse_order(:created).all

	if @post == nil
		www_error Sl[:'No post']
	else
		@t[:title]			= @post[:title]
		@t[:description]	= www_cut @post[:body], 100
		www_page :www_post
	end
end

# add a new post
get '/www/edit/post' do
	# navigation
	@nav 				= [
		Sl['Edit'],
		'-',
		Sl['new a post']
	]

	view_form(:www_posts, {
			:layout 		=> :www_layout,
			:tpl 			=> :view_form2,
			:css 			=> 'www/edit.css',
			:action 		=> _url('/www/edit/post'),
		}
	)
end

post '/www/edit/post' do
	data_submit :www_posts
# 	redirect _var(:home, :link)
	redirect _url('/www/list/all')
end

# submit a comment
post '/www/comment' do
	data_submit :www_comments
	redirect back
end

