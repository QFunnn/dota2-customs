--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


class RedNode {
	state = false;
	children = {};
	constructor(parent, child) {
		this.parent = parent;
		if (child) {
			this.children = child;
		}
	}
	SetState(b) {
		if (Object.keys(this.children).length > 0) {
			if (Game.IsInToolsMode()) {
				$.Msg("!!!!!!!!!! try set node with children");
			}
			return;
		}
		if (this.state != b) {
			this.state = b;
			if (this.parent) {
				if (this.state != this.parent.state) {
					this.parent.UpdateState();
				}
			}
			return true;
		}
	}
	UpdateState() {
		let newState = Object.values(this.children).some(c => c.state == true);
		if (newState != this.state) {
			this.state = newState;
			if (this.parent && this.state != this.parent.state) {
				this.parent.UpdateState();
			}
		}
	}
}
let CustomUIConfig = GameUI.CustomUIConfig();
if (CustomUIConfig.RedPointRootNodes == undefined) {
	CustomUIConfig.RedPointRootNodes = {};
}
if (CustomUIConfig.RedPointEasyMap == undefined) {
	CustomUIConfig.RedPointEasyMap = {};
}
CustomUIConfig.SetRedPoint = (state, rootKey, ..._keys) => {
	let node = CustomUIConfig.RedPointRootNodes[rootKey];
	let easyKey = rootKey;
	if (node == undefined) {
		node = new RedNode();
		CustomUIConfig.RedPointRootNodes[rootKey] = node;
		CustomUIConfig.RedPointEasyMap[easyKey] = node;
	}
	for (const k of _keys) {
		easyKey += "$" + k;
		let n = node.children[k];
		if (n == undefined) {
			n = new RedNode(node);
			node.children[k] = n;
			CustomUIConfig.RedPointEasyMap[easyKey] = n;
		}
		node = n;
	}
	let changed = node.SetState(state);
	if (changed) {
		GameEvents.SendEventClientSide("client_side_event", {
			event_name: "red_point_changed",
			event_data: rootKey
		});
	}
};
CustomUIConfig.SubscribeRedPointChange = (callback, rootKey) => {
	return GameEvents.Subscribe("client_side_event", data => {
		if (data.event_name == "red_point_changed") {
			if (rootKey == undefined || data.event_data == rootKey) {
				callback(data.event_data);
			}
		}
	});
};
CustomUIConfig.GetRedPoint = (rootKey, ...keys) => {
	let easyKey = [rootKey, ...keys].join("$");
	return CustomUIConfig.RedPointEasyMap[easyKey]?.state == true;
};
// $.Msg("red point init ok");