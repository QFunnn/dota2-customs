--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


const CONTEXT = $.GetContextPanel();
const MAIL_LIST = $("#MailList");
const MAIL_ACTIVE_TAB = $("#ActiveMailTab");
const MAIL_ATTACHMENTS = $("#MailAttachments");
const MAIL_BUTTON = $("#MailButton");

let selected_mail_id;
let selected_mail_entry;
let mails = {};
let mail_entries = {};

function SetMailPanelState(state) {
	CONTEXT.SetHasClass("visible", state);
}

function ToggleMailPanel() {
	GameUI.CloseTopBanner("NewMail");
	const new_state = !CONTEXT.BHasClass("visible");
	CONTEXT.SetHasClass("visible", new_state);
	if (new_state) OpenFirstMail();
}

function OpenFirstMail() {
	const keys = Object.keys(mails).reverse();
	CONTEXT.SetHasClass("no_mails", keys.length == 0);

	if (keys.length > 0) {
		OpenMailWithId(keys[0], true);
	}

	MAIL_LIST.ScrollToTop();
}

function MailButtonPressed() {
	let mail_data = mails[selected_mail_id];
	if (!mail_data) return;
	const is_active_mail_claimed = mail_data.is_claimed == 1;
	if (is_active_mail_claimed) {
		// delete
		delete mails[selected_mail_id];
		delete mail_entries[selected_mail_id];

		GameEvents.SendToServerEnsured("WebMail:delete_mail", {
			mail_id: selected_mail_id,
		});
		selected_mail_entry.DeleteAsync(0);
		selected_mail_id = undefined;
		selected_mail_entry = undefined;

		OpenFirstMail();
	} else {
		// claim
		mail_data.is_claimed = 1;
		MAIL_ACTIVE_TAB.SetHasClass("is_claimed", true);
		selected_mail_entry.SetHasClass("is_claimed", true);

		MAIL_BUTTON.SetDialogVariableLocString("label", "mail_delete");

		GameEvents.SendToServerEnsured("WebMail:claim_mail", {
			mail_id: selected_mail_id,
		});
	}
}

function CreateAttachment(attachment_name, count) {
	const attachment_panel = $.CreatePanel("Panel", MAIL_ATTACHMENTS, attachment_name);
	attachment_panel.BLoadLayoutSnippet("attachment");
	attachment_panel.AddClass(attachment_name);
	attachment_panel.SetDialogVariableInt("count", count);
	attachment_panel.SwitchClass("ci_item_rarity", GameUI.Inventory.GetItemRarityName(attachment_name) || "COMMON");
	attachment_panel.SwitchClass("ci_item_slot", GameUI.Inventory.GetItemSlotName(attachment_name) || "slot_none");

	const image_panel = attachment_panel.GetChild(0).GetChild(0);
	let is_currency = false;

	switch (attachment_name) {
		case "currency": {
			image_panel.SetImage("file://{images}/custom_game/collection/currency_icon.png");
			is_currency = true;
			break;
		}
		default: {
			const image_path = GameUI.Inventory.GetItemImagePath(attachment_name);
			image_panel.SetImage(image_path);
		}
	}

	attachment_panel.SetHasClass("single", is_currency ? false : count == 1);
	attachment_panel.SetPanelEvent("onmouseover", () => {
		$.DispatchEvent(
			"UIShowCustomLayoutParametersTooltip",
			attachment_panel,
			"CustomItem_Tooltip",
			"file://{resources}/layout/custom_game/collection/item_tooltip/item_tooltip.xml",

			BuildTooltipParams({
				currency: is_currency ? count : 0,
				items: is_currency ? undefined : { [attachment_name]: count },
			}),
		);
	});
	attachment_panel.SetPanelEvent("onmouseout", () => {
		$.DispatchEvent("UIHideCustomLayoutTooltip", attachment_panel, "CustomItem_Tooltip");
	});

	GameUI.FillChatWheelContent(attachment_name, attachment_panel);
}

function OpenMailWithId(id, skip_opening) {
	const mail_data = mails[id];
	if (!mail_data) return;

	if (!skip_opening) {
		SetMailPanelState(true);
	}

	const mail_entry = mail_entries[id];

	if (selected_mail_entry) selected_mail_entry.SetHasClass("selected", false);
	mail_entry.SetHasClass("selected", true);
	selected_mail_entry = mail_entry;

	selected_mail_id = id;
	const is_claimed = mail_data.is_claimed == 1;
	MAIL_ACTIVE_TAB.SetDialogVariable("topic", $.Localize(mail_data.topic));
	MAIL_ACTIVE_TAB.SetDialogVariable("source", $.Localize(mail_data.source));
	MAIL_ACTIVE_TAB.SetDialogVariable("text_content", mail_data.text_content);
	MAIL_ACTIVE_TAB.SetDialogVariable("created_at", mail_data.created_at.substring(0, 19));
	MAIL_ACTIVE_TAB.SetHasClass("is_claimed", is_claimed);

	MAIL_ATTACHMENTS.RemoveAndDeleteChildren();

	MAIL_BUTTON.SetDialogVariableLocString("label", is_claimed ? "mail_delete" : "mail_claim");

	if (mail_data.attachments) {
		for (const [attachment_name, data] of Object.entries(mail_data.attachments)) {
			if (attachment_name == "items") {
				for (const [name, count] of Object.entries(data)) {
					CreateAttachment(name, count);
				}
			} else {
				CreateAttachment(attachment_name, data);
			}
		}
	}
}

function UpdateMails(event) {
	MAIL_LIST.RemoveAndDeleteChildren();
	selected_mail_entry = undefined;
	selected_mail_id = undefined;
	// reversing since server fetches from first mail to last, and we are interested in latest on top
	for (const [_, mail] of Object.entries(event.mails || {}).reverse()) {
		const is_claimed = mail.is_claimed == 1;
		if (!is_claimed) GameUI.OpenTopBanner("NewMail");

		mails[mail.id] = mail;
		const mail_entry = $.CreatePanel("Panel", MAIL_LIST, mail.id);
		mail_entry.BLoadLayoutSnippet("mail_entry");

		mail_entry.SetDialogVariable("topic", $.Localize(mail.topic));
		mail_entry.SetHasClass("is_claimed", is_claimed);

		mail_entry.SetPanelEvent("onactivate", () => {
			OpenMailWithId(mail.id);
		});

		mail_entries[mail.id] = mail_entry;
	}

	OpenFirstMail();
}

(() => {
	const frame = GameEvents.NewProtectedFrame(CONTEXT);
	frame.SubscribeProtected("WebMail:update", UpdateMails);

	GameEvents.SendToServerEnsured("WebMail:get_mails", {});

	GameUI.OpenMailWithId = OpenMailWithId;
	GameUI.ToggleMailPanel = ToggleMailPanel;
})();