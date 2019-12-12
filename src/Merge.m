function img= Merge(roi,whole)
if ndims(roi)==4
    [x,y,~,t]=size(roi);
    [wx,wy,~,~]=size(whole);
    if x>=wx&&y>=wy
        roil=roi(1:size(whole,1),1:size(whole,2),:,:);
    elseif x<wx&&y>=wy
        roil=roi(:,1:size(whole,2),:,:);
    elseif x>=wx&&y<wy
        roil=roi(1:size(whole,1),:,:,:);
    else
        roil=roi;
    end
    [sx,sy,~,~]=size(roil);
    img=zeros([wx,wy,3,t]);
    rx=wx-sx;
    ry=wy-sy;
    img(floor(rx/2)+1:floor(rx/2)+size(roil,1),floor(ry/2)+1:floor(ry/2)+size(roil,2),:,:)=roil;
else
    [x,y,t]=size(roi);
    [wx,wy,~]=size(whole);
    if x>=wx&&y>=wy
        roil=roi(1:size(whole,1),1:size(whole,2),:);
    elseif x<wx&&y>=wy
        roil=roi(:,1:size(whole,2),:);
    elseif x>=wx&&y<wy
        roil=roi(1:size(whole,1),:,:);
    else
        roil=roi;
    end
    [sx,sy,~]=size(roil);
    img=zeros([wx,wy,t]);
    rx=wx-sx;
    ry=wy-sy;
    img(floor(rx/2)+1:floor(rx/2)+size(roil,1),floor(ry/2)+1:floor(ry/2)+size(roil,2),:)=roil;
end
