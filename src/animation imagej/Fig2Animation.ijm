run("Close All");
open("/Users/paxcalpt/Desktop/Pumpy movie tifs/Individual/01 ROI DC HILO.tif");
open("/Users/paxcalpt/Desktop/Pumpy movie tifs/Individual/02 ROI DC STD.tif");
open("/Users/paxcalpt/Desktop/Pumpy movie tifs/Individual/03 GC ROI dSTORM.tif");

im0 = "01 ROI DC HILO.tif";
im1 = "02 ROI DC STD.tif";
im2 = "03 GC ROI dSTORM.tif";
imR = "Joint";

close("Joint");

w = getWidth();
h = getHeight();
ns = nSlices;

newImage("Joint", "8-bit black", w, h, 2);
run("Properties...", "channels=1 slices=1 frames=2 unit=um pixel_width=0.02133 pixel_height=0.0313297 voxel_depth=0.1566487 frame=[600 sec]");
setSlice(2);

selectImage(im0);
setSlice(1);
run("Properties...", "channels=1 slices=15 frames=1 unit=um pixel_width=0.02133 pixel_height=0.0313297 voxel_depth=0.1566487 frame=[600 sec]");
run("Time Stamper", "starting=10 interval=10 x=2000 y=150 font=60 decimal=0 anti-aliased or=min");
run("Label...", "format=Text starting=0 interval=1 x=095 y=2400 font=60 text=[HILO] range=0-15");

selectImage(im1);
setSlice(1);
run("Properties...", "channels=1 slices=15 frames=1 unit=um pixel_width=0.02133 pixel_height=0.0313297 voxel_depth=0.1566487 frame=[600 sec]");
run("Time Stamper", "starting=10 interval=10 x=2000 y=150 font=60 decimal=0 anti-aliased or=min");
run("Label...", "format=Text starting=0 interval=1 x=2095 y=2400 font=60 text=[SRRF] range=0-15");

selectImage(im2);
run("Properties...", "channels=1 slices=1 frames=1 unit=um pixel_width=0.02133 pixel_height=0.0313297 voxel_depth=0.1566487 frame=[600 sec]");
run("Label...", "format=Text starting=0 interval=1 x=1045 y=2400 font=60 text=[dSTORM] range=0-15");

setBatchMode(1);

// WF run
for (n=1; n<=30; n+=1) {
	selectImage(im0);
	setSlice(round(n/2));
	run("Select None");
	run("Copy");

	selectImage(imR);
	run("Select None");
	run("Paste");

	run("Add Slice");
}

// Pause 10
run("Delete Slice");
for (n=1; n<=10; n+=1) {
	selectImage(imR);
	run("Select None");
	run("Copy");
	run("Add Slice");
	run("Paste");
}

// WF to SRRF run
for (n=1; n<=30; n+=1) {
	selectImage(im0);
	setSlice(round(n/2));
	run("Select None");
	run("Copy");

	selectImage(imR);
	run("Select None");
	run("Paste");

	selectImage(im1);
	setSlice(round(n/2));
	p = (n/30);
	makeRectangle((1-p)*w, 0, w, h);
	run("Copy");

	selectImage(imR);
	makeRectangle((1-p)*w, 0, w, h);
	run("Paste");

	run("Add Slice");
}

// Pause 10
run("Delete Slice");
for (n=1; n<=10; n+=1) {
	selectImage(imR);
	run("Select None");
	run("Copy");
	run("Add Slice");
	run("Paste");
}

// SRRF to dSTORM run
for (n=1; n<=50; n+=1) {
	selectImage(im1);
	setSlice(15);
	run("Select None");
	run("Copy");

	selectImage(imR);
	run("Select None");
	run("Paste");

	selectImage(im2);
	p = (n/50);
	makeRectangle(0, (1-p)*h, w, h);
	run("Copy");

	selectImage(imR);
	makeRectangle(0, (1-p)*h, w, h);
	run("Paste");

	run("Add Slice");
}

// Pause 10
run("Delete Slice");
for (n=1; n<=10; n+=1) {
	selectImage(imR);
	run("Select None");
	run("Copy");
	run("Add Slice");
	run("Paste");
}

// WF, SRRF and dSTORM together
for (n=1; n<=50; n+=1) {
	selectImage(im2);
	run("Select None");
	run("Copy");

	selectImage(imR);
	run("Select None");
	run("Paste");

	selectImage(im0);
	p = (n/100);
	makeRectangle(0, 0, w*p, h);
	run("Copy");

	selectImage(imR);
	makeRectangle(0, 0, w*p, h);
	run("Paste");

	selectImage(im1);
	makeRectangle(w*(1-p), 0, w, h);
	run("Copy");

	selectImage(imR);
	makeRectangle(w*(1-p), 0, w, h);
	run("Paste");

	run("Add Slice");
}

