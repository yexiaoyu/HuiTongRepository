function initMenu() {
	$('#menulist ul').hide();
	$('#menulist ul:first').show();
	$('#menulist li a').click(function() {
		var checkElement = $(this).next();
		if ((checkElement.is('ul')) && (checkElement.is(':visible'))) {
			return false;
		}
		if ((checkElement.is('ul')) && (!checkElement.is(':visible'))) {
			$('#menulist ul:visible').slideUp('fast');
			checkElement.slideDown('fast');
			return false;
		}
	});
	//高亮当前选中的菜单
	$('#menulist li').find("a").click(function(){
		$('#menulist li').find(".light").removeClass("light");
		$(this).parent().addClass("light");
	});
}
$(document).ready(function() {
	initMenu();
});