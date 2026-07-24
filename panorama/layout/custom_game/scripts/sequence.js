--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


// Sequence actions are objects that you can use to queue up work to happen in a
// sequence over time.

// Base action, which is something that will tick per-frame for a while until it's done.
function BaseAction() {}

// The start function is called before the action starts executing.
BaseAction.prototype.start = () => {};
BaseAction.prototype.add = () => {};

// The update function is called once per frame until it returns false signalling that the action is done.
BaseAction.prototype.update = () => false;

// After the update function is complete, the finish function is called
BaseAction.prototype.finish = () => {};

/**
 * Action to run a group of other actions in sequence
 */
function RunSequentialActions() {
	this.actions = [];
}
RunSequentialActions.prototype = new BaseAction();
RunSequentialActions.prototype.add = function (...actions) {
	this.actions.push(...actions);
};
RunSequentialActions.prototype.start = function () {
	this.current_action_index = 0;
	this.current_action_started = false;
};
RunSequentialActions.prototype.update = function () {
	while (this.current_action_index < this.actions.length) {
		if (!this.current_action_started) {
			this.actions[this.current_action_index].start();
			this.current_action_started = true;
		}

		if (!this.actions[this.current_action_index].update()) {
			this.actions[this.current_action_index].finish();

			this.current_action_index++;
			this.current_action_started = false;
		} else {
			return true;
		}
	}

	return false;
};
RunSequentialActions.prototype.finish = function () {
	while (this.current_action_index < this.actions.length) {
		if (!this.current_action_started) {
			this.actions[this.current_action_index].start();
			this.current_action_started = true;

			this.actions[this.current_action_index].update();
		}

		this.actions[this.current_action_index].finish();

		this.current_action_index++;
		this.current_action_started = false;
	}
};

/**
 * Action to run multiple actions all at once. The action is complete once all sub actions are done.
 */
function RunParallelActions() {
	this.actions = [];
}
RunParallelActions.prototype = new BaseAction();
RunParallelActions.prototype.add = function (...actions) {
	this.actions.push(...actions);
};
RunParallelActions.prototype.start = function () {
	this.finished_actions = new Array(this.actions.length);

	for (var i = 0; i < this.actions.length; ++i) {
		this.finished_actions[i] = false;
		this.actions[i].start();
	}
};
RunParallelActions.prototype.update = function () {
	var is_any_action_running = false;

	for (var i = 0; i < this.actions.length; ++i) {
		if (!this.finished_actions[i]) {
			if (!this.actions[i].update()) {
				this.actions[i].finish();
				this.finished_actions[i] = true;
			} else {
				is_any_action_running = true;
			}
		}
	}

	return is_any_action_running;
};
RunParallelActions.prototype.finish = function () {
	for (var i = 0; i < this.actions.length; ++i) {
		if (!this.finished_actions[i]) {
			this.actions[i].finish();
			this.finished_actions[i] = true;
		}
	}
};

/**
 * Action to rum multiple actions in parallel, but with a stagger start between each of them
 * @param {Number} stagger_seconds - delay between actions
 */
function RunStaggeredActions(stagger_seconds) {
	this.actions = [];
	this.stagger_seconds = stagger_seconds;
}
RunStaggeredActions.prototype = new BaseAction();
RunStaggeredActions.prototype.add = function (...actions) {
	this.actions.push(...actions);
};
RunStaggeredActions.prototype.start = function () {
	this.parallel_runner = new RunParallelActions();

	for (let i = 0; i < this.actions.length; ++i) {
		const delay = i * this.stagger_seconds;
		if (delay > 0) {
			const seq = new RunSequentialActions();
			seq.actions.push(new WaitAction(delay));
			seq.actions.push(this.actions[i]);
			this.parallel_runner.actions.push(seq);
		} else {
			this.parallel_runner.actions.push(this.actions[i]);
		}
	}

	this.parallel_runner.start();
};
RunStaggeredActions.prototype.update = function () {
	return this.parallel_runner.update();
};
RunStaggeredActions.prototype.finish = function () {
	this.parallel_runner.finish();
};

/**
 * Runs a set of actions but stops as soon as any of them are finished.
 * @param {Boolean} continue_other_actions - determines whether to continue ticking the remaining actions, or whether to just finish them immediately.
 */
