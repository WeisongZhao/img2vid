clc;clear;close all;
%%

% SHMito=imreadTiff('c13_SR_w1L-561_t1_AM.tif');
% SHMito=edging(SHMito,3);
% % SHMito=scalebar(SHMito,950,953,750,855);
% 
% SIMMito=imreadTiff('CSIMsCMOSTOM203Dc13t1.tif');
% SIMMito=edging(SIMMito,3);
% % SIMMito=scalebar(SIMMito,950,953,750,855);
% 
% 
% large=zeros(975+130,1042*2+200,3);
% jet=double(imread('16_colors.tif'));
% Mito=3*SHMito;
% Mito=edging(Mito,3);
% % Mito=scalebar(Mito,950,953,750,855);
% % Tubulin=scalebar(Tubulin,950,953,750,855);
% Mito2=2*SIMMito;
% Mito2=edging(Mito2,3);
% 
% Mito=colorm(Mito,jet);
% Mito2=colorm(Mito2,jet);
% flage=0;
% for i=141:-1:1
%     large=zeros(975+130,1042*2+200,3);
%     flage=flage+1;
%     mid=sum(Mito(:,:,:,i:140),4);
%     mid=mid./max(mid(:));
%     mid=edging(mid,3);
%     mid=scalebar(mid,900,903,850,955);
%     large(81:80+975,71:70+1042,:)=mid;
%     mid=sum(Mito2(:,:,:,i:140),4);
%     mid=10*mid./max(mid(:));
%     mid=edging(mid,3);
%     mid=scalebar(mid,900,903,850,955);
%     large(81:80+975,141+1042:140+1042*2,:)=mid;
%     large(651:650+size(ceil(i*256/120):256,2),131:162,1)=jet(:,256:-1:ceil(i*256/120),1)'/255;
%     large(651:650+size(ceil(i*256/120):256,2),131:162,2)=jet(:,256:-1:ceil(i*256/120),2)'/255;
%     large(651:650+size(ceil(i*256/120):256,2),131:162,3)=jet(:,256:-1:ceil(i*256/120),3)'/255;
%     imwrite(large,['stage1\',int2str(flage),'.tif']);
% end
% 
% for i=975-141:-4:1
%     large=zeros(975+130,1042*2+200,3);
%     
%     flage=flage+1;
%     mid=sum(Mito(:,:,:,1:140),4);
%     mid=mid./max(mid(:));
%     mid=edging(mid,3);
%     mid=scalebar(mid,900,903,850,955);
%     large(81:80+975,71:70+1042,:)=mid;
%     
%     midz=squeeze(Mito(i,:,:,:));
%     midz=permute(midz,[3 1 2]);
%     midz=2*midz./max(midz(:));
%     midz=edging(midz,3);
%     large(80+i:80+i+140,71:70+1042,:)=midz;
%  
%     mid=sum(Mito2(:,:,:,1:140),4);
%     mid=10*mid./max(mid(:));
%     mid=edging(mid,3);
%     mid=scalebar(mid,900,903,850,955);
%     large(81:80+975,141+1042:140+1042*2,:)=mid;
%     
%     midz=squeeze(Mito2(i,:,:,:));
%     midz=permute(midz,[3 1 2]);
%     midz=5*midz./max(midz(:));
%     midz=edging(midz,3);
%     large(80+i:80+i+140,141+1042:140+1042*2,:)=midz;
%     
%     imwrite(large,['stage1\',int2str(flage),'.tif']);
% end
% 
% 
% for i=1:318
%     large=zeros(975+130,1042*2+200,3);
%     flage=flage+1;
%     mid=double(imread(['C:\Users\Administrator\Desktop\video\Video.6\image',num2str(i-1),'.png']))/255;
%     mid=imresize(mid,[975,1100]);
%     mid=edging(mid,3);
%     large(81:80+975,601:600+1100,:)=mid;
%     imwrite(large,['stage1\',int2str(flage),'.tif']);
% end

%%
flage=0;
for i=1:22
    figure(1)
    flage=flage+1;
    large=imread(['stage1\',int2str(i),'.tif']);
    imshow(large,'border','tight','initialmagnification','fit')
    set (gcf,'Position',[0,0,1*size(large,2),1*size(large,1)])

    text1=text(920,40,['\it{Z axial position 0 ~ }',num2str(roundn((i-1)*(0.05),-2)),' (\mu\it{m})']);
    set(text1,'Color',[1,1, 0],'Fontsize',20,'Fontname','Arial')

    text1=text(500,45,['SD-SIM']);
    set(text1,'Color',[1,1,0.99],'Fontsize',20,'Fontname','Arial')
    
    text1=text(2045,955,['4 ¦Ìm']);
    set(text1,'Color',[1,1,0.99],'Fontsize',18,'Fontname','Arial')
    
    text1=text(1580,45,['Sparse SD-SIM']);
    set(text1,'Color',[1,1,0.99],'Fontsize',20,'Fontname','Arial')
    
    export_fig(gcf,['stage2\',int2str(flage),'total.png'])
end

for i=23:140
    figure(1)
    flage=flage+1;
    large=imread(['stage1\',int2str(i),'.tif']);
    imshow(large,'border','tight','initialmagnification','fit')
    set (gcf,'Position',[0,0,1*size(large,2),1*size(large,1)])

    text1=text(920,40,['\it{Z axial position 0 ~ }',num2str(roundn((i-1)*(0.05),-2)),' (\mu\it{m})']);
    set(text1,'Color',[1,1, 0],'Fontsize',20,'Fontname','Arial')

    text1=text(500,45,['SD-SIM']);
    set(text1,'Color',[1,1,0.99],'Fontsize',20,'Fontname','Arial')
    
    
    text1=text(1580,45,['Sparse SD-SIM']);
    set(text1,'Color',[1,1,0.99],'Fontsize',20,'Fontname','Arial')
    
    text1=text(2045,955,['4 ¦Ìm']);
    set(text1,'Color',[1,1,0.99],'Fontsize',18,'Fontname','Arial')

    text1=text(170,660,['\it',num2str(roundn((0)*(0.05),-2)),' (\mu\it{m})']);
    
    set(text1,'Color',[1,1, 0],'Fontsize',20,'Fontname','Arial')
    export_fig(gcf,['stage2\',int2str(flage),'total.png'])
end

for i=141
    figure(1)
    flage=flage+1;
    large=imread(['stage1\',int2str(i),'.tif']);
    imshow(large,'border','tight','initialmagnification','fit')
    set (gcf,'Position',[0,0,1*size(large,2),1*size(large,1)])

    text1=text(920,40,['\it{Z axial position 0 ~ }',num2str(roundn((i-1)*(0.05),-2)),' (\mu\it{m})']);
    set(text1,'Color',[1,1, 0],'Fontsize',20,'Fontname','Arial')

    text1=text(500,45,['SD-SIM']);
    set(text1,'Color',[1,1,0.99],'Fontsize',20,'Fontname','Arial')
    
     text1=text(2045,955,['4 ¦Ìm']);
    set(text1,'Color',[1,1,0.99],'Fontsize',18,'Fontname','Arial')
    
    text1=text(1580,45,['Sparse SD-SIM']);
    set(text1,'Color',[1,1,0.99],'Fontsize',20,'Fontname','Arial')
    text1=text(170,660,['\it',num2str(roundn((0)*(0.05),-2)),' (\mu\it{m})']);
    set(text1,'Color',[1,1, 0],'Fontsize',20,'Fontname','Arial')
    text1=text(170,890,['\it',num2str(roundn((141)*(0.05),-2)),' (\mu\it{m})']);
    set(text1,'Color',[1,1, 0],'Fontsize',20,'Fontname','Arial')
    export_fig(gcf,['stage2\',int2str(flage),'total.png'])
end


for i=142:349
    figure(1)
    flage=flage+1;
    large=imread(['stage1\',int2str(i),'.tif']);
    imshow(large,'border','tight','initialmagnification','fit')
    set (gcf,'Position',[0,0,1*size(large,2),1*size(large,1)])

    text1=text(920,40,['\it{Z axial position 0 ~ }',num2str(roundn((140)*(0.05),-2)),' (\mu\it{m})']);
    set(text1,'Color',[1,1, 0],'Fontsize',20,'Fontname','Arial')

    text1=text(500,45,['SD-SIM']);
    set(text1,'Color',[1,1,0.99],'Fontsize',20,'Fontname','Arial')
    
    text1=text(1580,45,['Sparse SD-SIM']);
    set(text1,'Color',[1,1,0.99],'Fontsize',20,'Fontname','Arial')
    
    text1=text(1284,1005-(i-142)*4,['\it{y}']);
    set(text1,'Color',[1,1,0.99],'Fontsize',18,'Fontname','Arial')
    
    text1=text(1224,951-(i-142)*4,['\it{z}']);
    set(text1,'Color',[1,1,0.99],'Fontsize',18,'Fontname','Arial')
    
    annotation(gcf,'arrow',[0.53 0.53],...
    [0.097+(0.0034)*(i-142) 0.17+(0.0034)*(i-142)],'Color',[1 1 1],'LineWidth',2);

    annotation(gcf,'arrow',[0.53 0.58],...
    [0.096+(0.0034)*(i-142), 0.096+(0.0034)*(i-142)],'Color',[1 1 1],'LineWidth',2);
    
    export_fig(gcf,['stage2\',int2str(flage),'total.png'])
end

for i=351:351
    figure(1)
    flage=flage+1;
    large=imread(['stage1\',int2str(i),'.tif']);
    imshow(large,'border','tight','initialmagnification','fit')
    set (gcf,'Position',[0,0,1*size(large,2),1*size(large,1)])
    
    text1=text(230,505,['SD-SIM']);
    set(text1,'Color',[1,0,0],'Fontsize',25,'Fontname','Arial')
    
    text1=text(280,545,['+']);
    set(text1,'Color',[1,1,1],'Fontsize',25,'Fontname','Arial')
    
    text1=text(170,585,['Sparse SD-SIM']);
    set(text1,'Color',[0,1,0],'Fontsize',25,'Fontname','Arial')
    
    annotation(gcf,'arrow',[0.63981288981289 0.652806652806654],...
        [0.762425447316103 0.835984095427432],'Color',[1 1 1],'LineWidth',3);
    annotation(gcf,'arrow',[0.295218295218295 0.74012474012474],...
        [0.0795228628230616 0.123260437375745],'Color',[1 1 1],'LineWidth',3);
    annotation(gcf,'arrow',[0.297297297297297 0.322245322245322],...
        [0.0824990059642147 0.809145129224652],'Color',[1 1 1],'LineWidth',3);
    
    text1=text(610,565,['40 \mu\it{m}']);
    set(text1,'Color',[1,1,0],'Fontsize',20,'Fontname','Arial')
    
    text1=text(1490,1030,['40 \mu\it{m}']);
    set(text1,'Color',[1,1,0],'Fontsize',20,'Fontname','Arial')
    
        
    text1=text(1510,130,['7 \mu\it{m}']);
    set(text1,'Color',[1,1,0],'Fontsize',20,'Fontname','Arial')
    
    export_fig(gcf,['stage2\',int2str(flage),'total.png'])
end


for i=351:360
    figure(1)
    flage=flage+1;
    large=imread(['stage1\',int2str(i),'.tif']);
    imshow(large,'border','tight','initialmagnification','fit')
    set (gcf,'Position',[0,0,1*size(large,2),1*size(large,1)])
    
    text1=text(230,505,['SD-SIM']);
    set(text1,'Color',[1,0,0],'Fontsize',25,'Fontname','Arial')
    
    text1=text(280,545,['+']);
    set(text1,'Color',[1,1,1],'Fontsize',25,'Fontname','Arial')
  
    text1=text(170,585,['Sparse SD-SIM']);
    set(text1,'Color',[0,1,0],'Fontsize',25,'Fontname','Arial')
    export_fig(gcf,['stage2\',int2str(flage),'total.png'])
end


for i=361:362
    figure(1)
    flage=flage+1;
    large=imread(['stage1\',int2str(i),'.tif']);
    imshow(large,'border','tight','initialmagnification','fit')
    set (gcf,'Position',[0,0,1*size(large,2),1*size(large,1)])
    
%     text1=text(230,505,['SD-SIM']);
%     set(text1,'Color',[1,0,0],'Fontsize',25,'Fontname','Arial')
%     
%     text1=text(280,545,['+']);
%     set(text1,'Color',[1,1,1],'Fontsize',25,'Fontname','Arial')
  
    text1=text(170,585,['Sparse SD-SIM']);
    set(text1,'Color',[0,1,0],'Fontsize',25,'Fontname','Arial')
    export_fig(gcf,['stage2\',int2str(flage),'total.png'])
end
for i=364:365
    figure(1)
    flage=flage+1;
    large=imread(['stage1\',int2str(i),'.tif']);
    imshow(large,'border','tight','initialmagnification','fit')
    set (gcf,'Position',[0,0,1*size(large,2),1*size(large,1)])
    
    text1=text(230,505,['SD-SIM']);
    set(text1,'Color',[1,0,0],'Fontsize',25,'Fontname','Arial')
%     
%     text1=text(280,545,['+']);
%     set(text1,'Color',[1,1,1],'Fontsize',25,'Fontname','Arial')
  
%     text1=text(170,585,['Sparse SD-SIM']);
%     set(text1,'Color',[0,1,0],'Fontsize',25,'Fontname','Arial')
    export_fig(gcf,['stage2\',int2str(flage),'total.png'])
end

for i=366:443
    figure(1)
    flage=flage+1;
    large=imread(['stage1\',int2str(i),'.tif']);
    imshow(large,'border','tight','initialmagnification','fit')
    set (gcf,'Position',[0,0,1*size(large,2),1*size(large,1)])
    
    text1=text(230,505,['SD-SIM']);
    set(text1,'Color',[1,0,0],'Fontsize',25,'Fontname','Arial')
%     
    text1=text(280,545,['+']);
    set(text1,'Color',[1,1,1],'Fontsize',25,'Fontname','Arial')
  
    text1=text(170,585,['Sparse SD-SIM']);
    set(text1,'Color',[0,1,0],'Fontsize',25,'Fontname','Arial')
    export_fig(gcf,['stage2\',int2str(flage),'total.png'])
end

for i=444:445
    figure(1)
    flage=flage+1;
    large=imread(['stage1\',int2str(i),'.tif']);
    imshow(large,'border','tight','initialmagnification','fit')
    set (gcf,'Position',[0,0,1*size(large,2),1*size(large,1)])
%     
%     text1=text(230,505,['SD-SIM']);
%     set(text1,'Color',[1,0,0],'Fontsize',25,'Fontname','Arial')
% %     
%     text1=text(280,545,['+']);
%     set(text1,'Color',[1,1,1],'Fontsize',25,'Fontname','Arial')
%   
    text1=text(170,585,['Sparse SD-SIM']);
    set(text1,'Color',[0,1,0],'Fontsize',25,'Fontname','Arial')
    export_fig(gcf,['stage2\',int2str(flage),'total.png'])
end

for i=447:447
    figure(1)
    flage=flage+1;
    large=imread(['stage1\',int2str(i),'.tif']);
    imshow(large,'border','tight','initialmagnification','fit')
    set (gcf,'Position',[0,0,1*size(large,2),1*size(large,1)])
    
    text1=text(230,505,['SD-SIM']);
    set(text1,'Color',[1,0,0],'Fontsize',25,'Fontname','Arial')
%     
%     text1=text(280,545,['+']);
%     set(text1,'Color',[1,1,1],'Fontsize',25,'Fontname','Arial')
  
%     text1=text(170,585,['Sparse SD-SIM']);
%     set(text1,'Color',[0,1,0],'Fontsize',25,'Fontname','Arial')
    export_fig(gcf,['stage2\',int2str(flage),'total.png'])
end
for i=448:514
    figure(1)
    flage=flage+1;
    large=imread(['stage1\',int2str(i),'.tif']);
    imshow(large,'border','tight','initialmagnification','fit')
    set (gcf,'Position',[0,0,1*size(large,2),1*size(large,1)])
    
    text1=text(230,505,['SD-SIM']);
    set(text1,'Color',[1,0,0],'Fontsize',25,'Fontname','Arial')
%     
    text1=text(280,545,['+']);
    set(text1,'Color',[1,1,1],'Fontsize',25,'Fontname','Arial')
  
    text1=text(170,585,['Sparse SD-SIM']);
    set(text1,'Color',[0,1,0],'Fontsize',25,'Fontname','Arial')
    export_fig(gcf,['stage2\',int2str(flage),'total.png'])
end
for i=515:516
    figure(1)
    flage=flage+1;
    large=imread(['stage1\',int2str(i),'.tif']);
    imshow(large,'border','tight','initialmagnification','fit')
    set (gcf,'Position',[0,0,1*size(large,2),1*size(large,1)])
    
    text1=text(230,505,['SD-SIM']);
    set(text1,'Color',[1,0,0],'Fontsize',25,'Fontname','Arial')
%     
%     text1=text(280,545,['+']);
%     set(text1,'Color',[1,1,1],'Fontsize',25,'Fontname','Arial')
%   
%     text1=text(170,585,['Sparse SD-SIM']);
%     set(text1,'Color',[0,1,0],'Fontsize',25,'Fontname','Arial')
    export_fig(gcf,['stage2\',int2str(flage),'total.png'])
end

for i=517:543
    figure(1)
    flage=flage+1;
    large=imread(['stage1\',int2str(i),'.tif']);
    imshow(large,'border','tight','initialmagnification','fit')
    set (gcf,'Position',[0,0,1*size(large,2),1*size(large,1)])
    
    text1=text(230,505,['SD-SIM']);
    set(text1,'Color',[1,0,0],'Fontsize',25,'Fontname','Arial')
%     
    text1=text(280,545,['+']);
    set(text1,'Color',[1,1,1],'Fontsize',25,'Fontname','Arial')
  
    text1=text(170,585,['Sparse SD-SIM']);
    set(text1,'Color',[0,1,0],'Fontsize',25,'Fontname','Arial')
    export_fig(gcf,['stage2\',int2str(flage),'total.png'])
end
for i=544:552
    figure(1)
    flage=flage+1;
    large=imread(['stage1\',int2str(i),'.tif']);
    imshow(large,'border','tight','initialmagnification','fit')
    set (gcf,'Position',[0,0,1*size(large,2),1*size(large,1)])
    
    text1=text(230,505,['SD-SIM']);
    set(text1,'Color',[1,0,0],'Fontsize',25,'Fontname','Arial')
%     
%     text1=text(280,545,['+']);
%     set(text1,'Color',[1,1,1],'Fontsize',25,'Fontname','Arial')
%   
%     text1=text(170,585,['Sparse SD-SIM']);
%     set(text1,'Color',[0,1,0],'Fontsize',25,'Fontname','Arial')
    export_fig(gcf,['stage2\',int2str(flage),'total.png'])
end

for i=553:573
    figure(1)
    flage=flage+1;
    large=imread(['stage1\',int2str(i),'.tif']);
    imshow(large,'border','tight','initialmagnification','fit')
    set (gcf,'Position',[0,0,1*size(large,2),1*size(large,1)])
    
    text1=text(230,505,['SD-SIM']);
    set(text1,'Color',[1,0,0],'Fontsize',25,'Fontname','Arial')
%     
    text1=text(280,545,['+']);
    set(text1,'Color',[1,1,1],'Fontsize',25,'Fontname','Arial')
  
    text1=text(170,585,['Sparse SD-SIM']);
    set(text1,'Color',[0,1,0],'Fontsize',25,'Fontname','Arial')
    export_fig(gcf,['stage2\',int2str(flage),'total.png'])
end
for i=574:642
    figure(1)
    flage=flage+1;
    large=imread(['stage1\',int2str(i),'.tif']);
    imshow(large,'border','tight','initialmagnification','fit')
    set (gcf,'Position',[0,0,1*size(large,2),1*size(large,1)])
    
%     text1=text(230,505,['SD-SIM']);
%     set(text1,'Color',[1,0,0],'Fontsize',25,'Fontname','Arial')
% %     
%     text1=text(280,545,['+']);
%     set(text1,'Color',[1,1,1],'Fontsize',25,'Fontname','Arial')
  
    text1=text(170,585,['Sparse SD-SIM']);
    set(text1,'Color',[0,1,0],'Fontsize',25,'Fontname','Arial')
    export_fig(gcf,['stage2\',int2str(flage),'total.png'])
end

for i=643:667
    figure(1)
    flage=flage+1;
    large=imread(['stage1\',int2str(i),'.tif']);
    imshow(large,'border','tight','initialmagnification','fit')
    set (gcf,'Position',[0,0,1*size(large,2),1*size(large,1)])
    
    text1=text(230,505,['SD-SIM']);
    set(text1,'Color',[1,0,0],'Fontsize',25,'Fontname','Arial')
%     
    text1=text(280,545,['+']);
    set(text1,'Color',[1,1,1],'Fontsize',25,'Fontname','Arial')
  
    text1=text(170,585,['Sparse SD-SIM']);
    set(text1,'Color',[0,1,0],'Fontsize',25,'Fontname','Arial')
    export_fig(gcf,['stage2\',int2str(flage),'total.png'])
end

for i=668
    figure(1)
    flage=flage+1;
    large=imread(['stage1\',int2str(i),'.tif']);
    imshow(large,'border','tight','initialmagnification','fit')
    set (gcf,'Position',[0,0,1*size(large,2),1*size(large,1)])
    
%     text1=text(230,505,['SD-SIM']);
%     set(text1,'Color',[1,0,0],'Fontsize',25,'Fontname','Arial')
% %     
%     text1=text(280,545,['+']);
%     set(text1,'Color',[1,1,1],'Fontsize',25,'Fontname','Arial')
  
    text1=text(170,585,['Sparse SD-SIM']);
    set(text1,'Color',[0,1,0],'Fontsize',25,'Fontname','Arial')
    export_fig(gcf,['stage2\',int2str(flage),'total.png'])
end




for i=1:666
    stack0=imread(['stage2\',num2str(i),'total.png']);
    stack(:,:,:,i)=imresize(stack0,[777,1618] );
end
% % imshow(stack,'border','tight','initialmagnification','fit')
% % set (gcf,'Position',[0,0,1*size(stack,2),1*size(stack,1)])
% % save(['stack.mat'],'stack','-v7.3');
% % load stack.mat
% 
draw_avi(stack,'VideoTOM203D-full.mp4',1,100)

% draw_avi(stack,'VideoTOM203D-small.mp4',1,30)