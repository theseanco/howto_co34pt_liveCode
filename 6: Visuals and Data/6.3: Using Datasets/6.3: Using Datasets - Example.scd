//Using Datasets - example

("../../Setup/Setup.scd").loadRelative

//This is an example using some environmental data that I logged in 2015 in a part of my university building. It was logged to a CSV file which is included in this repo
//load the CSV file as a multi-dimensional array - Storing this within the dictonary I usualy store sample in
//note the 'flop' method, which takes columns as rows and vice versa.
//Without the flop method, each line of the CSV file would be an array entry
//startRow is worth setting at 1, so that the header line is not parsed. I'm going to start a few hundred lines in because the start of this dataset is skewed by the sensors taking a while to 'warm up'
d[\data] = CSVFileReader.readInterpret(("Datasets/ArmstrongFoyer_Data.csv").resolveRelative,true,true,startRow:1000).flop

//In the current data configuration each type of data is an index of the arrady d[\data]
d[\data][0] // An array of the date (rendered out as garbage because of the / character in each field

d[\data][1] // An array of the time (rendered out as garbage because of the - character in each field

d[\data][2] // An array of the temperature

d[\data][3] // An array of the %rh

d[\data][4] // An array of the light level

//if you want to get an idea of the form of a dataset, calling the plot method will draw a graph using the GUI
d[\data][4].plot

//If you're going to use the data in a sonification it's worth scaling it to useful values.
//Use this function to convert data to frequencies.
//the linlin, linexp, explin and expexp scaling methods can be used depending on the dataset available. As i'm going to be converting environmental data to frequency, i'll be using the linexp method
(
d[\scaleData] = {
	arg data = d[\data][3], minimum = 100, maximum = 1000;
	data.linexp(data.minItem,data.maxItem,minimum,maximum);
}
)

//scale all of the data
(
d[\temp] = d[\scaleData].(d[\data][2],100,2000);
d[\humidity] = d[\scaleData].(d[\data][3],100,2000);
d[\lux] = d[\scaleData].(d[\data][4],100,2000);
)

//Put the data inside some Pbinds and set them away. They should all finish at the same time. There is a LOT of data here, so it'll run for quite some time.
(
~temp = Pbind(\instrument,\sinfb,\freq,Pseq(d[\temp],inf),\dur,0.25,\amp,Pwhite(0.05,0.3),\fb,0.1,\rel,0.3,\atk,1,\rel,3);
~sin = {SinOsc.kr(0.1).range(0.01,1.41)};
~temp.set(\fb,~sin);
~humidity = Pbind(\instrument,\ring1,\f,Pseq(d[\humidity],1),\dur,0.25,\d,0.6,\a,1,\pan,0,\amp,0.5);
~lux = Pbind(\instrument,\ring1,\f,Pseq(d[\lux],1),\dur,0.25,\d,5,\a,Pexprand(1,30),\pan,0,\amp,0.1);
~temp.play;
~humidity.play;
~lux.play;
)

//feel free to add some percussion and use ProxySpace as normal
~k = Pbind(\instrument,\bplay,\buf,d["k"][0],\dur,1,\amp,1);
~k.play

~t = Pbind(\instrument,\bplay,\buf,d["k"][0],\dur,Pbjorklund2(Pwhite(3,24),32)/4,\amp,1,\rate,Pwhite(4,6.0));
~t.play