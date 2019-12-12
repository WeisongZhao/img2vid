function draw_avi(display,filename,mag,Quality)
if nargin < 3 || isempty(mag)
    mag=1;
end
if nargin < 4 || isempty(Quality)
    Quality=100;
end
vid = VideoWriter(filename,'MPEG-4');
% vid = VideoWriter(filename,'Uncompressed AVI');
vid.Quality = Quality;
vid.FrameRate=30;
open(vid)

for i = 1 : 141
    for loop2=1:2
        imshow(display(:,:,:,i),'border','tight','initialmagnification','fit')
        set (gcf,'Position',[0,0,mag*size(display(:,:,i),2),mag*size(display(:,:,i),1)])
        axis normal
        drawnow;
        c = getframe;
        writeVideo(vid, c);
    end
end

for i = 141 : 141
    for loop2=1:60
        imshow(display(:,:,:,i),'border','tight','initialmagnification','fit')
        set (gcf,'Position',[0,0,mag*size(display(:,:,i),2),mag*size(display(:,:,i),1)])
        axis normal
        drawnow;
        c = getframe;
        writeVideo(vid, c);
    end
end

for i = 142: 349
    for loop2=1:2
        imshow(display(:,:,:,i),'border','tight','initialmagnification','fit')
        set (gcf,'Position',[0,0,mag*size(display(:,:,i),2),mag*size(display(:,:,i),1)])
        axis normal
        drawnow;
        c = getframe;
        writeVideo(vid, c);
    end
end

for i = 350 : 350
    for loop2=1:60
        imshow(display(:,:,:,i),'border','tight','initialmagnification','fit')
        set (gcf,'Position',[0,0,mag*size(display(:,:,i),2),mag*size(display(:,:,i),1)])
        axis normal
        drawnow;
        c = getframe;
        writeVideo(vid, c);
    end
end

for i = 351 : 360
    for loop=1:2
        imshow(display(:,:,:,i),'border','tight','initialmagnification','fit')
        set (gcf,'Position',[0,0,mag*size(display(:,:,i),2),mag*size(display(:,:,i),1)])
        axis normal
        drawnow;
        c = getframe;
        writeVideo(vid, c);
    end
end

for i =361:363
    for loop=1:60
        imshow(display(:,:,:,i),'border','tight','initialmagnification','fit')
        set (gcf,'Position',[0,0,mag*size(display(:,:,i),2),mag*size(display(:,:,i),1)])
        axis normal
        drawnow;
        c = getframe;
        writeVideo(vid, c);
    end
end

for i = 364:442
    for loop=1:2
        imshow(display(:,:,:,i),'border','tight','initialmagnification','fit')
        set (gcf,'Position',[0,0,mag*size(display(:,:,i),2),mag*size(display(:,:,i),1)])
        axis normal
        drawnow;
        c = getframe;
        writeVideo(vid, c);
    end
end

for i = 443:445
    for loop=1:50
        imshow(display(:,:,:,i),'border','tight','initialmagnification','fit')
        set (gcf,'Position',[0,0,mag*size(display(:,:,i),2),mag*size(display(:,:,i),1)])
        axis normal
        drawnow;
        c = getframe;
        writeVideo(vid, c);
    end
end

for i = 446:509
    for loop=1:2
        imshow(display(:,:,:,i),'border','tight','initialmagnification','fit')
        set (gcf,'Position',[0,0,mag*size(display(:,:,i),2),mag*size(display(:,:,i),1)])
        axis normal
        drawnow;
        c = getframe;
        writeVideo(vid, c);
    end
end

for i = 510:514
    for loop=1:60
        imshow(display(:,:,:,i),'border','tight','initialmagnification','fit')
        set (gcf,'Position',[0,0,mag*size(display(:,:,i),2),mag*size(display(:,:,i),1)])
        axis normal
        drawnow;
        c = getframe;
        writeVideo(vid, c);
    end
end

for i = 514:541
    for loop=1:2
        imshow(display(:,:,:,i),'border','tight','initialmagnification','fit')
        set (gcf,'Position',[0,0,mag*size(display(:,:,i),2),mag*size(display(:,:,i),1)])
        axis normal
        drawnow;
        c = getframe;
        writeVideo(vid, c);
    end
end

for i = 542:550
    for loop=1:20
        imshow(display(:,:,:,i),'border','tight','initialmagnification','fit')
        set (gcf,'Position',[0,0,mag*size(display(:,:,i),2),mag*size(display(:,:,i),1)])
        axis normal
        drawnow;
        c = getframe;
        writeVideo(vid, c);
    end
end

for i = 551:571
    for loop=1:2
        imshow(display(:,:,:,i),'border','tight','initialmagnification','fit')
        set (gcf,'Position',[0,0,mag*size(display(:,:,i),2),mag*size(display(:,:,i),1)])
        axis normal
        drawnow;
        c = getframe;
        writeVideo(vid, c);
    end
end
for i = 572:640
    for loop=1:2
        imshow(display(:,:,:,i),'border','tight','initialmagnification','fit')
        set (gcf,'Position',[0,0,mag*size(display(:,:,i),2),mag*size(display(:,:,i),1)])
        axis normal
        drawnow;
        c = getframe;
        writeVideo(vid, c);
    end
end

for i = 640:642
    for loop=1:20
        imshow(display(:,:,:,i),'border','tight','initialmagnification','fit')
        set (gcf,'Position',[0,0,mag*size(display(:,:,i),2),mag*size(display(:,:,i),1)])
        axis normal
        drawnow;
        c = getframe;
        writeVideo(vid, c);
    end
end

for i = 643:665
    for loop=1:2
        imshow(display(:,:,:,i),'border','tight','initialmagnification','fit')
        set (gcf,'Position',[0,0,mag*size(display(:,:,i),2),mag*size(display(:,:,i),1)])
        axis normal
        drawnow;
        c = getframe;
        writeVideo(vid, c);
    end
end

for i = 666
    for loop=1:60
        imshow(display(:,:,:,i),'border','tight','initialmagnification','fit')
        set (gcf,'Position',[0,0,mag*size(display(:,:,i),2),mag*size(display(:,:,i),1)])
        axis normal
        drawnow;
        c = getframe;
        writeVideo(vid, c);
    end
end
close(vid)
