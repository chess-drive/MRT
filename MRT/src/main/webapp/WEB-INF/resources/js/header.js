

/* ========================================== 
scrollTop() >= 300
Should be equal the the height of the header
https://codepen.io/JGallardo/pen/lJoyk
========================================== */

/*
      $(document).ready(function(){
         $(".header").load("/view/header.html")     
      });

	  $(document).ready(function(){
         $(".footer").load("/view/footer.html")     
      });

*/


/*(document).ready(function(){
  
  $(function(){
  
    $(window).scroll(function() {
  
      var position = $(window).scrollTop();
  
      if (position == 0) {
  
        $(".clip_right").stop().animate({"top":-position+235+"px"},500);
  
      }else if(position > 0 && position > 230){
  
        $(".clip_right").stop().animate({"top":position+400-115+"px"},500);
  
      }else if (position < 231 ) {
  
        $(".clip_right").stop().animate({"top":position+0+"px"},500);
  
      }
  
    });
  
  });
  
});



var slidemenu_X = 240; //상단 제한 값
var slidemenu_Y = 300; //하단 제한 값


var isDOM = (document.getElementById ? true : false);
var isIE4 = ((document.all && !isDOM) ? true : false);
var isNS4 = (document.layers ? true : false);
var isNS = navigator.appName == "Netscape";


function getRef(id) {
	if (isDOM) return document.getElementById(id);
	if (isIE4) return document.all[id];
	if (isNS4) return document.layers[id];
}

function getSty(id) {
	x = getRef(id);
	return (isNS4 ? getRef(id) : getRef(id).style);
}

function moveRightEdge() {
	var yMenuFrom, yMenuTo, yOffset, timeoutNextCheck;

	if (isNS4) {
		yMenuFrom   = divMenu.top;
		yMenuTo     = windows.pageYOffset + slidemenu_X;   // 위쪽 위치
	} else if (isDOM) {
		yMenuFrom   = parseInt (divMenu.style.top, 10);
		yMenuTo     = (isNS ? window.pageYOffset : document.body.scrollTop) + slidemenu_X; // 위쪽 위치
	}
	timeoutNextCheck = 30;
	
	divMenu_H = document.getElementById('divMenu');
	limit_H = (parseInt(document.body.scrollHeight)-slidemenu_Y)-parseInt(divMenu_H.offsetHeight);
	divMenu_t = parseInt(divMenu.style.top) ;
	if (yMenuFrom != yMenuTo) {
		yOffset = Math.ceil(Math.abs(yMenuTo - yMenuFrom) / 20);
		if (yMenuTo < yMenuFrom){
			yOffset = -yOffset;
		}
		if (isNS4){
			if(yOffset > 0){
				if ( divMenu_t < limit_H) {
					divMenu.top += yOffset;
				}
			}else{
				divMenu.top += yOffset;
			}
			
		}else if (isDOM){
			if(yOffset > 0){
				if ( divMenu_t < limit_H) {
					divMenu.style.top = parseInt (divMenu.style.top) + yOffset;
				}
			}else{
				divMenu.style.top = parseInt (divMenu.style.top) + yOffset;
			}
		}
		timeoutNextCheck = 10;
	}

	setTimeout ("moveRightEdge()", timeoutNextCheck);
}


if (isNS4) {	
	var divMenu = document["divMenu"];
	divMenu.top = slidemenu_X;
	divMenu.visibility = "visible";
	moveRightEdge();
} else if (isDOM) {
	var divMenu = getRef('divMenu');	
	divMenu.style.top = slidemenu_X;	
	divMenu.style.visibility = "visible";	
	moveRightEdge();
}


*/





//

function change1(obj){
	obj.style.background = '#0068FF';
	obj.style.color = 'white';
}


$(function(){
    $('td .button_none p').each(function(){
        if ($(this).text().length >20)
        $(this).html($(this).text().substr(0,20)+"..");
    });

	 $('td.linkText a').each(function(){
        if ($(this).text().length >30)
        $(this).html($(this).text().substr(0,30)+"..");
    });
	mobileMenuClick();//모바일 메뉴 클릭
});

//모바일 메뉴 클릭
function mobileMenuClick(){
	$('.header').find('.btn_menu').on('click', function(){
		if(!$(this).hasClass('on')){
			$(this).addClass('on');
			$('.header').find('.sub').stop().slideDown(300);
		} else {
			$(this).removeClass('on');
			$('.header').find('.sub').stop().slideUp(300);
		}
	});
	//메뉴 이외 클릭
	$('html').on('click', function(e){
		var winW = $(window).width();
		if(!$(e.target).is('.header, .header *') && winW < 1020){
			$('.header').find('.btn_menu').removeClass('on');
			$('.header').find('.sub').stop().slideUp(300);
		}
	});
}