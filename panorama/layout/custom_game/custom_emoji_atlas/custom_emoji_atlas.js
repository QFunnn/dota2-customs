--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


let first_click = false;

function InitEmojiAtlas() {
	first_click = true;

	const iterations = Math.ceil(MAX_ID / BANDWICH_SIZE);

	for (let iteration_id = 0; iteration_id <= iterations; iteration_id++) {
		let list = [];
		const delay = 0.01 * iteration_id;
		$.Schedule(delay, () => {
			for (let id = iteration_id * BANDWICH_SIZE; id < BANDWICH_SIZE + iteration_id * BANDWICH_SIZE; id++) {
				const panel = $.CreatePanel("Panel", HUD.EMOJI_CONTAINER, "");
				panel.BLoadLayoutSnippet("EA_Emoji");

				panel.SetDialogVariable("emoji_id", id);

				panel.emoji = $.CreatePanel("DOTAEmoticon", panel.FindChildTraverse("EA_E_Container"), "", {
					emoticonid: id,
				});

				list.push(panel);
			}
		});

		$.Schedule(2 + delay, () => {
			list.forEach((c) => {
				if (!c.emoji.contentwidth > 0) c.DeleteAsync(0);
			});
			list = null;
		});
	}
}

function ToggleEmojiAtlas() {
	if (!first_click) InitEmojiAtlas();
	HUD.CONTEXT.ToggleClass("BShow");
}

(function () {
	HUD.EMOJI_CONTAINER.RemoveAndDeleteChildren();

	if (!Game.IsInToolsMode()) return;

	HUD.CONTEXT.SetHasClass("BAvailableAtlas", true);
})();