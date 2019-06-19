%3D Visualization of MRI Data
%%An example of scalar data includes MRI data. This data typically contains several slice planes taken through a volume, such as the human body. 
%%MATLAB provides an MRI dataset that contains 27 image slices of a human head.

load mri
D = squeeze(D);

%%To display one of the MRI images, use the image command. First, create a new figure that uses the MRI colormap, which is loaded with the data. 
%%Then index into the data array to obtain the data the eighth image and adjust axis scaling as follows:

figure
colormap(map)
image_num = 8;
image(D(:,:,image_num))
axis image
% Save x and y values f0r later use
x = xlim;
y = ylim;

%%It is customary to visualize MRI data as volume data because it is a collection of slices taken progressively through the 3D object. 
%%In MAATLAB We can use contourslice to display a contour plot of a volume slice.

cm = brighten(jet(length(map)),-0.5); %To improve the visibility of details, this contour plot uses the jet colormap &The brighten function reduces the brightness of the color values.
figure
colormap(cm)
contourslice(D,[],[],image_num)
axis ij % Adjust the y-axis direction
xlim(x) % Set limit
ylim(y) % Set limit
daspect([1,1,1]) % Set the data aspect ratio

%you can display four contour slices in a 3D view.
figure
colormap(cm)
contourslice(D,[],[],[1,12,19,27],8);
view(3);
axis tight
box
%Smooth the data set and calculate isodata
figure
colormap(map)
Ds = smooth3(D);
hiso = patch(isosurface(Ds,5), ...
'FaceColor',[1,0.75,0.65], ...
'EdgeColor','none');
isonormals(Ds,hiso)

%%The isonormals function renders the isosurfaces using vertex normal obtained from the smoothed data, improving the quality of the isosurfaces. 
%%The isosurfaces uses a single color to represent its isovalue. 
%%Using isocaps to calculate the data for another patch that is displayed at the same isovalue (5) as the isosurfaces. We will use the unsmoothed data (D) to show the details of the interior. 
%%You can see this as the sliced-away top of the head. The low isocap is not visible in the final view.

hcap = patch(isocaps(D,5), ...
'FaceColor','interp', ...
'EdgeColor','none');

%%Define the view and set the aspect ratio as done previously:
view(35,30)
axis tight
daspect([1,1,0.4])

%%Add lighting and recalculate the surface normal based on the gradient of the volume data, which produces a smoother lighting. 
%%Increase the AmbientStrength property of the isocap to brighten the coloring without affecting the isosurfaces. 
%%Set the SpecularColorReflectance of the isosurface to make the color of the specular reflected light closer to the color of the isosurfaces,
%%set the SpecularExponent to reduce the size of the specular spot.

lightangle(45,30);
lighting gouraud
hcap.AmbientStrength = 0.6;
hiso.SpecularColorReflectance = 0;
hiso.SpecularExponent = 50;
box

%%An isocap combined with an isosurfaces can be used to visualize MRI data. 
%%The isocaps use interpolated face coloring, which means the figure colormap determines the coloring of the patch. 
%%Use the colormap supplied with the data. To display isocaps at other data values we can use the subvolume command as follows:

figure
[x,y,z,D] = subvolume(D,[60,80,nan,80,nan,nan]);
p1 = patch(isosurface(x,y,z,D, 5),...
'FaceColor',[0.36,0.22,0.21],'EdgeColor','none');
isonormals(x,y,z,D,p1);
p2 = patch(isocaps(x,y,z,D, 5),...
'FaceColor','interp','EdgeColor','none');
view(3);
axis tight;
daspect([1 1 0.4])
colormap(gray(100))
camlight right;
camlight left;
lighting gouraud