function RunUntilSingleActionFinishedAction(continue_other_actions) {
	this.actions = [];
	this.continue_other_actions = continue_other_actions;
}
RunUntilSingleActionFinishedAction.prototype = new BaseAction();
RunUntilSingleActionFinishedAction.prototype.add = function (...actions) {
	this.actions.push(...actions);
};
RunUntilSingleActionFinishedAction.prototype.start = function () {
	this.actionsFinished = new Array(this.actions.length);

	for (var i = 0; i < this.actions.length; ++i) {
		this.actionsFinished[i] = false;
		this.actions[i].start();
	}
};
RunUntilSingleActionFinishedAction.prototype.update = function () {
	if (this.actions.length == 0) return false;

	let is_any_action_finished = false;
	for (let i = 0; i < this.actions.length; ++i) {
		if (!this.actions[i].update()) {
			this.actions[i].finish();
			this.actionsFinished[i] = true;
			is_any_action_finished = true;
		}
	}

	return !is_any_action_finished;
};
RunUntilSingleActionFinishedAction.prototype.finish = function () {
	if (this.continue_other_actions) {
		// If we want to make sure the rest tick out, then build a new RunParallelActions of all
		// the remaining actions, then have it tick out separately.
		const parallel_runner = new RunParallelActions();
		for (let i = 0; i < this.actions.length; ++i) {
			if (!this.actionsFinished[i]) {
				parallel_runner.actions.push(this.actions[i]);
			}
		}

		if (parallel_runner.actions.length > 0) {
			UpdateSingleActionUntilFinished(parallel_runner);
		}
	} else {
		// Just finish each action immediately
		for (let i = 0; i < this.actions.length; ++i) {
			if (!this.actionsFinished[i]) {
				this.actions[i].finish();
			}
		}
	}
};

/**
 * Action that simply runs a passed in function.
 * @param {CallableFunction} f - function to call
 * @param  {...any} arguments - arguments passed to function `f`
 */
function RunFunctionAction(f, ...arguments) {
	this.f = f;
	this.arguments = arguments || [];
}
RunFunctionAction.prototype = new BaseAction();
RunFunctionAction.prototype.update = function () {
	this.f(...this.arguments);
	return false;
};

/**
 * Wait for condition callable to return `true`
 * @param {CallableFunction} f - condition callable, should return `Boolean`
 * @param  {...any} arguments - arguments for condition callable `f`
 */
function WaitForConditionAction(f, ...arguments) {
	this.f = f;
	this.arguments = arguments || [];
}
WaitForConditionAction.prototype = new BaseAction();
WaitForConditionAction.prototype.update = function () {
	return !this.f(...this.arguments);
};

/**
 * Action to wait `seconds` before resuming
 * @param {Number} seconds - delay in seconds
 */
function WaitAction(seconds) {
	this.seconds = seconds;
}
WaitAction.prototype = new BaseAction();
WaitAction.prototype.start = function () {
	this.endTimestamp = Game.Time() + this.seconds;
};
WaitAction.prototype.update = function () {
	return Game.Time() < this.endTimestamp;
};

/**
 * Action to wait a single frame
 */
function WaitOneFrameAction() {}
WaitOneFrameAction.prototype = new BaseAction();
WaitOneFrameAction.prototype.start = function () {
	this.updated = false;
};
WaitOneFrameAction.prototype.update = function () {
	if (this.updated) return false;

	this.updated = true;
	return true;
};

/**
 * Action that waits for a specific event type to be fired on the given panel.
 * @param {any} panel
 * @param {String} event_name - name of the event to wait for
 */
function WaitForEventAction(panel, event_name) {
	this.panel = panel;
	this.event_name = event_name;
}
WaitForEventAction.prototype = new BaseAction();
WaitForEventAction.prototype.start = function () {
	this.is_event_received = false;
	const action = this;
	// interestingly enough you can't unregister the listener
	// unsure if it causes any leaks or perf implications - Sanctus Animus
	$.RegisterEventHandler(this.event_name, this.panel, () => {
		action.is_event_received = true;
	});
};
WaitForEventAction.prototype.update = function () {
	return !this.is_event_received;
};

/**
 * Run an action until it's complete, or until it hits a timeout.
 * @param {BaseAction} action - action to run with timeout
 * @param {Number} timeout_duration - seconds to wait until action is terminated
 * @param {Boolean} continue_after_timeout - whether to continue after
 */
