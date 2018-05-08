function [ frhs ] = matEvaluateStrongFromEdgeRHS( obj, fluxM, fluxP, fluxS )

frhs = mxEvaluateStrongFromEdgeRHS( ...
    obj.mesh.cell.invM, obj.eCell.M, ...
    obj.FToE, obj.FToN1, obj.FToN2, ...
    obj.Js, obj.mesh.J, fluxM, fluxP, fluxS );
end

