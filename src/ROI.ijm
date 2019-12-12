//ImageJ macro making a movie (stack) of zooming on selected rectangle (ROI)
//v2 Eugene Katrukha katpyxa at gmail.com
//v2a Andrey Aristov: aaristov at pasteur.fr
requires("1.48h");

//check if there is rectangular selection

{
	sTitle=getTitle();
	sMovieTitle=sTitle+"_zoom_movie";
	setBatchMode(true);
	
	//ROI parameters
	//makeRectangle(1036, 128, 1136, 796);
	Roi.getBounds(nX, nY, nW, nH);
	//print(nX);
	//print(nY);
	//print(nW);
	//print(nH);
	
	//Dialog
	Dialog.create("Zoom-in parameters:");
	Dialog.addNumber("Zoom Step (0 to 1)",0.95);
	Dialog.addNumber("Add static number of frames in the end:", 5); 
	minMax=newArray("min","max");
	Dialog.addChoice("Zoom to min/max ROI size:", minMax); 
	sScaleChoice=newArray("Specified below","same as ROI");
	Dialog.addChoice("Final movie dimensions (px):", sScaleChoice); 
	Dialog.addNumber("Final movie width:", 512); 
	Dialog.addNumber("Final movie width:", 512); 
	Dialog.addCheckbox("Add scalebar:", false);
	Dialog.addNumber("Pixel size, um:", 0.04);
	 
	Dialog.show();
	zoomStep=Dialog.getNumber();
	nFramesLast=Dialog.getNumber();
	sChoice=Dialog.getChoice();
	sSizeChoice=Dialog.getChoice();
	nFinalW=Dialog.getNumber();
	nFinalH=Dialog.getNumber();
	addScaleBar = Dialog.getCheckbox();
	px=Dialog.getNumber();
	
	//print(nFinalW);
	//print(nFinalH);
	
	imageH=getHeight();
	imageW=getWidth();
	rawID=getImageID();


	nCenterX=nX+0.5*nW;
	//print("CenterX");
	//print(nCenterX);
	nCenterY=nY+0.5*nH;
	//print("CenterY");
	//print(nCenterY);

	nScaleX=nW/imageW;
	nScaleY=nH/imageH;
	
		
	//adjust roi x/y ratio to image x/y ratio
	//depending on user choice
	if(startsWith(sChoice, "min"))
		nScaleFin=minOf(nScaleX,nScaleY);
	else
		nScaleFin=maxOf(nScaleX,nScaleY);
	
	nW=nScaleFin*imageW;
	nH=nScaleFin*imageH;
	//print("New nW");
	//print(nW);
	//print("New nH");
	//print(nH);
	nX=nCenterX-(nW*0.5);
	nY=nCenterY-(nH*0.5);
	//print(nX);
	//print(nY);
	
	//distance from (0,0) to left top corner of selsction
	length=sqrt(nX*nX+nY*nY);
	//print("length");
	//print(length);
	if(nX==0)
		angle=3.14/2;
	else
		angle=atan(nY/nX);
	//print("angle");
	//print(angle);	

	//final movie size
	if(startsWith(sSizeChoice,"same as"))
	{
		nFinalW=nW;
		nFinalH=nH;
	}
	else
	{
		nMovieScaleX=nW/nFinalW;
		nMovieScaleY=nH/nFinalH;
		nMovieFinalScale = minOf(nMovieScaleX,nMovieScaleY);
		nFinalW=nW/nMovieFinalScale;
		nFinalH=nH/nMovieFinalScale;
	}
	//print(nFinalW);
	//print(nFinalH);
	
	
	
	bNotFirstIt=false;

	dCount =0;
	//for(nScale=1;nScale>=nScaleFin;nScale=nScale-nScaleStep)
	nScale=1;

	newW=imageW;
	newH=imageH;
	dLen = length;
	ddLen = 0;
	run("Set Scale...", "distance=1 known="+px+" pixel=1 unit=um");
	//run("32-bit");
	
	while(newW>nW){
	//for(dCount =0;dCount<=nFrames;dCount++)
	//{		
		selectImage(rawID);	
		//change viewport position/scale	
		//print("dlen");
		//print(dLen);

		offsetX=ddLen*cos(angle);
		offsetY=ddLen*sin(angle);
		
		run("Specify...", "width="+toString(newW)+" height="+toString(newH)+" x="+toString(offsetX)+" y="+toString(offsetY));
		run("Duplicate...", "title="+sTitle+toString(nScale));
		unscaledID=getImageID();
		run("Scale...", "x=- y=- width="+toString(nFinalW)+" height="+toString(nFinalH)+" interpolation=Bicubic average create");
		scaledID=getImageID();
		selectImage(unscaledID);
		close();
		selectImage(scaledID);

		//run("Enhance Contrast...", "saturated=0.3");
		
		if(addScaleBar){
			trueSize = newW*px;//um
		
			w = floor(trueSize/2);
			if(w>300){
				width = 300;
			}
			else if(w>100){
				width = 100;
			}
			else if(w>30){
				width = 30;
			}
			else if(w>10){
				width = 10;
			}
			else if(w>3){
				width = 3;
			}
			else {
				width = 1;
			}
		
		
			run("Scale Bar...", "width="+width+"  height=8 font=24 color=White background=None location=[Lower Right] bold");
	
		}
		
		//not a first frame, let's add to existing movie stack
		if(bNotFirstIt)
		{
			sCurrTitle=sTitle+"x"+toString(nScale);
			rename(sCurrTitle);
			run("Concatenate...", "  title=["+sMovieTitle+"] image1=["+sMovieTitle+"] image2=["+sCurrTitle+"]");
		}
		//first frame, let's make accumulating stack out of it
		else
		{
			rename(sMovieTitle);
			sMovieID=getImageID();
			bNotFirstIt=true;
		}
		//nScale=nScale-nScaleStep;
		//nScale=nScaleFin+(1-nScaleFin)/2/(dCount+1);
		
		dLen=dLen*zoomStep;
		ddLen = length-dLen+length*nScaleFin;

		
		newW=newW*zoomStep;
		newH=newH*zoomStep;
		
	}

	//adding static frames part
	nScale=nScaleFin;
	for(nAddFrames=1;nAddFrames<=nFramesLast;nAddFrames++)
	{
		selectImage(rawID);	
		//offsetX=length*cos(angle);
		//offsetY=length*sin(angle);
		//newW=imageW*nScale;
		//newH=imageH*nScale;
		run("Specify...", "width="+toString(newW/zoomStep)+" height="+toString(newH/zoomStep)+" x="+toString(offsetX)+" y="+toString(offsetY));
		run("Duplicate...", "title="+sTitle+toString(nScale));
		unscaledID=getImageID();
		run("Scale...", "x=- y=- width="+toString(nFinalW)+" height="+toString(nFinalH)+" interpolation=Bilinear average create");
		scaledID=getImageID();
		selectImage(unscaledID);
		close();
		selectImage(scaledID);
		
		//run("Enhance Contrast...", "saturated=0.3");
		
		if(addScaleBar){
			run("Scale Bar...", "width="+width+" height=8 font=24 color=White background=None location=[Lower Right] bold");
		}
		sCurrTitle=sTitle+"x"+toString(nScale);
		rename(sCurrTitle);
		run("Concatenate...", "  title=["+sMovieTitle+"] image1=["+sMovieTitle+"] image2=["+sCurrTitle+"]");
			
	}
	setBatchMode(false);
}
//no rectangular ROI selection, error