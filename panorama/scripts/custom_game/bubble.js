--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


"use strict";

var m_BubbleTable = {};
var m_HeightOffsets = {
}

function Bubble(unit, pic) {
	this.unit = unit;
	this.mainPanel = $.CreatePanel('Panel', $.GetContextPanel(), "");
	if (!pic) {
		this.mainPanel.BLoadLayoutSnippet('bubble_pic');
		// var text = '<Panel class="bubble" hittest="false"><Label id="Text" hittest="false" html="true" text=""></Label><Panel id="Arrow" hittest="false"/></Panel>';
		// this.mainPanel.RemoveAndDeleteChildren();
		// this.mainPanel.BCreateChildren(text);
	}
	else {
		this.mainPanel.BLoadLayoutSnippet('bubble_pic');

		// var text = '<Panel class="bubble" hittest="false"><Label id="Text" hittest="false" html="true" text=""><Image id="Pic" src = "'+pic+'"/></Label><Panel id="Arrow" hittest="false"/></Panel>';
		// this.mainPanel.RemoveAndDeleteChildren();
		// this.mainPanel.BCreateChildren(text);
	}



	this.__duration = 5;
	this.__is_stop = true;

	// Create think
	var __run
	var self = this
	__run = function () {
		if (self.__is_stop) return;
		if (Game.Time() - self.__start_time >= self.__duration) return self.stop();
		self.run()
		$.Schedule(0.01, __run);
	}
	this.__run = __run;
}

Bubble.prototype.start = function () {
	if (this.__is_stop === true) {
		this.__is_stop = false;
		this.__start_time = Game.Time();
		this.__run();
	}
}

Bubble.prototype.run = function () {
	var origin = Entities.GetAbsOrigin(this.unit);
	origin[2] = 200;
	var pos = [Game.WorldToScreenX(origin[0], origin[1], origin[2]), Game.WorldToScreenY(origin[0], origin[1], origin[2])];

	var w = Game.GetScreenWidth();
	var h = Game.GetScreenHeight();
	var main = this.mainPanel;

	if (pos[0] > w || pos[0] < 0 || pos[1] > h || pos[1] < 0)
		main.visible = false;
	else {
		var maxwidth = (w / h) * 1080;
		var midwidth = maxwidth / 2;
		var newX = ((pos[0] / w) * maxwidth) - main.actuallayoutwidth / 3;
		var newY = ((pos[1] / h) * 1080) - (m_HeightOffsets[Entities.GetUnitName(this.unit)] || 75) - main.actuallayoutheight;

		if (newX > midwidth) {
			newX += ((newX - midwidth) / midwidth) * 125;
		}
		else {
			newX -= ((midwidth - newX) / midwidth) * 125;
		}

		if (newY > 540) {
			newY -= ((540 - newY) / 540) * 50;
		}
		else {
			newY += ((newY - 540) / 540) * 50;
		}

		var newPos = newX + "px " + newY + "px 0px";
		main.style["position"] = newPos;
		main.visible = true;
	}
}

Bubble.prototype.stop = function () {
	this.__is_stop = true;
	this.mainPanel.visible = false;
}

Bubble.prototype.setText = function (text, pic) {
	if (pic) {
		this.mainPanel.FindChild('Text').text = '';
		// this.mainPanel.FindChild('Text').FindChild('Pic').setHasClass('invisible',false);
		var text = '<Panel class="bubble" hittest="false"><Label id="Text" hittest="false" html="true" text="" style="border-radius:10px;"><Image id="Pic" src = "' + pic + '" style="border-radius:10px;"/></Label><Panel id="Arrow" hittest="false"/></Panel>';
		this.mainPanel.RemoveAndDeleteChildren();
		// this.mainPanel.BCreateChildren(text);
		CreateChildren(this.mainPanel, text);
	}
	else {
		this.mainPanel.RemoveAndDeleteChildren();
		this.mainPanel.BLoadLayoutSnippet('bubble_pic');
		// this.mainPanel.FindChild('Text').FindChild('Pic').setHasClass('invisible',true);
		this.mainPanel.FindChild('Text').text = wordFilter(text);
		this.mainPanel.FindChild('Text').FindChild('Pic').visible = false;
	}
}

Bubble.prototype.setDuration = function (duration) {
	if (duration > 0) {
		this.__duration = duration
	}
}

Bubble.prototype.refresh = function () {
	this.__start_time = Game.Time();
}

function DisplayBubble(data) {
	var unit = data.unit || -1;
	if (!unit || unit <= 0) return;

	var text = data.text || "";
	var pic = data.pic || "";
	var duration = data.duration || 5;

	var bubble = m_BubbleTable[unit];
	if (!bubble) {
		if (!pic) {
			bubble = new Bubble(unit);
			m_BubbleTable[unit] = bubble;
		}
		else {
			bubble = new Bubble(unit, pic);
			m_BubbleTable[unit] = bubble;
		}
	}
	bubble.setText(text, pic);
	bubble.setDuration(duration);
	bubble.refresh();
	bubble.start();
	// Game.EmitSound("ui.courier_in_use");
}

GameUI.DisplayBubble = DisplayBubble;
