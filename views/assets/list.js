var url = "/www_get_posts"
var ctid = 1
var page_number = 1

$('#more').find('a').click(function(){
	ctid = $(this).attr('ctid')
	$.get(url, {'page_number' : page_number, 'ctid' : ctid}, function(data){
		if (data != '') {
			$('.list:last').after(data)
			page_number += 1
		}
		else {
			$('#more').append("no more")
			$('#more').find('a').remove()
		}
	})

	return false
})
