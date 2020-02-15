run("Close All");
open("/Users/paxcalpt/Desktop/Pumpy movie tifs/SMovie 2/5C.tif");

imOriginal = getTitle();
w = getWidth();
h = getHeight();
ns = nSlices;

function buildImageFromRoi(doRoi) {
	selectImage(imOriginal);
	run("Select None");
	run("Duplicate...", "title=imRGB duplicate");
	run("RGB Color");
	run("Scale Bar...", "width=5 height=16 font=50 color=White background=None location=[Lower Right] bold hide label");
	
	imRGB = getTitle();
	selectImage("imRGB");
	close();
	if (doRoi) {
		run("Restore Selection");
		run("Make Band...", "band=0.3");
		setForegroundColor(255, 255, 255);
		run("Fill", "slice");
	}

	selectImage(imOriginal);
	if (doRoi) run("Restore Selection");	

	selectImage(imOriginal);
	run("Duplicate...", "title=imCh1 duplicate channels=1");
	//run("Grays");
	run("NanoJ-Orange");
	//run("Enhance Contrast...", "saturated=0.3");
	run("RGB Color");
	run("Size...", "width="+(w/2)+" height="+(h/2)+" constrain average interpolation=Bicubic");
	setFont("SansSerif", 60, "bold");
	drawString("Actin", w/4-80, h/2-10);

	selectImage(imOriginal);
	run("Duplicate...", "title=imCh2 duplicate channels=3");
	//run("Grays");
	run("NanoJ-Orange");
	//run("Enhance Contrast...", "saturated=0.3");
	run("RGB Color");
	run("Size...", "width="+(w/2)+" height="+(h/2)+" constrain average interpolation=Bicubic");
	setFont("SansSerif", 60, "bold");
	drawString("Vimentin", w/4-80, h/2-10);

	selectImage(imOriginal);
	run("Duplicate...", "title=imCh3 duplicate channels=5");
	//run("Grays");
	run("NanoJ-Orange");
	//run("Enhance Contrast...", "saturated=0.3");
	run("RGB Color");
	run("Size...", "width="+(w/2)+" height="+(h/2)+" constrain average interpolation=Bicubic");
	setFont("SansSerif", 60, "bold");
	drawString("Tubulin", w/4-80, h/2-10);

	selectImage(imOriginal);
	run("Duplicate...", "title=imCh4 duplicate channels=4");
	//run("Grays");
	run("NanoJ-Orange");
	//run("Enhance Contrast...", "saturated=0.3");
	run("RGB Color");
	run("Size...", "width="+(w/2)+" height="+(h/2)+" constrain average interpolation=Bicubic");
	setFont("SansSerif", 60, "bold");
	drawString("Clathrin", w/4-80, h/2-10);

	selectImage(imOriginal);
	run("Duplicate...", "title=imCh5 duplicate channels=2");
	//run("Grays");
	run("NanoJ-Orange");
	//run("Enhance Contrast...", "saturated=0.3");
	run("RGB Color");
	run("Size...", "width="+(w/2)+" height="+(h/2)+" constrain average interpolation=Bicubic");
	setFont("SansSerif", 60, "bold");
	drawString("TOM20", w/4-80, h/2-10);

	run("Combine...", "stack1=imCh1 stack2=imCh2");
	rename("imCh12");
	run("Combine...", "stack1=[imRGB (RGB)] stack2=[imCh12] combine");
	rename("imChRGB12");
	run("Combine...", "stack1=imCh5 stack2=imCh4 combine");
	rename("imCh54");
	run("Combine...", "stack1=imCh54 stack2=imCh3 combine");
	rename("imCh543");
	run("Combine...", "stack1=imChRGB12 stack2=imCh543");

	run("Size...", "width=1000 height=1000 constrain average interpolation=Bicubic");
}

setBatchMode(1);


buildImageFromRoi(false);
rename("imContainer");


for (n=1.5; n<=4; n+=0.1) {
	run("Add Slice");
	selectImage(imOriginal);
	makeRectangle(n*200, n*150, w/n, h/n);
	buildImageFromRoi(true);
	run("Copy");
	close();
	selectImage("imContainer");
	run("Paste");
}

for (n=0; n<=8; n+=0.2) {
	run("Add Slice");
	selectImage(imOriginal);
	makeRectangle(800+(n*100), 600-(n*50), w/4, h/4);
	buildImageFromRoi(true);
	run("Copy");
	close();
	selectImage("imContainer");
	run("Paste");
}

// smallest zoom-in
for (n=0; n<=2; n+=0.2) {
	run("Add Slice");
	selectImage(imOriginal);
	makeRectangle(1600+n*70, 200+n*60, w/4-n*100, h/4-n*100);
	buildImageFromRoi(true);
	run("Copy");
	close();
	selectImage("imContainer");
	run("Paste");
}

// pause on zoom
run("Copy");
for (n=1; n<=5; n++) {	
	run("Add Slice");
	run("Paste");
}


for (n=0; n<9; n+=0.2) {
	run("Add Slice");
	selectImage(imOriginal);
	px0 = 1740;
	py0 = 320;
	w0 = w/4-200;
	h0 = h/4-200;

	px1 = 0;
	py1 = 0;
	w1 = w;
	h1 = h;

	nx = (1-n/10)*px0+(n/10)*px1;
	ny = (1-n/10)*py0+(n/10)*py1;
	nw = (1-n/10)*w0+(n/10)*w1;
	nh = (1-n/10)*h0+(n/10)*h1;
	
	makeRectangle(nx, ny, nw, nh);
	buildImageFromRoi(true);
	run("Copy");
	close();
	selectImage("imContainer");
	run("Paste");
}

