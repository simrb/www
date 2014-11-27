helpers do

	def _time time
		@current_time ||= Time.now
		if @current_time.year == time.year
			days = @current_time.yday - time.yday
			if days == 0 
				min	= @current_time.min - time.min
				hours = @current_time.hour - time.hour
				if hours == 0
					if min < 1
						"just now"
					else
						"#{min} min ago"
					end
				elsif hours == 1
					"#{min + 60} min ago"
				else
					"#{hours} hour ago"
				end
			else
				"#{days} days ago"
			end
		else
			time.strftime("%Y-%m-%d, %H:%M:%S")
		end
	end

	def www_list tag, size, number = 0
		ds = tag == 'all' ? Sdb[:www_posts] : Sdb[:www_posts].filter(:cpid => data_tag_ids(:www_posts, tag))
		ds.limit(size, size * number).reverse_order(:cpid).all
	end

	def www_cut bodys, size = 400
		body = bodys.size > size ? (bodys[0, size] + '...') : bodys
	end

	def www_page name
		@t[:title] = _var(:title, :www) if @t[:title] == nil
# 		@t[:title] = @t[:title] == nil ? _var(:title, :www) : (@t[:title] + ' - ' + _var(:title, :www)) 
#
		_tpl name, _var(:layout, :www).to_sym, :www
	end

	def www_error str
		@www_error = str
		_tpl :www_error, _var(:layout, :www).to_sym, :www
	end

	def www_author
		user_login? ? user_info[:name] : (_ip[0, (_ip.size - 1)] + '*')
	end

	def user_page name
		@t[:title] = _var(:title, :www) if @t[:title] == nil
		_tpl name, _var(:layout, :www).to_sym, :www
	end

end
