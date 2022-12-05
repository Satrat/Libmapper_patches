"setup/Setup.scd".loadRelative;
Mapper.enable("SuperCollider");

(
~bp_saw = Pbind(\instrument,\bpfsaw,\f,Pkey(\freq),\scale,Scale.minor,\root,0,\degree,0,\octave,4,\dur, 1, \pan,0,\detune,0.1,\cfmin,500, \cfmax,5000, \cfhzmin, 0.1);

~bp_saw2 = Pbind(\instrument,\bpfsaw,\f,Pkey(\freq),\scale,Scale.minor,\root,0,\degree,0,\octave,3,\dur, 1, \pan,0, \detune,0.1,\cfmin,500, \cfmax,3000, \cfhzmin, 0.1);

~bp_saw3 = Pbind(\instrument,\bpfsaw,\f,Pkey(\freq),\scale,Scale.minor,\root,0,\degree,0,\octave,2,\dur, 1, \pan,0, \detune,0.1,\cfmin,100, \cfmax,1000, \cfhzmin, 2, \lsf, 50);

j = Buffer.read(s, thisProcess.nowExecutingPath.dirname++"/audio/glitchy_drum_loop.wav");
~grain =  { |envbuf = -1|
    var pointer, size, rand;
    // pointer - move from beginning to end of soundfile over 6 seconds
    pointer = LFSaw.ar(1/6).range(0, 1);
	size = MapIn.kr("humans/grain/size", 0.01, 0.5);
	rand = MapIn.kr("humans/grain/rand", 0, 0.5);
    Warp1.ar(
        numChannels:1,
        bufnum:j,
        pointer:pointer,
        freqScale:MapIn.kr("humans/grain/freqScale", 0.25, 1.25),
        windowSize:size,
        envbufnum:envbuf,
        overlaps:5, //TODO: controllable but needs to be an int
        windowRandRatio:rand,
        interp:2
	) * SinOsc.ar(p.clock.tempo / 4, 0.5, 0.5) * MapIn.kr("humans/grain/amp", 0.0, 0.5)
	//TODO: make sinOsc controllable but needs to be a power of 2
};

SynthDef(\ring1,
	{
		arg f = 45, amax = 9, d = 0.6, pan = 0, amp = 1, out = 0;
		var sig, env, a;
		a = Pexprand(0.6, amax).asStream;
		env = Line.kr(0,1,d);
		env = FreeSelfWhenDone.kr(env);
		sig = Impulse.ar(0);
		sig = Ringz.ar(sig,f,d,a);
		Out.ar(out,Pan2.ar(sig.tanh,pan) * amp)
	};
).add;

~ring1 = Pbind(\instrument,\ring1,\f,Pkey(\freq),\scale,Scale.minor,\root,0,\degree,0,\octave,5,\dur,Pseq([0.5,0.5,1],inf),\d,0.3,\amax,0.6);

~ring2 = Pbind(\instrument,\ring1,\f,Pkey(\freq),\scale,Scale.minor,\root,0,\degree,5,\octave,5,\dur,Pwrand([Pseq([0.25,0.25,0.25,0.25]), Pseq([0.5,0.5, 0.5]), Pseq([1,1])], [0.1, 0.2, 0.7], inf), \d,0.3,\amax,0.6);

~ring3 = Pbind(\instrument,\ring1,\f,Pkey(\freq),\scale,Scale.minor,\root,0,\degree,Prand([0,2,4,6,7],inf),\octave,Pwrand([6,5,4],[0.4,0.4,0.2],inf),\dur,Pbjorklund2(Pwhite(10,15),16)/4,);

SynthDef(\crack, { | out=0, chaos = 1.0, atk=0.1, sus=0.2, rel=0.1, ts=1,co=3000 |
	var sig, env;
	env = EnvGen.kr(Env([0,1,0.8,0],[atk,sus,rel]),timeScale:ts,doneAction:2);
	sig = Crackle.ar(chaos) * env;
	Out.ar(out,[sig, sig]);
}).add;

~crack = Pbind(\instrument,\crack, \dur,Pseq([1],inf), \atk, 0.01, \sus, 0.01);
)

(
var saw1Amp = Mapper.makeInSignalBus(s, "humans/saw1Amp", 0.0, 0.25);
var saw2Amp = Mapper.makeInSignalBus(s, "humans/saw2Amp", 0.0, 0.25);
var saw3Amp = Mapper.makeInSignalBus(s, "humans/saw3Amp", 0.0, 0.25);
var sawPad1MaxMod = Mapper.makeInSignalBus(s, "humans/sawPad1MaxMod", 1, 20);
var sawPad2MaxMod = Mapper.makeInSignalBus(s, "humans/sawPad2MaxMod", 1, 30);
var sawPad3MaxMod = Mapper.makeInSignalBus(s, "humans/sawPad3MaxMod", 1, 50);
var ring1Amp = Mapper.makeInSignalBus(s, "humans/ring/amp1", 0.0, 0.4);
var ring2Amp = Mapper.makeInSignalBus(s, "humans/ring/amp2", 0.0, 0.5);
var ring3Amp = Mapper.makeInSignalBus(s, "humans/ring/amp3", 0.0, 0.3);
var ringDecay = Mapper.makeInSignalBus(s, "humans/ring/decay", 0.1, 0.5);
var ringMult = Mapper.makeInSignalBus(s, "humans/ring/mult", 1.0, 50);
var chaosAmp = Mapper.makeInSignalBus(s, "humans/chaos/amp", 0.0, 1.0);
var chaosAmnt = Mapper.makeInSignalBus(s, "humans/chaos/amnt", 1.0, 2.0);
var chaosRelease = Mapper.makeInSignalBus(s, "humans/chaos/release", 0.01, 0.2);

~bp_saw.map(\amp, saw1Amp);
~bp_saw2.map(\amp, saw2Amp);
~bp_saw3.map(\amp, saw3Amp);
~bp_saw.map(\cfhzmax, sawPad1MaxMod);
~bp_saw2.map(\cfhzmax, sawPad2MaxMod);
~bp_saw3.map(\cfhzmax, sawPad3MaxMod);
~ring1.map(\amp, ring1Amp);
~ring2.map(\amp, ring2Amp);
~ring3.map(\amp, ring3Amp);
~ring3.map(\d, ringDecay);
~ring3.map(\amax, ringMult);
~crack.map(\rel, chaosRelease);
~crack.map(\chaos, chaosAmnt);
~crack.map(\amp, chaosAmp);
)

(
~bp_saw.play;
~bp_saw2.play;
~bp_saw3.play;
~grain.play;
~ring1.play;
~ring2.play;
~ring3.play;
~crack.play;
)

(
~bp_saw.stop;
~bp_saw2.stop;
~bp_saw3.stop;
~grain.stop;
~ring1.stop;
~ring2.stop;
~ring3.stop;
~crack.stop;
)

Quarks.install("Bjorklund");