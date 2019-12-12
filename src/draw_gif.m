function draw_gif(display,filename,mag)
if nargin < 3 || isempty(mag)
    mag=4;
end
dim=ndims(display);
if dim ==4
    d=size(display,4);
    for i=1:d
        figure(i)
        imshow(display(:,:,:,i),'border','tight','initialmagnification','fit')
        set (gcf,'Position',[0,0,mag*size(display(:,:,i),2),mag*size(display(:,:,i),1)])
        axis normal
        frame=getframe(i);
        im=frame2im(frame);%make gif
        [I,map]=rgb2ind(im,256);
        k=i-0;
        if k==1
            imwrite(I,map,filename,'gif','Loopcount',inf,'DelayTime',0.1);
        elseif k<=261
            imwrite(I,map,filename,'gif','WriteMode','append','DelayTime',0.1);
        elseif k>261&&k<=300
            imwrite(I,map,filename,'gif','WriteMode','append','DelayTime',0.1);
         elseif k>300&&k<=308
            imwrite(I,map,filename,'gif','WriteMode','append','DelayTime',0.2);
        else
            imwrite(I,map,filename,'gif','WriteMode','append','DelayTime',0.05);
        end
        close all
    end
elseif dim==3
    c=size(display,3);
    display=double(display)./max(display(:));
    for i=1:c
        figure(i)
        imshow(display(:,:,i),'border','tight','initialmagnification','fit')
        set (gcf,'Position',[0,0,mag*size(display(:,:,i),2),mag*size(display(:,:,i),1)])
        axis normal
        frame=getframe(i);
        im=frame2im(frame);%make gif
        [I,map]=rgb2ind(im,256);
        k=i-0;
        if k==1
            imwrite(I,map,filename,'gif','Loopcount',inf,'DelayTime',0.8);
        elseif k==2||k==c
            imwrite(I,map,filename,'gif','WriteMode','append','DelayTime',0.8);
        elseif k==3||k==4||k==5||k==6
            imwrite(I,map,filename,'gif','WriteMode','append','DelayTime',0.1);
        else
            imwrite(I,map,filename,'gif','WriteMode','append','DelayTime',0.03);
        end
    end
else
    fprintf('Matrix dimension error should in 3-4 from draw_gif !\n');
end
close all