
// Setup libmapper and load signals for all patches
(
"setup/Setup.scd".loadRelative;
s.waitForBoot {
	Mapper.enable("SuperCollider");
	Task({
		3.wait;
		("load_humans.scd").loadRelative;
		3.wait;
		("load_natural.scd").loadRelative;
		3.wait;
		("natural_signals.scd").loadRelative;
		("humans_signals.scd").loadRelative;
		3.wait;
		("play.scd").loadRelative;
	}).start;
};
)

// Output amplitude envelopes of select instruments to Libmapper
// NOT WORKING RN
(
{MapOut.kr(Amplitude.kr(p[\crunchy]), \crunchy, 0, 1)}.play;
{MapOut.kr(Amplitude.kr(p[\branch]), \nature_perc, 0, 1)}.play;
{MapOut.kr(Amplitude.kr(p[\sin_syn]), \nature_lead, 0, 1)}.play;

{MapOut.kr(Amplitude.kr(p[\ring1] + p[\ring2]), \human_bg, 0, 1)}.play;
{MapOut.kr(Amplitude.kr(p[\ring3]), \human_lead, 0, 1)}.play;
{MapOut.kr(Amplitude.kr(p[\crack]), \human_perc, 0, 1)}.play;
)