function ActionWithTimeout(action, timeout_duration, continue_after_timeout) {
	this.action = action;
	this.timeout_duration = timeout_duration;
	this.continue_after_timeout = continue_after_timeout;
}
ActionWithTimeout.prototype = new BaseAction();
ActionWithTimeout.prototype.start = function () {
	this.runner = new RunUntilSingleActionFinishedAction(this.continue_after_timeout);
	this.runner.actions.push(this.action);
	this.runner.actions.push(new WaitAction(this.timeout_duration));
	this.runner.start();
};
ActionWithTimeout.prototype.update = function () {
	return this.runner.update();
};
ActionWithTimeout.prototype.finish = function () {
	this.runner.finish();
};

/**
 * Action to print a debug message
 * @param {String} msg - message to print
 */
function PrintAction(msg) {
	this.msg = msg;
}
PrintAction.prototype = new BaseAction();
PrintAction.prototype.update = function () {
	$.Msg(this.msg);
	return false;
};

/**
 * Action to add a class to a panel
 * @param {any} panel
 * @param {String} class_name - class name to add
 */
function AddClassAction(panel, class_name) {
	this.panel = panel;
	this.class_name = class_name;
}
AddClassAction.prototype = new BaseAction();
AddClassAction.prototype.update = function () {
	if (this != null && this.panel != null) this.panel.AddClass(this.class_name);
	return false;
};

/**
 * Action to remove `class_name` from panel
 * @param {String} class_name - class name to remove
 */
function RemoveClassAction(panel, class_name) {
	this.panel = panel;
	this.class_name = class_name;
}
RemoveClassAction.prototype = new BaseAction();
RemoveClassAction.prototype.update = function () {
	this.panel.RemoveClass(this.class_name);
	return false;
};

/**
 * Action to switch `class_name` in `slot_name` on panel
 * @param {String} slot_name - slot name to switch in
 * @param {String} class_name - class name to switch to
 */
function SwitchClassAction(panel, slot_name, class_name) {
	this.panel = panel;
	this.slot_name = slot_name;
	this.class_name = class_name;
}
SwitchClassAction.prototype = new BaseAction();
SwitchClassAction.prototype.update = function () {
	this.panel.SwitchClass(this.slot_name, this.class_name);
	return false;
};

/**
 * Action to trigger certain `class_name` on panel
 * @param {String} class_name
 */
function TriggerClassAction(panel, class_name) {
	this.panel = panel;
	this.class_name = class_name;
}
TriggerClassAction.prototype = new BaseAction();
TriggerClassAction.prototype.update = function () {
	this.panel.TriggerClass(this.class_name);
	return false;
};

/**
 * Action to wait for certain `class_name` to appear on panel
 * @param {String} class_name
 */
function WaitForClassAction(panel, class_name) {
	this.panel = panel;
	this.class_name = class_name;
}
WaitForClassAction.prototype = new BaseAction();
WaitForClassAction.prototype.update = function () {
	return !this || !this.panel || !this.panel.IsValid() || !this.panel.BHasClass(this.class_name);
};

/**
 * Base class that you can override an `apply_progress` for a simple Lerp over `lerp_duration` seconds.
 * @param {Number} lerp_duration - animation duration
 */
function LerpAction(lerp_duration) {
	this.lerp_duration = lerp_duration;
}
LerpAction.prototype = new BaseAction();
LerpAction.prototype.start = function () {
	this.started_at = Game.Time();
	this.end_at = this.started_at + this.lerp_duration;
};
LerpAction.prototype.update = function () {
	const now = Game.Time();
	if (now >= this.end_at) return false;

	const ratio = (now - this.started_at) / (this.end_at - this.started_at);
	this.apply_progress(ratio);
	return true;
};
LerpAction.prototype.finish = function () {
	this.apply_progress(1.0);
};
LerpAction.prototype.apply_progress = function (progress) {
	// Override this method to apply your progress
};

/**
 * Action to set integer dialog variable
 * @param {String} variable_name - dialog variable name
 * @param {Number} value
 */
function SetDialogVariableIntAction(panel, variable_name, value) {
	this.panel = panel;
	this.variable_name = variable_name;
	this.value = value;
}
SetDialogVariableIntAction.prototype = new BaseAction();
SetDialogVariableIntAction.prototype.update = function () {
	this.panel.SetDialogVariableInt(this.variable_name, this.value);
	return false;
};

