%% CALCULO DEL ANGULO ENTRE DOS VECTORES 3D

% UTILIZA EL PRODUCTO PUNTO PARA CALCULAR EL ANGULO ENTRE DOS
% VECTORES EN 3 DIMENSIONES

function [ang] = ang_ProdPun(vec1,vec2)


num = (vec1(1)*vec2(1))+(vec1(2)*vec2(2))+(vec1(3)*vec2(3));
den = norm(vec1)*norm(vec2);

ang = rad2deg(acos(num/den));

end

