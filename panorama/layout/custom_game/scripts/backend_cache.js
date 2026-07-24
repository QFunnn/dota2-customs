--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


const WEB_OBJECT_STATES = {
	NONE: 0,
	FETCHED: 1,
	LOADED: 2,
};

class BackendCacheEntity {
	constructor(cache_table, non_loaded_event_name, non_loaded_event_args) {
		this.state = WEB_OBJECT_STATES.NONE;
		this.cache_table = cache_table;
		this.non_loaded_event_name = non_loaded_event_name;
		this.non_loaded_event_args = non_loaded_event_args;
	}
	Activate() {
		this.Callback_Default();

		for (const _bc of Object.values(this.cache_table)) _bc.is_active = false;
		this.is_active = true;

		if (this.state == WEB_OBJECT_STATES.NONE) {
			this.state = WEB_OBJECT_STATES.FETCHED;
			GameEvents.SendToServerEnsured(this.non_loaded_event_name, this.non_loaded_event_args);
			return;
		}

		if (this.state == WEB_OBJECT_STATES.LOADED) this.Callback_OnLoaded();
	}
	IsActive() {
		return this.is_active;
	}
	SetState(state) {
		this.state = state;
	}
	OnLoad() {
		this.SetState(WEB_OBJECT_STATES.LOADED);
		if (this.IsActive()) this.Activate();
	}
	Callback_Default() {}
	Callback_OnLoaded() {}
}