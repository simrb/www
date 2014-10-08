/* 
 * == Example
 *
 * html
 * 		ul
 * 			li menu itme
 * 			li menu itme
 * 			li.dropdownitem this is a dropdown menu
 * 				ul.hide.dropdownlist
 * 					li sub menu
 * 					li sub menu
 *
 * js
 * 		== _js("system/js/dropdown")
 *
 */

$(".dropdownitem").hover(function(){
	$hide = $(this).find('.dropdownlist')
	$hide.css('position', 'absolute')
	$hide.css('top', 25)
	$hide.css('left', $(this).offset().left - 10)
	$hide.show()
}, function(){
	$hide = $(this).find('.dropdownlist')
	$hide.hide()
})

