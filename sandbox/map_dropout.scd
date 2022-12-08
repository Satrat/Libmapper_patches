"setup/Setup.scd".loadRelative;
Mapper.enable("DropoutTest");

(
~sin_harm = {arg freq = 80, rate = 1.0, amp = 1.0;
	var n = 12;
	Mix.fill(n, {arg index;
		var f;
		f = freq * (index + 1);
		SinOsc.ar([f, f * 1.01], 0.0, 1/n * amp * LFNoise1.kr(rate))
	})
};

~sin_harm.set(\freq, (67 - 12).midicps, \rate, 8, \amp, 0.8);
~lossy_wave = {
	var mode;
	mode = MapIn.kr(\dropMode, 1, 2).round;
    WaveLoss.ar(~sin_harm, MapIn.kr(\dropAmnt, 0, 40), 40, mode: mode, mul: 0.8);
};
)

~lossy_wave.play;

~lossy_wave.stop;

(
{MapOut.kr(SinOsc.kr(0.5), \sineTest, 0, 1)}.play;
{MapOut.kr(Control.kr(0.0), \staticTest1, 0, 1)}.play;
{MapOut.kr(Control.kr(1.0), \staticTest2, 0, 1)}.play;
)