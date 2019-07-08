$(function(){
		longview();
		$(window).scroll(function(){
			var h = $(window).height();
			var scroll = h+window.scrollY;
			if(scroll > h){
				if(scroll >= $('footer').offset().top){
					$("#slidetop").css('right','-50px');
				}else{
					$("#slidetop").css('right','20px');
				}
			}else{
				$("#slidetop").css('right','-50px');
			}
		});
	})

	function longview(){
		$('.longview').click(function(){
			var area = $(this).parents('.hot_sale');
			if(area.height() == 100){
				var heights = area.css('height','auto').height();
				area.css('height','100px');
				area.css({
					height:heights
				});
				$(this).css({
					transform:'rotate(180deg)',
					'-webkit-transform':'rotate(180deg)',
					'-moz-transform':'rotate(180deg)',
					'-o-transform':'rotate(180deg)'
				});
			}else{
				area.css({
					height:'100px'
				});
				$(this).css({
					transform:'rotate(0deg)',
					'-webkit-transform':'rotate(0deg)',
					'-moz-transform':'rotate(0deg)',
					'-o-transform':'rotate(0deg)'
				});
			}
		});
	}
	
	function slidetop(){
		var h = $(window).height();
		var scroll = h+window.scrollY;
		if(scroll > h){
			if(scroll >= $('footer').offset().top){
				$("#slidetop").css('right','-50px');
			}else{
				$("#slidetop").css('right','20px');
			}
		}else{
			$("#slidetop").css('right','-50px');
		}
	}