// Zooming macro by Christophe Leterrier
// v1.0 10/05/2020
// Generate a stack of a progressive zoom into a rectangle ROI
// 1. Draw a rectangle ROI on an image
// 2. Launch the macro
// 3. Dialog: choose the zooming steps number (total number of images in output)
// 4. Dialog Option: linear or logarithmic zoom
// 5. Dialog Option: output stack of the original image with a moving zoom box, unscaled (can generate a large file), scale to the window width, or to the window height
// The zoom box is added as an ImageJ overlay (use Image>Overlay>Overlay Options to change color/thickness and Image>Overlay>Flatten to burn into image)
// The path and all zoom boxes are also added on the original image as an overlay (use Image>Overlay>Remove Overlay to remove)

macro "Zooming" {

	// Uncomment for testing
//	run("AuPbSn 40");
//	makeRectangle(379, 80, 68, 68);

	// steps number for the zooming animation (total number of images in output stack)
	step_def = 30;
	// type of zoom
	zoom_choice = newArray("linear", "geometric", "quadratic");
	zoom_def = "quadratic";
	// type of interpolation
	interp_choice = newArray("None", "Bilinear", "Bicubic");
	interp_def = "None";
	// add the original image as a stack with a moving zoom box?
	oriOut_def = true;
	// Sizing of this original image stack
	oriScale_choice = newArray("original", "output width", "output height");
	oriScale_def = "output height";

	// Get info on input image: ID, title, width, height, center, bit depth
	inID = getImageID();
	inTitle = getTitle();
	inW = getWidth();
	inH = getHeight();
	incenterX = inW /2;
	incenterY = inH /2;
	bd = bitDepth();
	if (bd != 24) inType = "" + bd + "-bit";
	else inType = "RGB";

	// Check if rectangle ROI destination
	ROIcheck = is("area");
	if (ROIcheck == false) exit("Macro needs a rectangle ROI");
	// ROItype = "no";
	// if (ROIcheck == true) ROItype = Roi.getType();
	// if (ROIcheck == false || ROItype != "rectangle") exit("Macro needs a rectangle ROI");

	// Get rectangle ROI cooordinates
	getSelectionBounds(destX, destY, destW, destH);
	// Add rectangle ROI to overlay
	run("Add Selection...");
	
	// Get center of rectangle ROI and add it to overlay
	destcenterX = destX + destW/2;
	destcenterY = destY + destH/2;
	makePoint(destcenterX, destcenterY, "medium add");
	
	// Calculate starting ROI: same ratio as destination ROI, centered on image

	// Determine the ratio to apply (from destination ROI width or height)
	ratioW = inW/destW;
	ratioH = inH/destH;
	ratio = minOf(ratioW, ratioH);

	// Calculate starting ROI coordinates
	startW = Math.round(destW * ratio);
	startH = Math.round(destH * ratio);
	startX = Math.round(incenterX - startW/2);
	startY = Math.round(incenterY - startH/2);
	startcenterX = startX + startW/2;
	startcenterY = startY + startH/2;

	// Draw the starting image as overlay
	makeRectangle(startX, startY, startW, startH);
	run("Add Selection...");
	makePoint(startcenterX, startcenterY, "medium add");

	// Dialog box
	Dialog.create("Zooming: options");
	Dialog.addMessage("Zoomed window is " + destW + "x" + destH + " pixels");
	Dialog.addMessage("Starting window is " + startW + "x" + startH + " pixels");
	Dialog.addNumber("Steps number", step_def, 0, 5, "images");
	Dialog.addChoice("Zooming type", zoom_choice, zoom_def);
	Dialog.addNumber("Output zoom width", destW, 0, 8, "pixels");
	Dialog.addChoice("Interpolation type", interp_choice, interp_def);
	Dialog.addCheckbox("Generate zoom box animation on original image", oriOut_def);
	Dialog.addChoice("Scale original image to", oriScale_choice, oriScale_def);
	Dialog.show();
	step = Dialog.getNumber();
	zoomtype = Dialog.getChoice();
	outW = Dialog.getNumber();
	outH = Math.round(startH * outW/startW);
	interp = Dialog.getChoice();
	oriOut = Dialog.getCheckbox();
	oriScale = Dialog.getChoice();

	setBatchMode(true);

	// Prepare output stack
	outTitle = inTitle + " zoom";
	outSlices = step;
	newImage(outTitle, inType + " black", outW, outH, outSlices);
	outID = getImageID();
	outTitle = getTitle();

	// Output original stack with ROIs if checked
	if (oriOut == true) {
		oriTitle = inTitle + " ori";

		// define output scale factor
		if (oriScale == "original") {
			scalefactor = 1;
		}
		else if (oriScale == "output width") {
			scalefactor = outW/inW;
		}
		else if (oriScale == "output height") {
			scalefactor = outH/inH;
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
		run("Size...", "width=" + oriW + " height=" + oriH + " depth=1 constrain average interpolation=Bicubic");

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


	i = 0;
	for (p = 0; p < step ; p++) {

		// progress bar
		showStatus("processing image " + (p+1) + "/"+ step);
		showProgress(p+1, step);

		// iterate slice for output stacks
		i++;

		// select source image
		selectImage(inID);

		// Calculate running rectangle coordinates
		// linear progression
		if (zoomtype == "linear") {
			// width and height of the running rectangle
			currW = startW - (p * (startW-destW)/(step-1));
			currH = startH - (p * (startH-destH)/(step-1));
			// center of the running rectangle
			currcenterX = startcenterX - (p * (startcenterX-destcenterX)/(step-1));
			currcenterY = startcenterY - (p * (startcenterY-destcenterY)/(step-1));
			// upper left corner of the running rectangle
			currX= currcenterX - currW/2;
			currY= currcenterY - currH/2;
		}
		// logarithmic progression
		else if  (zoomtype == "geometric") {
			t = p/(step-1); // t varies lineraly from 0 to 1
			s = t; // s is the easing function from 0 to 1
			currScaleW = 1 - ((1 - destW/startW)*s); // currScale varies from 1 to ratio
			currScaleX = 1 - ((1 - destcenterX/startcenterX)*s);
			currScaleY = 1 - ((1 - destcenterY/startcenterY)*s);
			
			// width and height of the running rectangle
			currW = startW * currScaleW;
			currH = startH * currScaleW;
			// center of the running rectangle
			currcenterX = startcenterX * currScaleX;
			currcenterY = startcenterY * currScaleY;
			// upper left corner of the running rectangle
			currX= currcenterX - currW/2;
			currY= currcenterY - currH/2;
		}
		
		else if  (zoomtype == "quadratic") {		
			t = p/(step-1); // t varies lineraly from 0 to 1
			s = 1 - ((1-t)*(1-t)); // s is the easing function from 0 to 1
			currScaleW = 1 - ((1 - destW/startW)*s); // currScale varies from 1 to ratio
			currScaleX = 1 - ((1 - destcenterX/startcenterX)*s);
			currScaleY = 1 - ((1 - destcenterY/startcenterY)*s);
			
			// width and height of the running rectangle
			currW = startW * currScaleW;
			currH = startH * currScaleW;
			// center of the running rectangle
			currcenterX = startcenterX * currScaleX;
			currcenterY = startcenterY * currScaleY;
			// upper left corner of the running rectangle
			currX= currcenterX - currW/2;
			currY= currcenterY - currH/2;
		}
	
		// Make window selection in input image, add it to overlay (but not on first frame)
		if (p > 0) {
			makeRectangle(currX, currY, currW, currH);
			run("Add Selection...");
		}

		// Transfer ROI to the overlay of the output original image stack
		if (oriOut == true) {
			selectImage(oriID);
			setSlice(i);

			// Coordinates of the window rectangle ROI on the scaled output stack
			oX = Math.round(currX * scalefactor);
			oY = Math.round(currY * scalefactor);
			oW = Math.round(currW * scalefactor);
			oH = Math.round(currH * scalefactor);

			// Add ROI to scaled output stack (but not on first frame)
			if (p > 0) {
				makeRectangle(oX, oY, oW, oH);
				run("Add Selection...");
			}
			run("Select None");
			selectImage(inID);
		}

		// Transfer window content to output stack
		
		// Duplicate current window and scale
		run("Duplicate...", "title=temp2");
		temp2ID = getImageID();
		temp2Title = getTitle();
		run("Size...", "width=" + outW + " height="+ outH + " depth=1 constrain average interpolation=" + interp);	
		// Copy/paste to output stack
		run("Copy");
		selectImage(outID);
		setSlice(i);	
		run("Paste");
		run("Select None");
		// Close temp duplicate
		selectImage(temp2ID);
		close();
		
	}


	setBatchMode("exit and display");

}