// Pause 10
run("Delete Slice");
for (n=1; n<=10; n+=1) {
	selectImage(imR);
	run("Select None");
	run("Copy");
	run("Add Slice");
	run("Paste");
}

// All together now
x0 = w/2;
y0 = h/2;

// 2 panes
for (n=0; n<=720; n+=20) {
	
	frame = 15-minOf((n/720)*14, 14);
	selectImage(im0);
	setSlice(frame);
	selectImage(im1);
	setSlice(frame);

	selectImage(im0);
	run("Select None");
	run("Copy");

	selectImage(imR);
	run("Select None");
	run("Paste");
		
	if (n<90) p = (n/90);
	else if (n<180) p = ((n-90)/90);
	else if (n<270) p = ((n-180)/90);
	else if (n<360) p = ((n-270)/90);
	else if (n<450) p = ((n-360)/90);
	else if (n<540) p = ((n-450)/90);
	else if (n<630) p = ((n-540)/90);
	else p = ((n-630)/90);

	x01 = (1-p)*w/2;
	y01 = 0;
	x02 = 0;
	y02 = 0;
	x03 = 0;
	y03 = p*h/2+h/2;
		
	x11 = 0;
	y11 = p*h/2+h/2;
	x12 = 0;
	y12 = h;
	x13 = p*w/2+w/2;
	y13 = h;
		
	x21 = p*w/2+w/2;
	y21 = h;
	x22 = w;
	y22 = h;
	x23 = w;
	y23 = (1-p)*h/2;

	x31 = w;
	y31 = (1-p)*h/2;
	x32 = w;
	y32 = 0;
	x33 = (1-p)*w/2;
	y33 = 0;

	x41 = p*w/2;
	y41 = h;
	x42 = w;
	y42 = h;
	x43 = w;
	y43 = (1-p)*h/2+h/2;

	x51 = w;
	y51 = (1-p)*h/2+h/2;
	x52 = w;
	y52 = 0;
	x53 = (1-p)*w/2+w/2;
	y53 = 0;

	x61 = (1-p)*w/2+w/2;
	y61 = 0;
	x62 = 0;
	y62 = 0;
	x63 = 0;
	y63 = p*h/2;

	x71 = 0;
	y71 = p*h/2;
	x72 = 0;
	y72 = h;
	x73 = p*w/2;
	y73 = h;

	if (n<90) {
		//copy im2 bit
		selectImage(im1);
		makePolygon(x0,y0,x21,y21,x22,y22,x23,y23);
		run("Copy");
		selectImage(imR);
		run("Select None");
		makePolygon(x0,y0,x21,y21,x22,y22,x23,y23);
		run("Paste");

		//copy im3 bit
		selectImage(im1);
		makePolygon(x0,y0,x31,y31,x32,y32,x33,y33);
		run("Copy");
		selectImage(imR);
		run("Select None");
		makePolygon(x0,y0,x31,y31,x32,y32,x33,y33);
		run("Paste");
	}

	else if (n<180) {
		//copy im2 bit
		selectImage(im1);
		makePolygon(x0,y0,x51,y51,x52,y52,x53,y53);
		run("Copy");
		selectImage(imR);
		run("Select None");
		makePolygon(x0,y0,x51,y51,x52,y52,x53,y53);
		run("Paste");

		//copy im3 bit
		selectImage(im1);
		makePolygon(x0,y0,x61,y61,x62,y62,x63,y63);
		run("Copy");
		selectImage(imR);
		run("Select None");
		makePolygon(x0,y0,x61,y61,x62,y62,x63,y63);
		run("Paste");
	}

	else if (n<270) {
		//copy im2 bit
		selectImage(im1);
		makePolygon(x0,y0,x31,y31,x32,y32,x33,y33);
		run("Copy");
		selectImage(imR);
		run("Select None");
		makePolygon(x0,y0,x31,y31,x32,y32,x33,y33);
		run("Paste");

		//copy im3 bit
		selectImage(im1);
		makePolygon(x0,y0,x01,y01,x02,y02,x03,y03);
		run("Copy");
		selectImage(imR);
		run("Select None");
		makePolygon(x0,y0,x01,y01,x02,y02,x03,y03);
		run("Paste");
	}
	
	else if (n<360) {
		//copy im2 bit
		selectImage(im1);
		makePolygon(x0,y0,x61,y61,x62,y62,x63,y63);
		run("Copy");
		selectImage(imR);
		run("Select None");
		makePolygon(x0,y0,x61,y61,x62,y62,x63,y63);
		run("Paste");

		//copy im3 bit
		selectImage(im1);
		makePolygon(x0,y0,x71,y71,x72,y72,x73,y73);
		run("Copy");
		selectImage(imR);
		run("Select None");
		makePolygon(x0,y0,x71,y71,x72,y72,x73,y73);
		run("Paste");
	}

	else if (n<450) {		
		//copy im2 bit
		selectImage(im1);
		makePolygon(x0,y0,x01,y01,x02,y02,x03,y03);
		run("Copy");
		selectImage(imR);
		run("Select None");
		makePolygon(x0,y0,x01,y01,x02,y02,x03,y03);
		run("Paste");

		//copy im3 bit
		selectImage(im1);
		makePolygon(x0,y0,x11,y11,x12,y12,x13,y13);
		run("Copy");
		selectImage(imR);
		run("Select None");
		makePolygon(x0,y0,x11,y11,x12,y12,x13,y13);
		run("Paste");
	}

	else if (n<540) {
		//copy im2 bit
		selectImage(im1);
		makePolygon(x0,y0,x71,y71,x72,y72,x73,y73);
		run("Copy");
		selectImage(imR);
		run("Select None");
		makePolygon(x0,y0,x71,y71,x72,y72,x73,y73);
		run("Paste");
		
		//copy im3 bit
		selectImage(im1);
		makePolygon(x0,y0,x41,y41,x42,y42,x43,y43);
		run("Copy");
		selectImage(imR);
		run("Select None");
		makePolygon(x0,y0,x41,y41,x42,y42,x43,y43);
		run("Paste");
	}

	else if (n<630){
		//copy im2 bit
		selectImage(im1);
		makePolygon(x0,y0,x11,y11,x12,y12,x13,y13);
		run("Copy");
		selectImage(imR);
		run("Select None");
		makePolygon(x0,y0,x11,y11,x12,y12,x13,y13);
		run("Paste");

		//copy im3 bit
		selectImage(im1);
		makePolygon(x0,y0,x21,y21,x22,y22,x23,y23);
		run("Copy");
		selectImage(imR);
		run("Select None");
		makePolygon(x0,y0,x21,y21,x22,y22,x23,y23);
		run("Paste");
	}

	else {		
		//copy im2 bit
		selectImage(im1);
		makePolygon(x0,y0,x41,y41,x42,y42,x43,y43);
		run("Copy");
		selectImage(imR);
		run("Select None");
		makePolygon(x0,y0,x41,y41,x42,y42,x43,y43);
		run("Paste");


		//copy im3 bit
		selectImage(im1);
		makePolygon(x0,y0,x51,y51,x52,y52,x53,y53);
		run("Copy");
		selectImage(imR);
		run("Select None");
		makePolygon(x0,y0,x51,y51,x52,y52,x53,y53);
		run("Paste");
	}
	run("Add Slice");
}