for (n=0; n<1; n++) {
	run("Add Slice");
	selectImage(imOriginal);
	buildImageFromRoi(false);
	run("Copy");
	close();
	selectImage("imContainer");
	run("Paste");
}

// Grow RGB to entire FOV
slice = getSliceNumber();
for (n=0; n<=10; n+=1) {
	selectImage("imContainer");
	setSlice(slice);
	run("Select None");
	run("Copy");
	setSlice(nSlices);
	run("Add Slice");
	run("Paste");

	selectImage(imOriginal);
	run("Select None");
	run("Duplicate...", "title=imRGB duplicate");
	run("RGB Color");
	run("Scale Bar...", "width=5 height=16 font=50 color=White background=None location=[Lower Right] bold hide label");
	
	imRGB = getTitle();
	selectImage("imRGB");
	close();

	selectImage(imRGB);
	nw = 750+250*(n/10);
	nh = 750+250*(n/10);
	run("Size...", "width="+nw+" height="+nh+" constrain average interpolation=Bicubic");
	run("Copy");
	close();

	selectImage("imContainer");
	makeRectangle(0, 0, nw, nh);
	run("Paste");
}

// Band the window
selectImage(imOriginal);
run("Size...", "width="+1000+" height="+1000+" constrain average interpolation=Bicubic");
selectImage("imContainer");
slice = getSliceNumber();
setFont("SansSerif", 20, "bold");
for (n=1; n<=8; n+=0.2) {
	selectImage("imContainer");
	setSlice(slice);
	run("Select None");
	run("Copy");
	setSlice(nSlices);
	run("Add Slice");
	run("Paste");

	selectImage(imOriginal);
	setSlice(1);
	//run("Grays");
	//run("NanoJ-Orange");
	//run("Enhance Contrast...", "saturated=0.3");
	makeRectangle(0, 1000*(1-n/10), 200, 1000);
	run("Copy");
	selectImage("imContainer");
	run("Restore Selection");
	run("Paste");
	run("Make Band...", "band=0.1");
	setForegroundColor(255, 255, 255);
	run("Fill", "slice");	
	drawString("Actin", 65, 990);

	selectImage(imOriginal);
	setSlice(5);
	//run("Grays");
	//run("NanoJ-Orange");
	//run("Enhance Contrast...", "saturated=0.3");
	makeRectangle(200, 1000*(1-n/10), 200, 1000);
	run("Copy");
	selectImage("imContainer");
	run("Restore Selection");
	run("Paste");	
	run("Make Band...", "band=0.1");
	setForegroundColor(255, 255, 255);
	run("Fill", "slice");
	drawString("Tubulin", 255, 990);

	selectImage(imOriginal);
	setSlice(3);
	//run("Grays");
	//run("NanoJ-Orange");
	run("Enhance Contrast...", "saturated=0.1");
	makeRectangle(400, 1000*(1-n/10), 200, 1000);
	run("Copy");
	selectImage("imContainer");
	run("Restore Selection");
	run("Paste");	
	run("Make Band...", "band=0.1");
	setForegroundColor(255, 255, 255);
	run("Fill", "slice");
	drawString("Vimentin", 460, 990);

	selectImage(imOriginal);
	setSlice(4);
	//run("Grays");
	//run("NanoJ-Orange");
	run("Enhance Contrast...", "saturated=0.3");
	makeRectangle(600, 1000*(1-n/10), 200, 1000);
	run("Copy");
	selectImage("imContainer");
	run("Restore Selection");
	run("Paste");
	run("Make Band...", "band=0.1");
	setForegroundColor(255, 255, 255);
	run("Fill", "slice");
	drawString("Clathrin", 655, 990);

	selectImage(imOriginal);
	setSlice(2);
	//run("Grays");
	//run("NanoJ-Orange");
	run("Enhance Contrast...", "saturated=0.3");
	makeRectangle(800, 1000*(1-n/10), 200, 1000);
	run("Copy");
	selectImage("imContainer");
	run("Restore Selection");
	run("Paste");	
	run("Make Band...", "band=0.1");
	setForegroundColor(255, 255, 255);
	run("Fill", "slice");
	drawString("TOM20", 865, 990);
}

selectImage("imContainer");
run("Select None");
run("Copy");
for (n=1; n<=20; n++) {	
	run("Add Slice");
	run("Paste");
}

newImage("title", "RGB black", 1000, 1000, 1);
xOffset = 50;
yOffset = 425;

setFont("SansSerif", 25, "bold");
drawString("Automated Multiplex Super-Resolution with NanoJ-Optofluidics", xOffset, yOffset);

setFont("SansSerif", 25, "italic");
drawString("Almada & Pereira et al., BioRXiv, 2018", xOffset, yOffset+50);

setFont("SansSerif", 25);
drawString("COS7 cells imaged by single channel dSTORM", xOffset+50, yOffset+150);
drawString("then by four channel Exchange-PAINT", xOffset+50, yOffset+200);

run("Copy");
for (n=1; n<=30; n+=1) {
	run("Add Slice");
	run("Paste");
}

run("Concatenate...", "  title=Final image1=title image2=imContainer image3=[-- None --]");

//selectImage("imContainer");
setBatchMode(0);
