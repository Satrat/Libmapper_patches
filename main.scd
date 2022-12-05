
// Setup libmapper and load signals for all patches
(
"setup/Setup.scd".loadRelative;
s.waitForBoot {
	Mapper.enable("SuperCollider");
	Task({
		6.wait;
		("load_artificial.scd").loadRelative;
		6.wait;
		("load_natural.scd").loadRelative;
		6.wait;
		("signal_buses.scd").loadRelative;
		6.wait;
		("play.scd").loadRelative;
	}).start;
};
)

// Stop all the patches
("stop.scd").loadRelative;