jQuery(function($){

'use strict';

var CHARIOT = window.CHARIOT || {};

/* ==================================================
   Drop Menu
================================================== */

CHARIOT.subMenu = function(){
	$('#menu ul').supersubs({
		minWidth: 12,
		maxWidth: 27,
		extraWidth: 0 // set to 1 if lines turn over
	}).superfish({
		delay: 0,
		animation: {opacity:'show'},
		speed: 'fast',
		autoArrows: false,
		dropShadows: false
	});
};

/* ==================================================
   Mobile Navigation
================================================== */
/* Clone Menu for use later */
var mobileMenuClone = $('#menu').clone().attr('id', 'navigation-mobile');

CHARIOT.mobileNav = function(){
	var windowWidth = $(window).width();
	
	// Show Menu or Hide the Menu
	if( windowWidth >= 979 ) {
		$('#navigation-mobile').css('display', 'none');
		if ($('#mobile-nav').hasClass('open')) {
			$('#mobile-nav').removeClass('open');	
		}
	}
};

// Call the Event for Menu 
CHARIOT.listenerMenu = function(){
	
	$('#mobile-nav').on('click', function(e){
		$(this).toggleClass('open');
		
		$('#navigation-mobile').stop().slideToggle(350, 'easeOutExpo');
		e.preventDefault();
	});
};

CHARIOT.mobileMenu = function(){
	$('#menu-nav-mobile li').children('.sub-menu').hide().parent().addClass('menu-parent-item');
	$('#menu-nav-mobile .menu-parent-item a').not('.sub-menu a').append('<i class="font-icon-arrow-down-simple-thin-round"></i>');
	
	$('#menu-nav-mobile .menu-parent-item').on('click', function(e) {
		e.preventDefault();
		$(this).children('.sub-menu').stop().slideToggle(350, 'easeOutExpo');
		$(this).toggleClass('open');
	});
	
	$('#menu-nav-mobile .sub-menu a').on('click', function(e) {
		e.stopPropagation();
	});
};

/* ==================================================
   Filter Team
================================================== */

CHARIOT.people = function (){
if($('#team-people').length > 0){      
    var $container = $('#team-people');

    $container.imagesLoaded(function() {
        $container.isotope({
          animationEngine : 'best-available',
          itemSelector : '.single-people',
          layoutMode: 'sloppyMasonry'
        });
    });


    // filter items when filter link is clicked
    var $optionSets = $('#team-filter .option-set'),
        $optionLinks = $optionSets.find('a');

      $optionLinks.click(function(){
        var $this = $(this);
        // don't proceed if already selected
        if ( $this.hasClass('selected') ) {
          return false;
        }
        var $optionSet = $this.parents('.option-set');
        $optionSet.find('.selected').removeClass('selected');
        $this.addClass('selected');

        // make option object dynamically, i.e. { filter: '.my-filter-class' }
        var options = {},
            key = $optionSet.attr('data-option-key'),
            value = $this.attr('data-option-value');
        // parse 'false' as false boolean
        value = value === 'false' ? false : value;
        options[ key ] = value;
        if ( key === 'layoutMode' && typeof changeLayoutMode === 'function' ) {
          // changes in layout modes need extra logic
          changeLayoutMode( $this, options );
        } else {
          // otherwise, apply new options
          $container.isotope( options );
        }

        return false;
    });
}
};

/* ==================================================
   Filter Portfolio
================================================== */

CHARIOT.portfolio = function (){
if($('#portfolio-projects').length > 0){       
    var $container = $('#portfolio-projects');

    $container.imagesLoaded(function() {
        $container.isotope({
          // options
          animationEngine: 'best-available',
		  layoutMode: 'sloppyMasonry',
          itemSelector : '.item-project'
        });
    });
	
	$(window).smartresize(function() {
		$('#portfolio-projects').isotope('reLayout');
	});


    // filter items when filter link is clicked
    var $optionSets = $('#portfolio-filter .option-set'),
        $optionLinks = $optionSets.find('a');

      $optionLinks.click(function(){
        var $this = $(this);
        // don't proceed if already selected
        if ( $this.hasClass('selected') ) {
          return false;
        }
        var $optionSet = $this.parents('.option-set');
        $optionSet.find('.selected').removeClass('selected');
        $this.addClass('selected');

        // make option object dynamically, i.e. { filter: '.my-filter-class' }
        var options = {},
            key = $optionSet.attr('data-option-key'),
            value = $this.attr('data-option-value');
        // parse 'false' as false boolean
        value = value === 'false' ? false : value;
        options[ key ] = value;
        if ( key === 'layoutMode' && typeof changeLayoutMode === 'function' ) {
          // changes in layout modes need extra logic
          changeLayoutMode( $this, options );
        } else {
          // otherwise, apply new options
          $container.isotope( options );
        }

        return false;
    });
}
};

/* ==================================================
   Filter Portfolio Masonry
================================================== */

CHARIOT.portfolioMasonry = function (){
if($('#portfolio-projects .masonry-portfolio').length > 0){       
    var $container = $('#portfolio-projects .masonry-portfolio');

    $container.imagesLoaded(function() {
        $container.isotope({
          // options
          animationEngine: 'best-available',
          itemSelector : '.item-project'
        });
    });
	
	$(window).smartresize(function() {
		$container.isotope('reLayout');
	});


    // filter items when filter link is clicked
    var $optionSets = $('#portfolio-filter .option-set'),
        $optionLinks = $optionSets.find('a');

      $optionLinks.click(function(){
        var $this = $(this);
        // don't proceed if already selected
        if ( $this.hasClass('selected') ) {
          return false;
        }
        var $optionSet = $this.parents('.option-set');
        $optionSet.find('.selected').removeClass('selected');
        $this.addClass('selected');

        // make option object dynamically, i.e. { filter: '.my-filter-class' }
        var options = {},
            key = $optionSet.attr('data-option-key'),
            value = $this.attr('data-option-value');
        // parse 'false' as false boolean
        value = value === 'false' ? false : value;
        options[ key ] = value;
        if ( key === 'layoutMode' && typeof changeLayoutMode === 'function' ) {
          // changes in layout modes need extra logic
          changeLayoutMode( $this, options );
        } else {
          // otherwise, apply new options
          $container.isotope( options );
        }

        return false;
    });
}
};


/* ==================================================
   Masonry Blog
================================================== */

CHARIOT.masonry = function (){
if($('.masonry-blog').length > 0){ 

	var $container = $('.masonry-area');

    $container.imagesLoaded(function() {
        $container.isotope({
          // options
          animationEngine: 'best-available',
		  layoutMode: 'sloppyMasonry',
          itemSelector : '.item-blog'
        });
    });
	
	$(window).smartresize(function() {
		$container.isotope('reLayout');
	});

}
};


/* ==================================================
   DropDown 
================================================== */

CHARIOT.dropDown = function(){
	$('.dropmenu').on('click', function(e){
		$(this).toggleClass('open');
		
		$('.dropmenu-active').stop().slideToggle(350, 'easeOutExpo');
		
		e.preventDefault();
	});
	
	$('.dropmenu-active a').on('click', function(e){
		var dropdown = $(this).parents('.dropdown');
		var selected = dropdown.find('.dropmenu .selected');
		var newSelect = $(this).html();
		
		$('.dropmenu').removeClass('open');
		$('.dropmenu-active').slideUp(350, 'easeOutExpo');
		
		selected.html(newSelect);
		
		e.preventDefault();
	});
};

/* ==================================================
   Circular Graph 
================================================== */

CHARIOT.circularGraph = function(){
	var chart = $(".chart");
	
	$(chart).each(function() {
		var currentChart = $(this),
			currentSize = currentChart.attr('data-size'),
			currentLine = currentChart.attr('data-line');
		currentChart.easyPieChart({
			animate: 1000,
			barColor: '#E96045',
			trackColor: '#EBEDEF',
			lineWidth: currentLine,
			size: currentSize,
			lineCap: 'butt',
			scaleColor: false,
			onStep: function(value) {
          		this.$el.find('.percentage').text(~~value);
        	}
		});
	});

};


/* ==================================================
   FancyBox
================================================== */

CHARIOT.fancyBox = function(){
	if($('.fancybox').length > 0 || $('.fancybox-media').length > 0 || $('.fancybox-various').length > 0){
		
		$(".fancybox").fancybox({				
			padding : 0,
			helpers : {
				title : { type: 'inside' },
			}
		});
			
		$('.fancybox-media').fancybox({
			padding : 0,
			openEffect  : 'none',
			closeEffect : 'none',
			helpers : {
				media : {}
			}
		});
		
		$(".fancybox-various").fancybox({
			maxWidth	: 800,
			maxHeight	: 600,
			fitToView	: false,
			width		: '70%',
			height		: '70%',
			autoSize	: false,
			closeClick	: false,
			openEffect	: 'none',
			closeEffect	: 'none'
		});
	}
};

/* ==================================================
   Accordion
================================================== */

CHARIOT.accordion = function(){
	if($('.accordion-builder').length > 0 ){
		var accordion_trigger = $('.accordion-heading.accordionize');
		
		accordion_trigger.delegate('.accordion-toggle','click', function(e){
			if($(this).hasClass('active')){
				$(this).removeClass('active');
				$(this).addClass('inactive');
			}
			else{
				accordion_trigger.find('.active').addClass('inactive');          
				accordion_trigger.find('.active').removeClass('active');   
				$(this).removeClass('inactive');
				$(this).addClass('active');
			}
			e.preventDefault();
		});
	}
};

/* ==================================================
   Toggle
================================================== */

CHARIOT.toggle = function(){
	if($('.toggle-builder').length > 0 ){
		var accordion_trigger_toggle = $('.accordion-heading.togglize');
		
		accordion_trigger_toggle.delegate('.accordion-toggle','click', function(e){
			if($(this).hasClass('active')){
				$(this).removeClass('active');
				$(this).addClass('inactive');
			}
			else{
				$(this).removeClass('inactive');
				$(this).addClass('active');
			}
			e.preventDefault();
		});
	}
};

/* ==================================================
   Tabs
================================================== */

CHARIOT.tabs = function(){
if($('.tabbable').length > 0 ){
    $('.tabbable').each(function() {
        $(this).find('li').first().addClass('active');
        $(this).find('.tab-pane').first().addClass('active'); 
    });
}
};

/* ==================================================
	Testimonial Sliders
================================================== */

CHARIOT.testimonial = function(){
if($('.testimonial').length > 0 ){
	$('.testimonial').flexslider({
		animation:"slide",
		easing:"swing",
		controlNav: true, 
		reverse:true,
		smoothHeight:false,
		directionNav: false, 
		controlsContainer: '.az-testimonials-container',
		slideshowSpeed: 9000
	});
}
};

/* ==================================================
   Tooltip
================================================== */

CHARIOT.toolTip = function(){ 
    $('a[data-toggle=tooltip]').tooltip();
};

/* ==================================================
	Scroll to Top
================================================== */

CHARIOT.scrollToTop = function(){
	var didScroll = false;

	var $arrow = $('#back-to-top');

	$arrow.click(function(e) {
		$('body,html').animate({ scrollTop: "0" }, 750, 'easeOutExpo' );
		e.preventDefault();
	});

	$(window).scroll(function() {
		didScroll = true;
	});

	setInterval(function() {
		if( didScroll ) {
			didScroll = false;

			if( $(window).scrollTop() > 1000 ) {
				$arrow.css('display', 'block');
			} else {
				$arrow.css('display', 'none');
			}
		}
	}, 250);
};

/* ==================================================
   Responsive Video
================================================== */

CHARIOT.video = function(){
	$('.videoWrapper, .video-embed').fitVids();
};

/* ==================================================
	Custom Select
================================================== */

CHARIOT.customSelect = function(){
	if($('.selectpicker').length > 0){
		$('.selectpicker').selectpicker();
	}
};

/* ==================================================
   MediaElements
================================================== */

CHARIOT.mediaElements = function(){

$('audio, video').each(function(){
    $(this).mediaelementplayer({
    // if the <video width> is not specified, this is the default
    defaultVideoWidth: 480,
    // if the <video height> is not specified, this is the default
    defaultVideoHeight: 270,
    // if set, overrides <video width>
    videoWidth: -1,
    // if set, overrides <video height>
    videoHeight: -1,
    // width of audio player
    audioWidth: 400,
    // height of audio player
    audioHeight: 50,
    // initial volume when the player starts
    startVolume: 0.8,
    // path to Flash and Silverlight plugins
    pluginPath: theme_objects.base + '/_include/js/mediaelement/',
    // name of flash file
    flashName: 'flashmediaelement.swf',
    // name of silverlight file
    silverlightName: 'silverlightmediaelement.xap',
    // useful for <audio> player loops
    loop: false,
    // enables Flash and Silverlight to resize to content size
    enableAutosize: true,
    // the order of controls you want on the control bar (and other plugins below)
    // Hide controls when playing and mouse is not over the video
    alwaysShowControls: false,
    // force iPad's native controls
    iPadUseNativeControls: false,
    // force iPhone's native controls
    iPhoneUseNativeControls: false,
    // force Android's native controls
    AndroidUseNativeControls: false,
    // forces the hour marker (##:00:00)
    alwaysShowHours: false,
    // show framecount in timecode (##:00:00:00)
    showTimecodeFrameCount: false,
    // used when showTimecodeFrameCount is set to true
    framesPerSecond: 25,
    // turns keyboard support on and off for this instance
    enableKeyboard: true,
    // when this player starts, it will pause other players
    pauseOtherPlayers: true,
    // array of keyboard commands
    keyActions: []
    });
});

};

CHARIOT.resizeMediaElements = function(){
	var entryAudioBlog = $('.audio-thumb');
	var entryVideoBlog = $('.video-thumb');

	entryAudioBlog.each(function() { 
		$(this).css("width", $('article').width() + "px"); 
	}); 

	entryVideoBlog.each(function() { 
		$(this).css("width", $('article').width() + "px"); 
	}); 
};

/* ==================================================
	Menu Leave Page / Cache Back Button Reload
================================================== */

CHARIOT.leavePage = function(){
	$('header #logo a, #menu li a').not('header #menu li a[href$="#"]').click(function(event){
		
		event.preventDefault();
		var linkLocation = this.href;

		$('header').animate({'opacity' : 0, 'marginTop': -150}, 500, 'easeOutExpo');
		$('#main').animate({'opacity' : 0}, 500, 'easeOutExpo');
		
		$('body').fadeOut(500, function(){
			window.location = linkLocation;
		});      
	}); 
};

CHARIOT.reloader = function(){
	window.onpageshow = function(event) {
		if (event.persisted) {
			window.location.reload(); 
		}
	};	
};

/* ==================================================
	Animations Module
================================================== */

CHARIOT.animationsModule = function(){
	
	function elementViewed(element) {
		if (Modernizr.touch && $(document.documentElement).hasClass('no-animation-effects')) {
			return true;
		}
		var elem = element,
			window_top = $(window).scrollTop(),
			offset = $(elem).offset(),
			top = offset.top;
		if ($(elem).length > 0) {
			if (top + $(elem).height() >= window_top && top <= window_top + $(window).height()) {
				return true;
			} else {
				return false;
			}
		}
	};
	
	function onScrollInterval(){
		var didScroll = false;
		$(window).scroll(function(){
			didScroll = true;
		});
		
		setInterval(function(){
			if (didScroll) {
				didScroll = false;
			}
			
			if($('.chart').length > 0 ){
				$('.chart').each(function() {
					var currentChart = $(this);
					if (elementViewed(currentChart)) {
						CHARIOT.circularGraph(currentChart);
					}
				});	
			}
			
			if($('.animated-content').length > 0 ){
				$('.animated-content').each(function() {
					var currentObj = $(this);
					if (elementViewed(currentObj)) {
						currentObj.addClass('animate');
					}
				});
			}
			
		}, 250);
	};
	
	onScrollInterval();
};

/* ==================================================
   Social Share
================================================== */

CHARIOT.reloadSocial = function(){

	if( $('.fb-like').length > 0 || $('.twitter-share-button').length > 0 || $('.g-plusone').length > 0 || $('.pinterest-share').length > 0) {

	    //Twitter
	    if (typeof (twttr) != 'undefined') {
	        twttr.widgets.load();
	    } else {
	        $.getScript('http://platform.twitter.com/widgets.js');
	    }

	    //Facebook
	    if (typeof (FB) != 'undefined') {
	        FB.init({ status: true, cookie: true, xfbml: true });
	    } else {
	        $.getScript("http://connect.facebook.net/en_US/all.js#xfbml=1", function () {
	            FB.init({ status: true, cookie: true, xfbml: true });
	        });
	    }

	    // Pinterest
	    if (typeof (pinterest) != 'undefined') {
		    pinterest.widgets.load();
		} else {
			$.getScript('http://assets.pinterest.com/js/pinit.js');
		}
	  
	    //Google - Note that the google button will not show if you are opening the page from disk - it needs to be http(s)
	    if (typeof (gapi) != 'undefined') {
	        $(".g-plusone").each(function () {
	            gapi.plusone.render($(this).get(0));
	        });
	    } else {
	        $.getScript('https://apis.google.com/js/plusone.js');
	    }

	}
}

/* ==================================================
	Init
================================================== */

$(window).load(function(){
	if($('.animation-enabled').length > 0 ){
		CHARIOT.leavePage();
	}
});

$(document).ready(function(){
	// Animation Transition Preload Page
	if($('.animation-enabled').length > 0 ){
		
		CHARIOT.reloader();
		
		$('body').jpreLoader({
			splashID: "#jSplash",
			showSplash: true,
			showPercentage: false,
			autoClose: true,
			splashFunction: function() {
				$('.circle, .circle-inverse').delay(50).animate({'opacity' : 1}, 100, 'linear');
			}
		}, function() {				
			$("header").delay(150).animate({'opacity' : 1, 'marginTop': 0}, 500, 'easeOutExpo', function(){
				$('#main').delay(150).animate({'opacity' : 1}, 500, 'easeOutExpo', function(){
					$('footer').animate({'opacity' : 1}, 500, 'easeOutExpo');
				});
			});
		});
	}
	
	CHARIOT.animationsModule();
	CHARIOT.mediaElements();
	CHARIOT.resizeMediaElements();
	CHARIOT.video();
	CHARIOT.dropDown();
	CHARIOT.masonry();
	CHARIOT.people();
	CHARIOT.portfolio();
	CHARIOT.mobileNav();
	CHARIOT.mobileMenu();
	CHARIOT.listenerMenu();
	CHARIOT.subMenu();
	CHARIOT.accordion();
	CHARIOT.toggle();
	CHARIOT.tabs();
	CHARIOT.testimonial();
	CHARIOT.toolTip();
	CHARIOT.fancyBox();
	CHARIOT.customSelect();
	CHARIOT.scrollToTop();
	CHARIOT.reloadSocial();
});

$(window).bind('resize',function(){
	CHARIOT.mobileNav();
	CHARIOT.resizeMediaElements();
});

});