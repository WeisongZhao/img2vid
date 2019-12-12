function roil=tifresize(roi,img)
if ndims(roi)==4
    [wx,wy,~,~]=size(img);
    [x,y,~,t]=size(roi);
    if wx/x>wy/y
        for i=1:t
            roil(:,:,:,i)=imresize(squeeze(roi(:,:,:,i)),[round(x*(wy/y)),wy]);           
        end      
    else
        for i=1:t
            roil(:,:,:,i)=imresize(squeeze(roi(:,:,:,i)),[wx,round(y*(wx/x))]);
        end
    end
else
    [wx,wy,~]=size(img);
    [x,y,t]=size(roi);
    if wx/x>wy/y
        for i=1:t
            roil(:,:,i)=imresize(squeeze(roi(:,:,i)),[round(x*(wy/y)),wy]);           
        end       
    else
        for i=1:t
            roil(:,:,i)=imresize(squeeze(roi(:,:,i)),[wx,round(y*(wx/x))]);
        end
    end
end