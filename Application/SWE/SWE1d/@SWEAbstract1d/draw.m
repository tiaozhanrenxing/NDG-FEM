function draw( obj, varargin )

if nargin == 1
    fphys = obj.fphys;
elseif nargin == 2
    fphys = varargin{1};
end
    
% check the figure is created and not removed.
isFigureExit = ~isempty( obj.draw_handle ) ...
    && isvalid( obj.draw_handle{1} ) ;

if isFigureExit
    for m = 1:obj.Nmesh
        mesh = obj.meshUnion(m);
        temp = fphys{m}(:,:,1) + fphys{m}(:,:,3);
        set( obj.draw_handle{m, 1}, 'YData', temp(:) );
        temp = fphys{m}(:,:,2);
        set( obj.draw_handle{m, 2}, 'YData', temp(:) );
        %set( obj.draw_handle{m, 3}, 'YData', mesh.EToR(:) );
    end
else
    for m = 1:obj.Nmesh
        mesh = obj.meshUnion(m);
        Np = mesh.cell.Np; 
        K = mesh.K;
        list = 1:Np:(K*Np);
        g = graph();
        for n = 1:Np-1
            g = addedge(g, list+n-1, list+n);
        end
        temp = fphys{m}(:,:,3);
        subplot(2, 1, 1); hold on;
        plot( g, 'XData', mesh.x(:), ...
            'YData', temp(:), ...
            'LineWidth', 1, ...
            'Marker', '.', ...
            'NodeColor','k', ...
            'EdgeColor', 'k', ...
            'MarkerSize', 2, ...
            'NodeLabel', {});
        temp = fphys{m}(:,:,1) + fphys{m}(:,:,3);
        obj.draw_handle{m, 1} = plot(g, ...
            'XData', mesh.x(:), 'YData', temp(:), ...
            'LineWidth', 1, ...
            'Marker', 'o', ...
            'NodeColor','b', ...
            'EdgeColor', 'b', ...
            'MarkerSize', 2, ...
            'NodeLabel', {});
        box on;
        grid on;
%         obj.draw_handle{m, 3} = plot( ...
%             mesh.xc, mesh.EToR, 'ro');
        
        subplot( 2, 1, 2 ); hold on;
        temp = fphys{m}(:,:,2);
        obj.draw_handle{m, 2} = plot(g, ...
            'XData', mesh.x(:), 'YData', temp(:), ...
            'LineWidth', 1, ...
            'Marker', 'o', ...
            'NodeColor','r', ...
            'EdgeColor', 'r', ...
            'MarkerSize', 2, ...
            'NodeLabel', {});
        box on;
        grid on;
    end
end
end
