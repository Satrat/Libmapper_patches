
// Setup libmapper and load signals for all patches
(
"setup/Setup.scd".loadRelative;
s.waitForBoot {
	Mapper.enable("SuperCollider");
	Task({
		6.wait;
		//("load_artificial.scd").loadRelative;
		3.wait;
		("load_natural.scd").loadRelative;
		3.wait;
		("natural_signals.scd").loadRelative;
		//("artificial_signals.scd").loadRelative;
		3.wait;
		("play.scd").loadRelative;
	}).start;
};
)

(
~sin_harm_bass = {arg freq = 65.40639132515, amp = 0.4, rate=1.0;
	var n = 8;
	Mix.fill(n, {arg index;
		var f;
		f = freq * (index + 1);
		SinOsc.ar([f, f * 1.01], 0.0, 1/n * amp * LFNoise1.kr(rate))
	})
};
)

~lfo = {MapIn.kr("test_proxy", 0.0, 1.0)};
~sin_harm_bass.map(\amp, ~lfo);
~sin_harm_bass.play;


// Stop all the patches
("stop.scd").loadRelative;
