"setup/Setup.scd".loadRelative;
Mapper.enable("SuperCollider");

(
SynthDef(\sin_synth, { | out=0, freq = 220, amp = 0.3, atk=0.01, sus=0.2, rel=0.1, ts=1, fb=0,cutoff=400 |
	var sig, env;
	env = EnvGen.kr(Env([0,1,0.8,0],[atk,sus,rel]),timeScale:ts,doneAction:2);
	sig = SinOscFB.ar(freq, fb);
	sig = BLowPass.ar(sig*env*amp,cutoff,2.0,1.0,0.0);
	Out.ar(out,[sig, sig]);
}).add;
)
~sin_syn = Pbind(\instrument,\sin_synth,\f,Pkey(\freq),\scale,Scale.major,\root,0,\degree,Prand([0,2,4,6,7],inf),\octave,6, \dur,Pwrand([Pseq([0.5,0.5]),Pseq([0.25,0.25,0.25,0.25]), Pseq([0.5,0.5,8])],[0.3,0.3, 0.4],inf),\amp,0.4,\sus,0.1,\atk,0.05, \rel,0.5, \amp, MapIn("TEST/sin_amp", 0,0.5));

(
var sinAmp = Mapper.makeInSignalBus(s, "TEST/sin_amp", 0.0, 0.5);
~sin_syn.map(\amp, sinAmp);
)

~sin_syn.play;

	~test = Synth(\sin_synth);