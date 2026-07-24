--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


/*
 * Temporary Panorama injection test harness.
 * Remove this file and its include in barrage.xml after testing.
 */
(function () {
	var PREFIX = "[SECURITY_INJECTION_TEST]";
	var root = $.GetContextPanel();
	var config = GameUI.CustomUIConfig();
	var markerName = "__securityInjectionTestMarker";
	var payloads = [
		'"); GameUI.CustomUIConfig().__securityInjectionTestMarker = "string-breakout"; //',
		'<script>$.Msg("mytetststststsstt");GameUI.CustomUIConfig().__securityInjectionTestMarker = "script-tag";</script>',
		'<Label onload="GameUI.CustomUIConfig().__securityInjectionTestMarker = &quot;xml-onload&quot;;" />',
		'<a href="javascript:GameUI.CustomUIConfig().__securityInjectionTestMarker = &quot;javascript-url&quot;">test</a>',
		'#{constructor.constructor("GameUI.CustomUIConfig().__securityInjectionTestMarker = \'constructor\'")()}'
	];

	function log(name, passed, detail) {
		$.Msg(PREFIX, " ", passed ? "PASS" : "FAIL", " ", name, detail == null ? "" : " | " + detail);
	}

	function resetMarker() {
		config[markerName] = "not-executed";
	}

	function markerWasNotExecuted() {
		return config[markerName] === "not-executed";
	}

	function testLabel(htmlEnabled, payload, index) {
		resetMarker();
		var label = $.CreatePanel("Label", root, "SecurityInjectionTest_" + (htmlEnabled ? "Html_" : "Text_") + index);
		label.visible = false;
		label.hittest = false;
		label.html = htmlEnabled;
		label.text = payload;

		$.Schedule(0.1, function () {
			log(
				(htmlEnabled ? "html Label" : "plain Label") + " payload " + index,
				markerWasNotExecuted(),
				"marker=" + config[markerName] + ", text=" + label.text
			);
			label.DeleteAsync(0);
		});
	}

	$.Msg(PREFIX, " START payload_count=", payloads.length);

	for (var i = 0; i < payloads.length; i++) {
		testLabel(false, payloads[i], i);
		testLabel(true, payloads[i], i);
	}

	var invalidInputs = [undefined, null, {}, 123];
	for (var j = 0; j < invalidInputs.length; j++) {
		try {
			wordFilter(invalidInputs[j]);
			log("wordFilter invalid input " + j, true, "did not throw");
		} catch (error) {
			log("wordFilter invalid input " + j, false, String(error));
		}
	}

	$.Schedule(0.2, function () {
		log("final execution marker", markerWasNotExecuted(), "marker=" + config[markerName]);
		$.Msg(PREFIX, " END");
	});
})();