/**
 * Action to animate integer dialog variable over `animation_duration` seconds
 * @param {any} panel
 * @param {String} variable_name - dialog variable name
 * @param {Number} start_value
 * @param {Number} end_value
 * @param {Number} animation_duration
 */
function AnimateDialogVariableIntAction(panel, variable_name, start_value, end_value, animation_duration) {
	LerpAction.call(this, animation_duration);
	this.panel = panel;
	this.variable_name = variable_name;
	this.start_value = start_value;
	this.end_value = end_value;
}
AnimateDialogVariableIntAction.prototype = new LerpAction();
AnimateDialogVariableIntAction.prototype.apply_progress = function (progress) {
	this.panel.SetDialogVariableInt(this.variable_name, Math.floor(Lerp(progress, this.start_value, this.end_value)));
};

/**
 * Action to set dialog variable to string value
 * @param {any} panel
 * @param {String} variable_name
 * @param {String} value
 */
function SetDialogVariableStringAction(panel, variable_name, value) {
	this.panel = panel;
	this.variable_name = variable_name;
	this.value = value;
}
SetDialogVariableStringAction.prototype = new BaseAction();
SetDialogVariableStringAction.prototype.update = function () {
	this.panel.SetDialogVariable(this.variable_name, this.value);
	return false;
};

/**
 * Action to set progress bar value
 * @param {any} progress_bar_panel - ProgressBar panel
 * @param {Number} value
 */
function SetProgressBarValueAction(progress_bar_panel, value) {
	this.progress_bar_panel = progress_bar_panel;
	this.value = value;
}
SetProgressBarValueAction.prototype = new BaseAction();
SetProgressBarValueAction.prototype.update = function () {
	this.progress_bar_panel.value = this.value;
	return false;
};

/**
 * Action to animate progress bar value over `animation_duration` seconds
 * @param {any} progress_bar_panel - ProgressBar panel
 * @param {Number} start_value
 * @param {Number} end_value
 * @param {Number} animation_duration - animation duration in seconds
 */
function AnimateProgressBarAction(progress_bar_panel, start_value, end_value, animation_duration) {
	LerpAction.call(this, animation_duration);
	this.progress_bar_panel = progress_bar_panel;
	this.start_value = start_value;
	this.end_value = end_value;
}
AnimateProgressBarAction.prototype = new LerpAction();
AnimateProgressBarAction.prototype.apply_progress = function (progress) {
	this.progress_bar_panel.value = Lerp(progress, this.start_value, this.end_value);
};

/**
 * Action to animate progress bar value with middle over `animation_duration` seconds.
 * (I have no idea what middle action means here, probably different kind of progress bar)
 * @param {any} progress_bar_panel - ProgressBar panel
 * @param {Number} start_value
 * @param {Number} end_value
 * @param {Number} animation_duration - animation duration in seconds
 */
function AnimateProgressBarWithMiddleAction(progress_bar_panel, start_value, end_value, animation_duration) {
	this.progress_bar_panel = progress_bar_panel;
	this.start_value = start_value;
	this.end_value = end_value;
	this.seconds = animation_duration;
}
AnimateProgressBarWithMiddleAction.prototype = new LerpAction();
AnimateProgressBarWithMiddleAction.prototype.apply_progress = function (progress) {
	this.progress_bar_panel.uppervalue = Lerp(progress, this.start_value, this.end_value);
};

/**
 * Action to play a sound effect
 * @param {String} sound_effect_name
 */
function PlaySoundEffectAction(sound_effect_name) {
	this.sound_effect_name = sound_effect_name;
}
PlaySoundEffectAction.prototype = new BaseAction();
PlaySoundEffectAction.prototype.update = function () {
	$.DispatchEvent("PlaySoundEffect", this.sound_effect_name);
	return false;
};

/**
 * Play sound script
 * @param {String} sound_name - name of sound script
 */
function PlaySoundAction(sound_name) {
	this.sound_name = sound_name;
}
PlaySoundAction.prototype = new BaseAction();

PlaySoundAction.prototype.update = function () {
	PlayUISoundEvent(this.sound_name);
	return false;
};

/**
 * Play sound effect script for a given `duration`
 * @param {String} sound_name
 * @param {Number} duration - sound effect duration in seconds
 */
function PlaySoundForDurationAction(sound_name, duration) {
	this.sound_name = sound_name;
	this.duration = duration;
}
PlaySoundForDurationAction.prototype = new BaseAction();

