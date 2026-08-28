--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


class FavoriteBuild {
	available = false;
	is_edit_name_mode = false;
	hero_name;

	constructor(index, tier, parent) {
		this.panel = $.CreatePanel("Panel", parent, "");
		this.panel.BLoadLayoutSnippet("F_Build");

		this.text_entry = this.panel.FindChildTraverse("FB_Name");
		this.hero_icon = this.panel.FindChildTraverse("FB_HeroIcon");

		this.default_name = `${$.Localize("favorite_build_default_name", this.panel)} #${index}`;
		this.name = this.default_name;
		this.index = index;
		this.tier = tier;

		this.panel.FindChildTraverse("FB_EditName").SetPanelEvent("onactivate", this.EditName);
		this.panel.FindChildTraverse("FB_Apply").SetPanelEvent("onactivate", this.Apply);
		this.panel.FindChildTraverse("FB_Save").SetPanelEvent("onactivate", this.Save);
		this.panel.FindChildTraverse("FB_Clear").SetPanelEvent("onactivate", this.Clear);
		this.text_entry.SetPanelEvent("onblur", this.ResetName);
		this.text_entry.SetPanelEvent("oninputsubmit", this.SaveNewName);

		this.CreateTextTooltip("FB_EditName", "#favorite_builds_edit_name_hint", true);
		this.CreateTextTooltip("FB_Apply", "#favorite_builds_apply_hint", true);
		this.CreateTextTooltip("FB_Save", "#favorite_builds_save_hint");
		this.CreateTextTooltip("FB_Clear", "#favorite_builds_clear_hint", true);

		this.UpdateData(undefined, this.name);
	}
	UpdateData(hero_name, name = this.name) {
		this.name = name;

		if (name == "") name = this.default_name;
		this.text_entry.text = name;
		this.hero_name = hero_name;

		this.panel.SetDialogVariable("build_name", name);
		this.panel.SetHasClass("BEmptyBuild", !!!hero_name);
		this.RedrawHeroIcon();
	}
	RedrawHeroIcon() {
		this.hero_icon.SetImage(GetPortraitIcon(LOCAL_PLAYER_ID, this.hero_name));
	}
	EditName = () => {
		if (!this.available) return;
		if (this.panel.BHasClass("BEmptyBuild")) return;

		if (this.is_edit_name_mode) {
			this.SaveNewName();
			return;
		}

		this.is_edit_name_mode = true;

		this.text_entry.SetFocus();
		this.UpdateEditNameClass();
	};
	SaveNewName = () => {
		const new_name = this.text_entry.text;
		this.is_edit_name_mode = false;

		$.DispatchEvent("DropInputFocus");

		if (new_name == "") return;
		if (new_name == this.name) return;

		this.name = new_name;
		this.text_entry.text = new_name;

		this.panel.SetDialogVariable("build_name", this.name);
		GameEvents.SendToServerEnsured("FavoriteBuilds:set_build_name", {
			build_id: this.index,
			build_name: this.name,
		});
		this.UpdateEditNameClass();
	};
	ResetName = () => {
		this.is_edit_name_mode = false;
		this.text_entry.text = this.name;
		this.UpdateEditNameClass();
	};
	UpdateEditNameClass() {
		this.panel.SetHasClass("BEditName", this.is_edit_name_mode);
	}
	Apply = () => {
		if (this.CheckCooldown("Apply")) return;
		if (!this.available) return;
		if (this.panel.BHasClass("BEmptyBuild")) return;

		GameEvents.SendToServerEnsured("FavoriteBuilds:apply_build", {
			build_id: this.index,
		});
		this.PingClass("BActivated");
	};
	Save = () => {
		if (this.CheckCooldown("Save")) return;
		if (!this.available) return;

		GameEvents.SendToServerEnsured("FavoriteBuilds:save_build", {
			build_id: this.index,
			build_name: this.name,
		});

		this.PingClass("BSaved");
	};
	Clear = () => {
		if (this.CheckCooldown("Clear")) return;
		if (!this.available) return;
		if (this.panel.BHasClass("BEmptyBuild")) return;

		GameEvents.SendToServerEnsured("FavoriteBuilds:clear_build", {
			build_id: this.index,
		});

		this.UpdateData(undefined, this.default_name);
		this.PingClass("BCleared");
	};
	CheckCooldown(type) {
		if (this[`cooldown_${type}`]) return true;

		this[`cooldown_${type}`] = true;
		$.Schedule(REQUEST_BUTTON_COOLDOWN, () => {
			this[`cooldown_${type}`] = false;
		});
	}
	SetAvailable(state) {
		this.available = state;
	}
	CheckAvailableByTier(tier) {
		this.SetAvailable(this.tier <= tier);
	}
	ClearPingClasses = () => {
		this.panel.RemoveClass("BActivated");
		this.panel.RemoveClass("BSaved");
		this.panel.RemoveClass("BCleared");
	};
	PingClass(class_name) {
		this.ClearPingClasses();
		this.panel.AddClass(class_name);
	}
	CreateTextTooltip(id, text, b_require_build = false) {
		const button = this.panel.FindChildTraverse(id);
		if (!button) return;
		button.SetPanelEvent("onmouseover", () => {
			if (b_require_build && this.panel.BHasClass("BEmptyBuild")) return;

			$.DispatchEvent("DOTAShowTextTooltip", button, text);
		});
	}
}