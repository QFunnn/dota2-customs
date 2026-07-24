--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


class ChatWheelDND {
	constructor(parent, snippet_name, b_register_dnd = true) {
		this.panel = $.CreatePanel("Panel", parent, "");
		this.panel.BLoadLayoutSnippet(snippet_name);

		this.panel.slot_name = "ChatWheel";
		this.panel.rarity_name = "rare";
		this.source_type = W_SOURCE_TYPE.NONE;

		this.cw_type = -1;
		this.available = false;

		if (!b_register_dnd) return;

		this.panel.SetDraggable(true);

		this.panel.SetPanelEvent("onactivate", () => {
			this.CheckAvailableState();
		});

		const register_event = (name) => {
			$.RegisterEventHandler(name, this.panel, (...args) => {
				this[`On${name}`](...args);
			});
		};
		register_event("DragStart");
		register_event("DragEnd");
	}
	Copy() {
		if (!this.copy_args) return;

		return new this.constructor(...this.copy_args);
	}
	GetPanel() {
		return this.panel;
	}
	CheckAvailableState() {
		if (this.available) {
			$.DispatchEvent("DropInputFocus");
			return;
		}

		GameUI.Collection.PurchaseCosmeticItem(this.panel);
	}
	SetAvailable(state) {
		this.available = state;
		if (state) {
			this.panel.SetDialogVariableLocString("open_price", "action_PASSIVE");
			this.panel.RemoveClass("BClosed");

			this.panel.GetParent().AddClass("BHasOwnedContent");
		}
	}
	OnDragStart(_, drag_callbacks) {
		if (!this.available) return;

		$.DispatchEvent("DropInputFocus");
		$.DispatchEvent("DOTAHideAbilityTooltip");
		this.panel.SetHasClass("DragSource", true);

		const draggable_panel = this.Copy().GetPanel();
		drag_callbacks.displayPanel = draggable_panel;
		draggable_panel.AddClass("BDraggablePanel");

		WHEEL_HUD.CONTEXT.SetHasClass("BStartChatWheelDrag", true);
	}
	OnDragEnd(_, dragged_panel) {
		this.panel.SetHasClass("DragSource", false);
		WHEEL_HUD.CONTEXT.SetHasClass("BStartChatWheelDrag", false);
		dragged_panel.DeleteAsync(0);
	}
	SetSource(source_def) {
		this.panel.source_def = source_def;

		this.panel.SetHasClass("BClosed", true);

		if (source_def.currency) {
			this.source_type = W_SOURCE_TYPE.CURRENCY;

			this.panel.SetDialogVariable("open_price", source_def.currency);
		} else if (source_def.treasure) {
			this.source_type = W_SOURCE_TYPE.TREASURE;

			this.panel.SetDialogVariable("open_price", source_def.treasure);
		}

		if (!source_def.other) this.panel.GetParent().AddClass("BHasNonOtherContent");

		this.panel.SwitchClass("source-type", `CW_Source_${W_SOURCE_TYPE_NAMES[this.source_type]}`);
	}
	ResetSource() {
		this.SetSource(this.panel.source_def);
	}
	SavePath() {
		const parent = this.panel.GetParent();
		this.panel.cached_pos_number = parent.Children().indexOf(this.panel);

		this.panel.reset_parent = () => {
			this.panel.SetParent(parent);
		};
	}
}