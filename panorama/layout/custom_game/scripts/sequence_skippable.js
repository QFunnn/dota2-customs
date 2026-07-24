--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


// ----------------------------------------------------------------------------
//	Skip Ahead Functions
//	REQUIRES BASE sequence.js TO BE INCLUDED FIRST
// ----------------------------------------------------------------------------

let do_skip_next_actions = false;

function IsSkippingAhead() {
	return do_skip_next_actions;
}

function SetSkippingAhead(skip_ahead) {
	if (do_skip_next_actions == skip_ahead) return;

	if (skip_ahead) {
		$.DispatchEvent("PostGameProgressSkippingAhead");
	}
	$.GetContextPanel().SetHasClass("SkippingAhead", skip_ahead);
	do_skip_next_actions = skip_ahead;

	if (skip_ahead) {
		PlayUISoundEvent("ui_generic_button_click");
	}
}

function StopSkippingAhead() {
	SetSkippingAhead(false);
}

function StartSkippingAhead() {
	// $.Msg("skipping ahead");
	SetSkippingAhead(true);
}

// ----------------------------------------------------------------------------
//   StopSkippingAheadAction
//
//   Define a point at which we stop skipping (usually the end of a screen)
// ----------------------------------------------------------------------------

// Use a StopSkippingAheadAction to define a stopping point
function StopSkippingAheadAction() {}
StopSkippingAheadAction.prototype = new BaseAction();
StopSkippingAheadAction.prototype.update = function () {
	StopSkippingAhead();
	return false;
};

// ----------------------------------------------------------------------------
//   SkippableAction
//
//   Wrap a SkippableAction around any other action to have it skip ahead
//   whenever we're supposed to skip ahead. SkippableAction guarantees that the
//   inner action will at least have start/update/finish called on it.
// ----------------------------------------------------------------------------
function SkippableAction(action_to_skip) {
	this.inner_action = action_to_skip;
}
SkippableAction.prototype = new BaseAction();

SkippableAction.prototype.start = function () {
	this.inner_action.start();
};
SkippableAction.prototype.update = function () {
	return this.inner_action.update() && !IsSkippingAhead();
};
SkippableAction.prototype.finish = function () {
	this.inner_action.finish();
};

// Action for skippable delay
function SkippableWaitAction(seconds) {
	this.seconds = seconds;
}
SkippableWaitAction.prototype = new BaseAction();
SkippableWaitAction.prototype.start = function () {
	this.end_time = Game.Time() + this.seconds;
};
SkippableWaitAction.prototype.update = function () {
	return Game.Time() < this.end_time && !IsSkippingAhead();
};

// Action to run multiple actions in parallel, but with a slight stagger start between each of them
function RunSkippableStaggeredActions(stagger_seconds) {
	this.actions = [];
	this.stagger_seconds = stagger_seconds;
}
RunSkippableStaggeredActions.prototype = new BaseAction();
RunSkippableStaggeredActions.prototype.add = function (...actions) {
	this.actions.push(...actions);
};
RunSkippableStaggeredActions.prototype.start = function () {
	this.par = new RunSequentialActions();

	for (let i = 0; i < this.actions.length; ++i) {
		let delay = this.stagger_seconds;
		if (delay > 0) {
			this.par.actions.push(new SkippableWaitAction(delay));
			this.par.actions.push(this.actions[i]);
		} else {
			this.par.actions.push(this.actions[i]);
		}
	}

	this.par.start();
};
RunSkippableStaggeredActions.prototype.update = function () {
	return this.par.update();
};
RunSkippableStaggeredActions.prototype.finish = function () {
	this.par.finish();
};

// ----------------------------------------------------------------------------
//   OptionalSkippableAction
//
//   Wrap a OptionalSkippableAction around any other action to have it skip it
//   if requested. OptionalSkippableAction will skip the inner action entirely
//   if skipping is currently enabled. However, if it starts the inner action
//   at all, then it will guarantee at least a call to start/update/finish.
// ----------------------------------------------------------------------------
function OptionalSkippableAction(action_to_skip) {
	this.inner_action = action_to_skip;
}
OptionalSkippableAction.prototype = new BaseAction();

OptionalSkippableAction.prototype.start = function () {
	this.is_inner_action_started = false;

	if (!IsSkippingAhead()) {
		this.inner_action.start();
		this.is_inner_action_started = true;
	}
};
OptionalSkippableAction.prototype.update = function () {
	if (this.is_inner_action_started) return this.inner_action.update() && !IsSkippingAhead();

	if (IsSkippingAhead()) return false;

	this.inner_action.start();
	this.is_inner_action_started = true;

	return this.inner_action.update();
};
OptionalSkippableAction.prototype.finish = function () {
	if (this.is_inner_action_started) {
		this.inner_action.finish();
	}
};

/**
 * Base class that you can override an `apply_progress` for a simple Lerp over `lerp_duration` seconds.
 * @param {Number} lerp_duration - animation duration
 */
function SkippableLerpAction(lerp_duration) {
	this.lerp_duration = lerp_duration;
}
SkippableLerpAction.prototype = new BaseAction();
SkippableLerpAction.prototype.start = function () {
	this.started_at = Game.Time();
	this.end_at = this.started_at + this.lerp_duration;
};
SkippableLerpAction.prototype.update = function () {
	const now = Game.Time();
	if (now >= this.end_at) return false;

	const ratio = (now - this.started_at) / (this.end_at - this.started_at);
	this.apply_progress(ratio);
	return !IsSkippingAhead();
};
SkippableLerpAction.prototype.finish = function () {
	this.apply_progress(1.0);
};
SkippableLerpAction.prototype.apply_progress = function (progress) {
	// Override this method to apply your progress
};