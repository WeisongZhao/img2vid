// Panning macro by Christophe Leterrier
// v1.0 09/05/2020
// Generate a stack of a zoomed window along a polyline ROI
// 1. Draw a polyline ROI on an image
// 2. Launch the macro
// 3. Dialog: Specify the width and height of the zoom window, as well as the number of steps for the progression along the path (in pixels)
// 4. Dialog Option: smoothing of the path (spline fit)
// 5. Dialog Option: choose linear or quadratic panning
// 6. Dialog Option: output stack of the original image with a moving zoom box, unscaled (can generate a large file), scale to the window width, or to the window height
// The zoom box is added as an ImageJ overlay (use Image>Overlay>Overlay Options to change color/thickness and Image>Overlay>Flatten to burn into image)
// The path and all zoom boxes are also added on the original image as an overlay (use Image>Overlay>Remove Overlay to remove)

run("ROI Manager...");
macro "Panning" {

	// Uncomment for testing
	// run("AuPbSn 40");
	// makeLine(462,66,439,194,237,103,138,229,56,130);

	// window width and height
	rw_def = 100;
	rh_def = 100;
	// step of the panning (total number of images)
	nsteps_def = 100;
	// smooth the line ROI?
	spline_def = true;
	// panning type by default: quadratic
	pType_choice = newArray("linear", "quadratic");
	pType_def = "quadratic"
	// add the original image as a stack with a moving zoom box?
	oriOut_def = true;
	// Sizing of this original image stack
	oriScale_choice = newArray("original", "window width", "window height");
	oriScale_def = "window height";

	// Get info on input image
	inID = getImageID();
	inTitle = getTitle();
	inW = getWidth();
	inH = getHeight();
	bd = bitDepth();
	if (bd != 24) inType = ""+ bd + "-bit";
	else inType = "RGB";

	// Dialog box
	Dialog.create("Panning: options");
	Dialog.addNumber("Zoom window width", rw_def, 0, 5, "pixels");
	Dialog.addNumber("Zoom window height", rh_def, 0, 5, "pixels");
	Dialog.addNumber("Number of panning steps along path", nsteps_def, 0, 5,"steps");
	Dialog.addCheckbox("Smooth path", spline_def);
	Dialog.addChoice("Panning Type", pType_choice, pType_def);
	Dialog.addCheckbox("Generate zoom box animation on original image", oriOut_def);
	Dialog.addChoice("Scale original image to", oriScale_choice, oriScale_def);
	Dialog.show();
	rw = Dialog.getNumber();
	rh = Dialog.getNumber();
	nsteps = Dialog.getNumber();
	spline = Dialog.getCheckbox();
	pType = Dialog.getChoice();
	oriOut = Dialog.getCheckbox();
	oriScale = Dialog.getChoice();

	setBatchMode(true);

	// Check line ROI
	ROIcheck = is("line");
	if(ROIcheck == false) exit("Macro needs a line ROI");
	if (spline == true) run("Fit Spline");

	// Add line ROI to overlay
	run("Add Selection...");

	// get pixel-spaced coordinates
	// Roi.getCoordinates(linex, liney);
	Roi.getContainedPoints(xpoints, ypoints);
	// Array.show(linex);
	// Array.show(xpoints);
	coorLength = xpoints.length;

	// Prepare output stack
	outTitle = inTitle + " box";
	outSlices = nsteps;
	newImage(outTitle, inType + " black", rw, rh, outSlices);
	outID = getImageID();
	outTitle = getTitle();

	// Output original stack with ROIs if checked
	if (oriOut == true) {
		oriTitle = inTitle + " ori";

		// define output scale factor
		if (oriScale == "original") {
			scalefactor = 1;
		}
		else if (oriScale == "window width") {
			scalefactor = rw/inW;
		}
		else if (oriScale == "window height") {
			scalefactor = rh/inH;
		}

		// Size of the output stack
		oriW = Math.round(inW * scalefactor);
		oriH = Math.round(inH * scalefactor);

		// Creation of the output stack
		newImage(oriTitle, inType + " black", oriW, oriH, outSlices);
		oriID = getImageID();
		oriTitle = getTitle();

		// Create copy of input image sized at the output
		selectImage(inID);
		run("Duplicate...", "title=temp");
		tempID = getImageID();
		tempTitle = getTitle();
		run("Size...", "width=" + oriW + " height=" + oriH + " depth=1 constrain average");

		// Copy scaled original image on all slices of the output original stack
		for (s = 0; s < outSlices; s++) {
			selectImage(tempID);
			run("Select All");
			run("Copy");
			selectImage(oriID);
			setSlice(s+1);
			run("Paste");
		}
		selectImage(tempID);
		close();
	}
	
	for (p = 0; p < nsteps; p++) {

		// select source image
		selectImage(inID);

		// linear variable from 0 to 1
		x = p/(nsteps-1);

		// output easing variable from 0 to 1
		// linear case
		if (pType == "linear") {
			f = x);
		}
		// quadratic case see https://easings.net/#easeInOutQuad
		if (pType == "quadratic") {
			if (x < 0.5) f = 2 * x * x;
			else f = 1 - ((-2*x+2)*(-2*x+2))/2;
		}

		// index along coordinates arrays picked at the easing variable step
		i = floor(coorLength * f);
		// egde case at the end of tracing
		if (i == coorLength) i = coorLength-1;
			
		// coordinates of the window rectangle ROI upper corner
		wx = xpoints[i] - rw/2;
		wy = ypoints[i] - rh/2;

		// Make window selection in input image, add it to overlay
		makeRectangle(wx, wy, rw, rh);
		 run("Add Selection...");

		// transfer ROI to the overlay of the output original image stack
		if (oriOut == true) {
			selectImage(oriID);
			setSlice(p+1);

			// coordinates of the window rectangle ROI on the scaled output stack
			ox = Math.round(wx * scalefactor);
			oy = Math.round(wy * scalefactor);
			ow = Math.round(rw * scalefactor);
			oh = Math.round(rh * scalefactor);

			// add ROI to scaled output stack
			makeRectangle(ox, oy, ow, oh);
			roiManager("Add");
			run("Add Selection...");
			run("Select None");
			selectImage(inID);
		}

		// transfer window content to output stack
		run("Copy");
		selectImage(outID);
		setSlice(p+1);
		run("Paste");
		run("Select None");
	}


	setBatchMode("exit and display");

}
