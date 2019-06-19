%Visualizing Vector Volume Data for Wind Velocity
Figure
% Load data
load wind u v w x y z
[m,n,p] = size(u);
% Calculate the location of the cones
[Cx, Cy, Cz] = meshgrid(1:4:m,1:4:n,1:4:p);
% Draw the cone plot
h = coneplot(u,v,w,Cx,Cy,Cz,y,4);
set(h,'EdgeColor', 'none')
axis tight equal
view(37,32)
box on
colormap(hsv)
light
%%The streamline function plot streamlines for a velocity vector at 𝑥,𝑦,𝑧 points in a volume to illustrate the flow of a 3D vector field.

% Clear the current axes
cla
[m,n,p] = size(u);
% Calculate the starting points of the streamlines
[Sx, Sy, Sz] = meshgrid(1,1:5:n,1:5:p);
% Draw the streamlines
streamline(u,v,w,Sx,Sy,Sz)
axis tight equal
view(37,32)
box on

%%The streamtube function plots streamtubes for a velocity vector at 𝑥,𝑦,𝑧 points in a volume. 
%%The width of the tube is proportional to the normalized divergence of the vector field at each point

cla
% Wind speed at each point in the volume
spd = sqrt(u.*u + v.*v + w.*w);
% Isosurface for the outside of the volume
[fo,vo] = isosurface(x,y,z,spd,40);
% Isocaps for the end caps of the volume
[fe,ve,ce] = isocaps(x,y,z,spd,40);
% Draw the isosurface for the volume
p1 = patch('Faces', fo, 'Vertices', vo);
p1.FaceColor = 'red';
p1.EdgeColor = 'none';
% Draw the end caps of the volume
p2 = patch('Faces', fe, 'Vertices', ve, ...
'FaceVertexCData', ce);
p2.FaceColor = 'interp';
p2.EdgeColor = 'none' ;
% Isosurface for the cones
[fc, vc] = isosurface(x, y, z, spd, 30);
% Reduce the number of faces and vertices
[fc, vc] = reducepatch(fc, vc, 0.2);
% Draw the coneplot
h1 = coneplot(x,y,z,u,v,w,vc(:,1),vc(:,2),vc(:,3),3);
h1.FaceColor = 'cyan';
h1.EdgeColor = 'none';
% Starting points for streamline
[sx, sy, sz] = meshgrid(80, 20:10:50, 0:5:15);
% Draw the streamlines
h2 = streamline(x,y,z,u,v,w,sx,sy,sz);
set(h2, 'Color', [.4 1 .4])
axis tight equal
view(37,32)
box on
light