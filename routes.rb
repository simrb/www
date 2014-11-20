# list the posts by tag
get '/www/list/:name' do
	@tag 				= params[:name]
	@page_size			= 20
 	@posts 				= www_list @tag, @page_size
	@t[:title]			= @tag + ' - ' + _var(:title, :www)
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
			:layout 		=> _var(:layout, :www),
			:tpl 			=> :view_form2,
			:action 		=> _url('/www/edit/post'),
		}
	)
end

post '/www/edit/post' do
	data_submit :www_posts
	cpid = @qs[:cpid] ? @qs[:cpid] : (params[:cpid] ? params[:cpid] : nil)
	if cpid == nil
		redirect _url('/www/list/all')
	else
		redirect _url("/www/post/#{cpid}")
	end
end


