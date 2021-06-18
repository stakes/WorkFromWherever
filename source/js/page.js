import anime from 'animejs/lib/anime.es.js';


/**
 * demo1.js
 * http://www.codrops.com
 *
 * Licensed under the MIT license.
 * http://www.opensource.org/licenses/mit-license.php
 * 
 * Copyright 2017, Codrops
 * http://www.codrops.com
 */
 {
	// Helper vars and functions.
	const extend = function(a, b) {
		for( let key in b ) { 
			if( b.hasOwnProperty( key ) ) {
				a[key] = b[key];
			}
		}
		return a;
	};

	// from http://www.quirksmode.org/js/events_properties.html#position
	const getMousePos = function(ev) {
		let posx = 0;
		let posy = 0;
		if (!ev) ev = window.event;
		if (ev.pageX || ev.pageY) 	{
			posx = ev.pageX;
			posy = ev.pageY;
		}
		else if (ev.clientX || ev.clientY) 	{
			posx = ev.clientX + document.body.scrollLeft + document.documentElement.scrollLeft;
			posy = ev.clientY + document.body.scrollTop + document.documentElement.scrollTop;
		}
		return { x : posx, y : posy };
	};

	const TiltObj = function(el, options) {
		this.el = el;
		this.options = extend({}, this.options);
		extend(this.options, options);
		this.DOM = {};
		this.DOM.img = this.el.querySelector('.content__img');
		this.DOM.title = this.el.querySelector('.content__title');
		this._initEvents();
	}

	TiltObj.prototype.options = {
		movement: {
			img : { translation : {x: -40, y: -40} },
			title : { translation : {x: 20, y: 20} }
		}
	};

	TiltObj.prototype._initEvents = function() {
		this.mouseenterFn = (ev) => {
			anime.remove(this.DOM.img);
			anime.remove(this.DOM.title);
		};
		
		this.mousemoveFn = (ev) => {
			requestAnimationFrame(() => this._layout(ev));
		};
		
		this.mouseleaveFn = (ev) => {
			requestAnimationFrame(() => {
				anime({
					targets: [this.DOM.img, this.DOM.title],
					duration: 1500,
					easing: 'easeOutElastic',
					elasticity: 400,
					translateX: 0,
					translateY: 0
				});
			});
		};

		this.el.addEventListener('mousemove', this.mousemoveFn);
		this.el.addEventListener('mouseleave', this.mouseleaveFn);
		this.el.addEventListener('mouseenter', this.mouseenterFn);
	};

	TiltObj.prototype._layout = function(ev) {
		// Mouse position relative to the document.
		const mousepos = getMousePos(ev);
		// Document scrolls.
		const docScrolls = {left : document.body.scrollLeft + document.documentElement.scrollLeft, top : document.body.scrollTop + document.documentElement.scrollTop};
		const bounds = this.el.getBoundingClientRect();
		// Mouse position relative to the main element (this.DOM.el).
		const relmousepos = { x : mousepos.x - bounds.left - docScrolls.left, y : mousepos.y - bounds.top - docScrolls.top };

		// Movement settings for the animatable elements.
		const t = {
			img: this.options.movement.img.translation,
			title: this.options.movement.title.translation
		};
			
		const transforms = {
			img : {
				x: (-1*t.img.x - t.img.x)/bounds.width*relmousepos.x + t.img.x,
				y: (-1*t.img.y - t.img.y)/bounds.height*relmousepos.y + t.img.y
			},
			title : {
				x: (-1*t.title.x - t.title.x)/bounds.width*relmousepos.x + t.title.x,
				y: (-1*t.title.y - t.title.y)/bounds.height*relmousepos.y + t.title.y
			}
		};
		this.DOM.img.style.WebkitTransform = this.DOM.img.style.transform = 'translateX(' + transforms.img.x + 'px) translateY(' + transforms.img.y + 'px)';
		this.DOM.title.style.WebkitTransform = this.DOM.title.style.transform = 'translateX(' + transforms.title.x + 'px) translateY(' + transforms.title.y + 'px)';
	};

	const DOM = {};
	DOM.svg = document.querySelector('.morph-01');
	DOM.shapeEl = DOM.svg.querySelector('path');
	DOM.svg02 = document.querySelector('.morph-02');
	DOM.shapeEl02 = DOM.svg02.querySelector('path');
	DOM.contentElems = Array.from(document.querySelectorAll('.content-wrap'));
	DOM.contentLinks = Array.from(document.querySelectorAll('.content__link'));
	DOM.footer = document.querySelector('.content--related');
	const contentElemsTotal = DOM.contentElems.length;
	const shapes = [
		{
			path: 'M38.3,-56.6C46.6,-46.7,48.1,-31.4,53.6,-16.9C59,-2.4,68.4,11.5,67.7,24.6C67.1,37.8,56.4,50.4,43.5,58.4C30.5,66.5,15.3,69.9,0.8,68.7C-13.6,67.6,-27.2,61.9,-42.4,54.6C-57.6,47.3,-74.3,38.4,-79.1,25.3C-83.9,12.2,-76.8,-5.2,-68.9,-20.3C-61.1,-35.3,-52.6,-48,-41,-56.8C-29.4,-65.7,-14.7,-70.7,0.2,-70.9C15,-71.1,30,-66.5,38.3,-56.6Z',
			scaleX: 1,
			scaleY: 1,
			rotate: 70,
			tx: 0,
			ty: -100
		},
		{
			path: 'M46,-65.2C58.4,-54.3,66.4,-39.2,68.8,-24.2C71.2,-9.1,68,6,61,17.4C53.9,28.8,43,36.5,32.2,45.8C21.4,55.1,10.7,65.9,-2.2,69C-15.2,72,-30.4,67.4,-45.5,59.5C-60.7,51.7,-75.8,40.6,-81.9,25.7C-87.9,10.8,-84.9,-7.9,-77.1,-23C-69.4,-38,-56.8,-49.4,-43.1,-59.9C-29.5,-70.5,-14.7,-80.1,1,-81.5C16.8,-82.9,33.6,-76.1,46,-65.2Z',
			scaleX: 1,
			scaleY: 1,
			rotate: 70,
			tx: 0,
			ty: -100
		},
		{
            path: 'M43,-59.2C52.8,-52,55.8,-35.6,62.9,-19.2C69.9,-2.8,81,13.6,79.8,28.6C78.6,43.7,65.2,57.4,49.8,62.9C34.5,68.3,17.2,65.3,-0.2,65.7C-17.7,66,-35.4,69.6,-47.4,63.1C-59.4,56.6,-65.7,40,-67.4,24.4C-69.1,8.7,-66.2,-5.9,-61,-19.1C-55.7,-32.3,-48.1,-44,-37.5,-50.8C-26.9,-57.7,-13.5,-59.7,1.6,-61.9C16.6,-64,33.2,-66.3,43,-59.2Z',
			scaleX: 1,
			scaleY: 1,
			rotate: 70,
			tx: 0,
			ty: -100
		}
	];
	const shapes02 = [
		{
			path: 'M46.8,-44C58.8,-34.8,65.5,-17.4,68.1,2.7C70.8,22.7,69.5,45.5,57.5,56C45.5,66.5,22.7,64.9,0.1,64.7C-22.4,64.6,-44.9,65.9,-57.1,55.4C-69.3,44.9,-71.4,22.4,-67.8,3.6C-64.2,-15.3,-55,-30.5,-42.8,-39.8C-30.5,-49,-15.3,-52.2,1.1,-53.3C17.4,-54.3,34.8,-53.3,46.8,-44Z',
			scaleX: 1,
			scaleY: 1,
			rotate: 70,
			tx: 0,
			ty: -100
		},
		{
			path: 'M40,-47.6C49,-30.9,51.5,-15.5,50.9,-0.6C50.3,14.2,46.5,28.4,37.5,38.5C28.4,48.5,14.2,54.3,1.1,53.2C-12.1,52.1,-24.2,44.2,-35.6,34.2C-47,24.2,-57.8,12.1,-58.9,-1.1C-60,-14.3,-51.4,-28.6,-40,-45.2C-28.6,-61.8,-14.3,-80.8,0.6,-81.3C15.5,-81.9,30.9,-64.2,40,-47.6Z',
			scaleX: 1,
			scaleY: 1,
			rotate: 70,
			tx: 0,
			ty: -100
		},
		{
            path: 'M39.7,-39.4C52.4,-27,64.3,-13.5,67.4,3.1C70.5,19.7,64.7,39.3,52,49.8C39.3,60.3,19.7,61.7,2.2,59.5C-15.2,57.2,-30.5,51.5,-39,41C-47.6,30.5,-49.4,15.2,-51.3,-1.9C-53.1,-19,-55.1,-38,-46.5,-50.4C-38,-62.7,-19,-68.5,-2.7,-65.8C13.5,-63,27,-51.8,39.7,-39.4Z',
			scaleX: 1,
			scaleY: 1,
			rotate: 70,
			tx: 0,
			ty: -100
		},
		{
            path: 'M35.6,-39.9C45.1,-26.1,50.9,-13.1,54.3,3.4C57.7,19.8,58.6,39.6,49.1,56.1C39.6,72.6,19.8,85.8,1.2,84.7C-17.5,83.5,-35,68,-48,51.5C-60.9,35,-69.3,17.5,-71.7,-2.5C-74.2,-22.5,-70.8,-44.9,-57.8,-58.6C-44.9,-72.4,-22.5,-77.4,-4.7,-72.7C13.1,-68,26.1,-53.6,35.6,-39.9Z',
			scaleX: 1,
			scaleY: 1,
			rotate: 70,
			tx: 0,
			ty: -100
		}
	];
	let step;

	const initShapeLoop = function(el, arr, time, pos) {
		pos = pos || 0;
		anime.remove(el);
		var shapeArray = []
		var fillArray = []
		arr.forEach((val)=>
			{
				shapeArray.push(
					{
						value: val.path
					}
				)
			}
		)
		console.log(el)
		anime({
			targets: el,
			easing: 'easeInOutQuad',
			d: shapeArray,
			loop: true,
			duration: time,
			direction: 'alternate'
		});
	};

	const initBackgroundLoop = () => {
		initShapeLoop(DOM.shapeEl, shapes, 9000)
		initShapeLoop(DOM.shapeEl02, shapes02, 12000)
	}

	const init = function() {
        initBackgroundLoop();
        // Array.from(document.querySelectorAll('.content--layout')).forEach(el => new TiltObj(el));
	}

	init();
}