PlaySoundForDurationAction.prototype.start = function () {
	this.sound_event_id = PlayUISoundEvent(this.sound_name);

	this.waitAction = new WaitAction(this.duration);
	this.waitAction.start();
};
PlaySoundForDurationAction.prototype.update = function () {
	return this.waitAction.update();
};
PlaySoundForDurationAction.prototype.finish = function () {
	StopUISoundEvent(this.sound_event_id);
	this.waitAction.finish();
};

/**
 * Play sound script until it's finished
 * @param {String} sound_name
 */
function PlaySoundUntilFinishedAction(sound_name) {
	this.sound_name = sound_name;
}
PlaySoundUntilFinishedAction.prototype = new BaseAction();

PlaySoundUntilFinishedAction.prototype.start = function () {
	this.sound_event_id = PlayUISoundEvent(this.sound_name);
};
PlaySoundUntilFinishedAction.prototype.update = function () {
	return IsUISoundEventPlaying(this.sound_event_id);
};

/**
 * Runs a contained action, except that it's immediately aborted if the passed-in `guard` function ever returns false - not even finishing the contained action.
 * Alternatively you can keep a reference to the GuardedAction and just set guardFailed to true to trigger this abort.
 * @param {BaseAction} action - action to run
 * @param {CallableFunction} guard - guard function
 */
function GuardedAction(action, guard = null) {
	this.action = action;
	this.guard = guard;
	this.has_guard_failed = false;
}
GuardedAction.prototype = new BaseAction();
GuardedAction.prototype.trigger_failure = function () {
	this.has_guard_failed = true;
};
GuardedAction.prototype.check_guard = function () {
	if (this.has_guard_failed) {
		return true;
	}

	if (this.guard && !this.guard()) {
		this.has_guard_failed = true;
	}

	return this.has_guard_failed;
};
GuardedAction.prototype.start = function () {
	if (this.check_guard()) {
		return;
	}

	this.action.start();
};
GuardedAction.prototype.update = function () {
	if (this.check_guard()) {
		return false;
	}

	return this.action.update();
};
GuardedAction.prototype.finish = function () {
	if (this.check_guard()) {
		return;
	}

	this.action.finish();
};

/**
 * Action to play movie until it's finished
 * @param {any} movie_panel - Movie panel
 */
function PlayMovieAction(movie_panel) {
	this.movie_panel = movie_panel;

	this.has_movie_finished = false;
	const action = this;
	$.RegisterEventHandler("MoviePlayerPlaybackEnded", this.movie_panel, function () {
		action.has_movie_finished = true;
	});
}
PlayMovieAction.prototype = new BaseAction();

PlayMovieAction.prototype.start = function () {
	this.movie_panel.Play();
};
PlayMovieAction.prototype.update = function () {
	return !this.has_movie_finished;
};

/**
 * Action to fire entity input on a scene panel
 * @param {any} scene_panel DOTAScenePanel panel
 * @param {String} entity_name - entity name (within scene)
 * @param {String} entity_input - entity input name
 * @param {any} entity_input_value - value to apply
 */
function FireEntityInputAction(scene_panel, entity_name, entity_input, entity_input_value) {
	this.scene_panel = scene_panel;
	this.entity_name = entity_name;
	this.entity_input = entity_input;
	this.entity_input_value = entity_input_value;
}
FireEntityInputAction.prototype = new BaseAction();
FireEntityInputAction.prototype.update = function () {
	this.scene_panel.FireEntityInput(this.entity_name, this.entity_input, this.entity_input_value);
	return false;
};

/**
 * Calculates lerp result based on current progress, start and end values
 * @param {Number} percent - current lerp progress (float from 0 to 1)
 * @param {Number} a - start value
 * @param {Number} b - end value
 * @returns {Number}
 */
function Lerp(percent, a, b) {
	return a + percent * (b - a);
}

/**
 * Helper function to asynchronously tick a single action until it's finished, then call finish on it.
 * @param {BaseAction} action - action to run
 */
function UpdateSingleActionUntilFinished(action) {
	const callback = () => {
		if (!action.update()) {
			action.finish();
		} else {
			$.Schedule(0.0, callback);
		}
	};
	callback();
}

/**
 * Start an action.
 * Mainly used to start sequence runners.
 * @param {BaseAction} action - action to run
 */
function RunSingleAction(action) {
	action.start();
	UpdateSingleActionUntilFinished(action);
}