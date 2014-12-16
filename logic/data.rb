data :www_types do
	{
		:wtid				=>	{
			:primary_key	=>	true
		},
		:name				=>	{},
	}
end

data :www_posts do
	{
		:cpid				=>	{
			:primary_key	=>	true
		},
		:title				=>	{},
		:body				=>	{
			:type			=>	'Text',
			:editor			=>	true
		},
		:wtid				=>	{
			:assoc_one		=>	[:www_types, :name],
			:label			=>	'type'
		},
		:uid				=>	{
			:form_type		=>	:hide,
			:default		=>	user_info[:uid]
		},
		:created			=>	{
			:default		=>	Time.now
		},
		:changed			=>	{
			:default		=>	Time.now
		},
	}
end

data :www_comments do
	{
		:ccid				=>	{
			:primary_key	=>	true
		},
		:cpid				=>	{
			:default		=>	1,
			:form_type		=>	:hide
		},
		:uid				=>	{
			:form_type		=>	:hide,
			:default		=>	user_info[:uid]
		},
		:body				=>	{
			:label			=>	'Comment',
			:form_type		=>	:textarea
		},
		:author				=>	{
			:default		=>	www_author
		},
		:created			=>	{
			:default		=>	Time.now
		},
	}
end

valid :www_comments do | f |

	user_mark :www_comments, 30, Sl['you have not send the comment in 30 seconds']

	if f[:body] and f[:body].strip == ''
		_throw Sl[:'the content is not null']
	end

end

