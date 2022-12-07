
// Setup libmapper and load signals for all patches
(
"setup/Setup.scd".loadRelative;
s.waitForBoot {
	Mapper.enable("SuperCollider");
	Task({
		3.wait;
		("load_artificial.scd").loadRelative;
		3.wait;
		("load_natural.scd").loadRelative;
		3.wait;
		("natural_signals.scd").loadRelative;
		("artificial_signals.scd").loadRelative;
		3.wait;
		("play.scd").loadRelative;
	}).start;
};
)


// Stop all the patches
//("stop.scd").loadRelative;