(
p[\bp_saw] = Pbind(\instrument,\bpfsaw,\f,Pkey(\freq),\scale,Scale.minor,\root,0,\degree,0,\octave,4,\dur, 1, \pan,0,\detune,0.1,\cfmin,500, \cfmax,4000, \cfhzmin, 0.1, \cfhzmax, 2, \amp, 0.15);

p[\bp_saw2] = Pbind(\instrument,\bpfsaw,\f,Pkey(\freq),\scale,Scale.minor,\root,0,\degree,0,\octave,3,\dur, 1, \pan,0, \detune,0.1,\cfmin,500, \cfmax,3000, \cfhzmin, 0.1, \cfhzmax, 2, \amp, 0.15);

p[\bp_saw3] = Pbind(\instrument,\bpfsaw,\f,Pkey(\freq),\scale,Scale.minor,\root,0,\degree,0,\octave,2,\dur, 1, \pan,0, \detune,0.1,\cfmin,100, \cfmax,1000, \cfhzmin, 2, \cfhzmax, 2, \lsf, 50, \amp, 0.15);

//p[\bp_saw].play;
//p[\bp_saw2].play;
//p[\bp_saw3].play;


j = Buffer.read(s, thisProcess.nowExecutingPath.dirname++"/audio/glitchy_drum_loop.wav");
p[\grain] =  { arg size = 0.1, rand = 0.2, scale = 1.0, amp = 0.3;
    var pointer, set_rand, set_scale, set_size;
    // pointer - move from beginning to end of soundfile over 6 seconds
    pointer = LFSaw.ar(1/6).range(0, 1);
	set_rand = 0.2; //rand;
	set_scale = 1.0; //scale + 0.25;
	set_size = 0.1; //size + 0.05;
    Warp1.ar(
        numChannels:2,
        bufnum:j,
        pointer:pointer,
        freqScale:set_scale,
        windowSize: set_size,
        envbufnum:-1,
        overlaps:5, //TODO: controllable? but needs to be an int
        windowRandRatio:set_rand,
        interp:2
	) * SinOsc.ar(p.clock.tempo / 8, 0.5, 0.5) * amp
};

//p[\grain].play;

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

p[\ring1] = Pbind(\instrument,\ring1,\f,Pkey(\freq),\scale,Scale.minor,\root,0,\degree,0,\octave,5,\dur,Pseq([0.5,0.5,1],inf),\d,0.3,\amax,0.6, \amp, 0.4);
//p[\ring1].play;

p[\ring2] = Pbind(\instrument,\ring1,\f,Pkey(\freq),\scale,Scale.minor,\root,0,\degree,5,\octave,5,\dur,Pwrand([Pseq([0.25,0.25,0.25,0.25]), Pseq([0.5,0.5, 0.5]), Pseq([1,1])], [0.1, 0.2, 0.7], inf), \d,0.3,\amax,0.6, \amp, 0.4);
//p[\ring2].play;

p[\ring3] = Pbind(\instrument,\ring1,\f,Pkey(\freq),\scale,Scale.minor,\root,0,\degree,Prand([0,2,4,6,7],inf),\octave,Pwrand([6,5,4],[0.4,0.4,0.2],inf),\dur,Pbjorklund2(Pwhite(10,15),16)/4, \d, 0.2, \amax, 10.0, \amp, 0.4);
//p[\ring3].play;

SynthDef(\crack, { | out=0, chaos = 1.0, atk=0.1, sus=0.2, rel=0.1, ts=1,co=3000, amp=0.2 |
	var sig, env;
	env = EnvGen.kr(Env([0,1,0.8,0],[atk,sus,rel]),timeScale:ts,doneAction:2);
	sig = Crackle.ar(chaos) * env * amp;
	Out.ar(out,[sig, sig]);
}).add;

p[\crack] = Pbind(\instrument,\crack, \dur,Pseq([1],inf), \atk, 0.01, \sus, 0.01, \amp, 0.6, \rel, 0.1, \chaos, 2.0);
//p[\crack].play;
)