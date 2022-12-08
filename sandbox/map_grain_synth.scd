"setup/Setup.scd".loadRelative;
Mapper.enable("GranularTest");


//Granular synthesis
(
j = Buffer.read(s, thisProcess.nowExecutingPath.dirname++"/audio/mono_leaf_loop1.wav");
~grain =  { |envbuf = -1|
    var pointer, size, rand;
    // pointer - move from beginning to end of soundfile over 15 seconds
    pointer = LFSaw.ar(1/15).range(0, 1);
	size = MapIn.kr(\grainSize, 0.1, 2);
	rand = MapIn.kr(\grandAmnt, 0, 1);
    Warp1.ar(
        numChannels:1,
        bufnum:j,
        pointer:pointer,
        freqScale: MapIn.kr(\fpitchVar, 0.7, 1.3);,
        windowSize:size,
        envbufnum:envbuf,
        overlaps:4,
        windowRandRatio:rand,
        interp:2
    )
}
)

(
var winenv = Env([0, 1, 0], [0.5, 0.5], [8, -8]);
z = Buffer.sendCollection(s, winenv.discretize, 1);

~grain.set(\envbuf, z);
)

~grain.play;
~grain.stop;

(
{MapOut.kr(SinOsc.kr(0.5), \sineTest, 0, 1)}.play;
{MapOut.kr(Control.kr(0.0), \staticTest1, 0, 1)}.play;
{MapOut.kr(Control.kr(1.0), \staticTest2, 0, 1)}.play;
)