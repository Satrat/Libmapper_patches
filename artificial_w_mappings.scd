"setup/Setup.scd".loadRelative;
Mapper.enable("Artificial");

(
~bp_saw = Pbind(\instrument,\bpfsaw,\f,Pkey(\freq),\scale,Scale.minor,\root,0,\degree,0,\octave,4,\dur, 1, \pan,0,\amp,0.15, \detune,0.1,\cfmin,500, \cfmax,5000, \cfhzmin, 0.1, \cfhzmax, 1);

~bp_saw2 = Pbind(\instrument,\bpfsaw,\f,Pkey(\freq),\scale,Scale.minor,\root,0,\degree,0,\octave,3,\dur, 1, \pan,0,\amp,0.2, \detune,0.1,\cfmin,500, \cfmax,3000, \cfhzmin, 0.1, \cfhzmax, 5);

~bp_saw3 = Pbind(\instrument,\bpfsaw,\f,Pkey(\freq),\scale,Scale.minor,\root,0,\degree,0,\octave,2,\dur, 1, \pan,0,\amp,0.5, \detune,0.1,\cfmin,100, \cfmax,1000, \cfhzmin, 2, \cfhzmax, 10, \lsf, 50);

j = Buffer.read(s, thisProcess.nowExecutingPath.dirname++"/audio/glitchy_drum_loop.wav");
~grain =  { |envbuf = -1|
    var pointer, size, rand;
    // pointer - move from beginning to end of soundfile over 15 seconds
    pointer = LFSaw.ar(1/6).range(0, 1);
	size = 0.1; //MapIn.kr(\grainSize, 0.1, 2);
	rand = 0.2; //MapIn.kr(\grandAmnt, 0, 1);
    Warp1.ar(
        numChannels:1,
        bufnum:j,
        pointer:pointer,
        freqScale: 1,
        windowSize:size,
        envbufnum:envbuf,
        overlaps:5,
        windowRandRatio:rand,
        interp:2
	) * SinOsc.ar(0.2, 0.5, 0.5)
};

~delayed_grain = {CombL.ar(~grain,0.2, 0.2, 1)};

SynthDef(\ring1,
	{
		arg f = 45, a = 9, d = 0.6, pan = 0, amp = 1, out = 0;
		var sig, env;
		env = Line.kr(0,1,d);
		env = FreeSelfWhenDone.kr(env);
		sig = Impulse.ar(0);
		sig = Ringz.ar(sig,f,d,a);
		Out.ar(out,Pan2.ar(sig.tanh,pan) * amp)
	};
).add;


~ring1 = Pbind(\instrument,\ring1,\f,Pkey(\freq),\scale,Scale.minor,\root,0,\degree,0,\octave,5,\dur,Pseq([0.5,0.5,1],inf),\d,0.3,\a,0.6,\pan,0,\amp,0.2);

~ring2 = Pbind(\instrument,\ring1,\f,Pkey(\freq),\scale,Scale.minor,\root,0,\degree,5,\octave,5,\dur,Pwrand([Pseq([0.25,0.25,0.25,0.25]), Pseq([0.5,0.5, 0.5]), Pseq([1,1])], [0.1, 0.2, 0.7], inf), \d,0.3,\a,0.6,\pan,0,\amp,0.2);

~ring3 = Pbind(\instrument,\ring1,\f,Pkey(\freq),\scale,Scale.minor,\root,0,\degree,Prand([0,2,4,6,7],inf),\octave,Pwrand([6,5,4],[0.4,0.4,0.2],inf),\dur,Pbjorklund2(Pwhite(10,15),16)/4,\d,0.1,\a,Pexprand(0.6,50),\pan,0,\amp,0.1);

SynthDef(\crack, { | out=0, chaos = 1.0, atk=0.1, sus=0.2, rel=0.1, ts=1,co=3000 |
	var sig, env;
	env = EnvGen.kr(Env([0,1,0.8,0],[atk,sus,rel]),timeScale:ts,doneAction:2);
	sig = Crackle.ar(chaos) * env;
	Out.ar(out,[sig, sig]);
}).add;

~crack = Pbind(\instrument,\crack, \dur,Pseq([1],inf), \atk, 0.01, \sus, 0.01, \rel, 0.1, \chaos, 1.5, \amp, 1.0);
)

(
~bp_saw.play;
~bp_saw2.play;
~bp_saw3.play;
~grain.play;
~delayed_grain.play;
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
~delayed_grain.stop;
~ring1.stop;
~ring2.stop;
~ring3.stop;
~crack.stop;
)