// dSTORM run
run("Delete Slice");
for (n=1; n<=10; n+=1) {
	selectImage(imR);
	run("Select None");
	run("Copy");
	run("Add Slice");
	run("Paste");
}

///////////////////////
// Prepare title slides
///////////////////////

run("Scale Bar...", "width=5 height=16 font=50 color=White background=None location=[Lower Right] bold hide label");

setSlice(1);
run("Select All");
run("Multiply...", "value=0 slice");
xOffset = 100;
yOffset = 950;

setFont("SansSerif", 60, "bold");
drawString("Live-to-Fix Super-Resolution Imaging with NanoJ-Optofluidics", xOffset, yOffset);

setFont("SansSerif", 60, "italic");
drawString("Almada & Pereira et al., BioRXiv, 2018", xOffset, yOffset+100);

setFont("SansSerif", 60);
drawString("COS7 cells labelled with UtrCH-GFP (pre-fixation)", xOffset+100, yOffset+300);
drawString("and Phalloidin-AF647 (post-fixation)", xOffset+100, yOffset+400);

drawString("Live-Cell imaging by HILO and SRRF", xOffset+100, yOffset+550);
drawString("Fixed-Cell imaging by dSTORM", xOffset+100, yOffset+650);

run("Copy");
for (n=1; n<=20; n+=1) {
	run("Add Slice");
	run("Paste");
}

// WF to SRRF run
for (n=1; n<=30; n+=1) {
	slice = getSliceNumber();
	selectImage(imR);
	setSlice(1);
	run("Select None");
	run("Copy");

	setSlice(slice);
	run("Paste");

	selectImage(im0);
	setSlice(1);
	p = (n/30);
	makeRectangle(0, 0, w*p, h);
	run("Copy");

	selectImage(imR);
	makeRectangle(0, 0, w*p, h);
	run("Paste");

	run("Add Slice");
}

// Pause 10
run("Delete Slice");
for (n=1; n<=10; n+=1) {
	selectImage(imR);
	run("Select None");
	run("Copy");
	run("Add Slice");
	run("Paste");
}

setBatchMode(0);

selectImage(imR);
run("mpl-inferno");
//run("NanoJ-Orange");