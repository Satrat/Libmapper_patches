//Boilerplate code for basic live coding functionality

(

// define a server, SATIE needs it
s = Server.scsynth.local;
// instantiate a SatieConfiguration. Here we will use a stereo spatializer (headphones)
~satieConfiguration = SatieConfiguration.new(s, [\stereoListener]); //change spatializer based on # of speakers
// list possible listeners:
~satieConfiguration.spatializers.keys;
// instantiate SATIE renderer and pass it the configuration
~satie = Satie.new(~satieConfiguration);
~satie.waitForBoot({
    // display some information
    s.meter;
    s.makeGui;
    s.plotTree;

	s.options.numBuffers = 1024 * 16;
	s.options.memSize = 8192 * 64;
	s.scope;
	p=ProxySpace.push(s);
	p.makeTempoClock;
	p.clock.tempo = 2;
	p.fadeTime = 0.01;
});


Task({
	3.wait;
	("SynthDefs.scd").loadRelative;
	//wait, because otherwise it won't work for some reason
	3.wait;
	//activate StageLimiter - Part of the BatLib quark
	StageLimiter.activate;
	"Setup done!".postln;
}).start;
)
