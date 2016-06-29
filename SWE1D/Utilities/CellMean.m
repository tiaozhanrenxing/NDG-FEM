%% CellMean
% Calculate mean depth in each cell
function hmean = CellMean(mesh, h)
Np    = mesh.Shape.nNode;
uh    = mesh.Shape.VandMatrix\h;  uh(2:Np,:)=0;
uavg  = mesh.Shape.VandMatrix*uh; 
hmean = uavg(1,:);
end% func