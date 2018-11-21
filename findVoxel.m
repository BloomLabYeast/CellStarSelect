function [Y,X,plane,peakIntensity] = findVoxel(spotYX, imgStack, regionSize)
%findVoxel Find the brightest voxel of region surrounding a given spot
%
%   Inputs : 
%       spotYX : Array containing Y and X coordinate of spot
%
%       imgStack : A three-dimensional matrix composed of image planes
%
%       regionSize : An odd integer specifying the side length of the 
%       square region to be used to search for the brightest voxel.
%
%   Outputs :
%       Y : Y coordinate (row)
%
%       X : X coordinate (column)
%
%       plane: Plane coordinate (3rd dimension)
%
%       peakIntensity: Intensity value of brightest voxel

%% Determine half size of region
if mod(regionSize,2) == 0
    error('Variable regionSize must be an odd integer');
else
    halfRS = (regionSize-1)/2;
end

%% Create binary image to wipe out all other regions of image
binaryStack = zeros(size(imgStack));
binaryStack(spotYX(1)-halfRS:spotYX(1)+halfRS,... %first dimension
          spotYX(2)-halfRS:spotYX(2)+halfRS,... %second dimension
          :)... %third dimension
          = 1;
filterStack = binaryStack .* double(imgStack);
[peakIntensity, idx] = max(filterStack(:));
[Y, X, plane] = ind2sub(size(filterStack), idx);

end