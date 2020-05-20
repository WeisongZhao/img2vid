function out = radar(d1,d2,rate,isRGB,linewidth)
if isRGB==0
    d1 = repmat(d1,[1,1,3]);
    d2 = repmat(d2,[1,1,3]);
end
[y,x,~] = size(d1);
alpha = 0:rate:360;
out = zeros(y,x,3,length(alpha));
for i=1:length(alpha)
    out(:,:,:,i) = assign(d1,d2,alpha(i),y,x);
    out(:,:,:,i) = drawline(out(:,:,:,i),alpha(i),y,x,linewidth);
    %     disp(alpha(i));
    %     imshow(out(:,:,:,i),[]);
end
end

function out = assign(d1,d2,alpha,y,x)
midy = round(y/2);
midx = round(x/2);
out = zeros(y,x,3);
if alpha==0
    out = d1;
elseif alpha == 360
    out = d2;
elseif alpha == 180
    out(:,1:midx,:) = d1(:,1:midx,:);
    out(:,midx+1:end,:) = d2(:,midx+1:end,:);
elseif alpha <180
    out(:,1:midx,:) = d1(:,1:midx,:);
    for i=1:y
        for j=midx+1:x
            cy = midy-i;
            cx = j-midx;
            if cx == 0
                cx = 1e-7;
            end
            if cy/cx >= tan((90-alpha)/180*pi)
                out(i,j,:) = d2(i,j,:);
            else
                out(i,j,:) = d1(i,j,:);
            end
        end
    end
elseif alpha>180
    out(:,midx+1:end,:) = d2(:,midx+1:end,:);
    for i=1:y
        for j=1:midx
            cx = midx-j;
            cy = midy-i;
            if cx == 0
                cx = 1e-7;
            end
            if cy/cx > tan((90-(360-alpha))/180*pi)
                out(i,j,:) = d1(i,j,:);
            else
                out(i,j,:) = d2(i,j,:);
            end
        end
    end
end
end

function out = drawline(in,alpha,y,x,linewidth)
midx = round(x/2);
midy = round(y/2);
out = in;
out(1:midy,midx-1:midx,:) = 1;
if alpha == 180
    out(midy+1:end,midx-1:midx,:) = 1;
end
if alpha~=0 && alpha~=360 && alpha~=180
    if alpha < 180
        cx = midx:x;
        cy = midy-tan((90-alpha)/180*pi)*(cx-midx);
    else
        cx = 1:midx;
        cy = midy-tan((90-(360-alpha))/180*pi)*(midx-cx);
    end
    out=bitmapplot(cy,cx,out,struct('LineWidth',linewidth,'Color',[1 1 1 1]));
end
end

