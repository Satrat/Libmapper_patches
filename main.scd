
// Setup libmapper and load signals for all patches
(
"setup/Setup.scd".loadRelative;
s.waitForBoot {
	Mapper.enable("SuperCollider");
	Task({
		6.wait;
		("load_humans.scd").loadRelative;
		6.wait;
		("load_natural.scd").loadRelative;
		6.wait;
		("natural_signals.scd").loadRelative;
		6.wait;
		("humans_signals.scd").loadRelative;
		6.wait;
		("load_between.scd").loadRelative;
		6.wait;
		("play.scd").loadRelative;
	}).start;
};
)

// Output amplitude envelopes of select instruments to Libmapper
// to be used in visuals
(
{MapOut.kr(Amplitude.kr(In.ar(m)),"sc/nature/crunchy",0,1)}.play;
{MapOut.kr(Amplitude.kr(In.ar(n)), "sc/nature/percussion", 0, 1)}.play;
{MapOut.kr(Amplitude.kr(In.ar(o)), "sc/nature/lead", 0, 1)}.play;

{MapOut.kr(Amplitude.kr(In.ar(q)),"sc/humans/counter_lead",0,1)}.play;
{MapOut.kr(Amplitude.kr(In.ar(r)), "sc/humans/lead", 0, 1)}.play;
{MapOut.kr(Amplitude.kr(In.ar(s)), "sc/humans/percussion", 0, 1)}.play;
)