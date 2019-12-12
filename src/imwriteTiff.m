function imwriteTiff(tifimage, filename)

t = Tiff(filename, 'w');

tagstruct.ImageLength = size(tifimage, 1);
tagstruct.ImageWidth = size(tifimage, 2);
tagstruct.Photometric = Tiff.Photometric.MinIsBlack;
tagstruct.BitsPerSample = 8;
tagstruct.SampleFormat = Tiff.SampleFormat.UInt;
tagstruct.PlanarConfiguration = Tiff.PlanarConfiguration.Chunky;

for k = 1:size(tifimage, 3)
    t.setTag(tagstruct)
    t.write(uint8(tifimage(:, :, k)));
    t.writeDirectory();
    if mod(k,100)==0
       disp([num2str(k),'frames']) 
    end
end

t.close();
end