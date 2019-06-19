%3D Visualization of Topographic Data

load topo topo topomap1 % Load data
whos('topo','topomap1')

%%One way to visualize topographic data is to create a contour plot.
%%To show the outline of the Earth’s continents, plot points that have zero altitude. 
%%The first three input arguments to contour specify the X, Y, and Z values on the contour plot. 
%%The fourth argument specifies the contour levels to plot.

x = 0:359; % Longitude
y = -89:90; % Latitude
figure
contour(x,y,topo,[0 0])
axis equal % Set axis units to be the same size
box on % Display bounding box
ax = gca; % Get current axis
ax.XLim = [0 360]; % Set x limits
ax.YLim = [-90 90]; % Set y limits
ax.XTick = [0 60 120 180 240 300 360]; % Define x ticks
ax.YTick = [-90 -60 -30 0 30 60 90]; % Define y ticks

%%The topography data is treated as an index into the custom colormap. 
%%Set the CDataMapping of the image to ‘scaled’ to linearly scale the data values to the range of the colormap. 
%%In this colormap, the shades of green show the altitude data and the shades of the blue represent depth below sea level.

image([0 360],[-90 90], flip(topo), 'CDataMapping', 'scaled')
colormap(topomap1)
axis equal % Set axis units to be the same size
ax = gca; % Get current axis
ax.XLim = [0 360]; % Set x limits
ax.YLim = [-90 90]; % Set y limits
ax.XTick = [0 60 120 180 240 300 360]; % Define x ticks
ax.YTick = [-90 -60 -30 0 30 60 90]; % Define y ticks

%%Texture mapping maps a 2D image onto a 3D surface. 
%%To map the topography to a spherical surface, set the color of the surface, specified by the CData property, to the topographic data and set the FaceColor property to ‘texturemap’.

clf
[x,y,z] = sphere(50); % Create a sphere
s = surface(x,y,z); % Plot spherical surface
s.CData = topo; % Set color data to topographic data
s.FaceColor = 'texturemap'; % Use texture mapping
s.EdgeColor = 'none'; % Remove edges
s.FaceLighting = 'gouraud'; % Preferred lighting for curved surfaces
s.SpecularStrength = 0.4; % Change the strength of the reflected light
light('Position',[-1 0 1]) % Add a light
axis square off % Set axis to square and remove axis
view([-30,30]) % Set the viewing angle