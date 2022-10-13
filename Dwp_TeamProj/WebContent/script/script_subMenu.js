$(function() {
$("a#cart").click(function(){
		window.parent.location.href="/cart/cartList.jsp";
		});
    $("a#wish").click(function(){
		window.parent.location.href="/wishlist/wishlist.jsp";
		});
		$("a#inq").click(function(){
		window.parent.location.href="/bbs_Inquire/list.jsp";
		});
		$("a#mod").click(function(){
		window.parent.location.href="/Member/MemberMod.jsp";
		});
		$("a#del").click(function(){
		window.parent.location.href="/Member/MemberDel.jsp";
		});

});