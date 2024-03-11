function pdeResult = FEM(L, h, t, E, nu, p, meshSizeRatio)
    if ~exist('./picture')
        mkdir('./picture');
    end
    if ~exist(sprintf('./picture/L=%.2f',L))
        mkdir(sprintf('./picture/L=%.2f',L));
    end
    if ~exist(sprintf('./picture/L=%.2f/h=%.2f',L,h))
        mkdir(sprintf('./picture/L=%.2f/h=%.2f',L,h));
    end
    if ~exist(sprintf('./picture/L=%.2f/h=%.2f/t=%.2f',L,h,t))
        mkdir(sprintf('./picture/L=%.2f/h=%.2f/t=%.2f',L,h,t));
    end
    %% PDE定义
    % 定义PDE
    pdeModel = createpde('structural', 'static-solid');
    
    % 设置PDE边界
    pdeModel.Geometry = multicuboid(L, t, h);
    
    % 传入材料的杨氏模量和泊松比
    structuralProperties(pdeModel, 'YoungsModulus', E, 'PoissonsRatio', nu);
                     
    % 悬臂梁边界条件
    structuralBC(pdeModel, 'Face', 5, 'Constraint', 'fixed');
    
    % 外加载荷         
    structuralBoundaryLoad(pdeModel, 'face', 2, 'Pressure', p);
                       
    % 自动生成网格
    meshSize = meshSizeRatio * median([L, h, t]);
    generateMesh(pdeModel, 'Hmax', meshSize);
    hFigureMesh = figure('Name', 'Mesh', 'NumberTitle', 'off');
    hAxesMesh = axes(hFigureMesh, 'NextPlot', 'add', 'Box', 'on', 'FontName', 'Times New Roman', 'FontSize', 16);
    hMesh = pdeplot3D(pdeModel);
    xlabel(hAxesMesh, '$x/{\rm{(m)}}$', 'Interpreter', 'latex');
    ylabel(hAxesMesh, '$y/{\rm{(m)}}$', 'Interpreter', 'latex');
    title(hAxesMesh, 'Mesh');
    saveas(hFigureMesh,sprintf('./picture/L=%.2f/h=%.2f/t=%.2f/mesh.png', L, h, t));
    
    %% PDE求解
    pdeResult = solve(pdeModel);
    
    %% 绘制结果
    % 绘制梁的位移
    hFigureDisplacement = figure('Name', 'Displacement', 'NumberTitle', 'off');
    hAxesDisplacement = axes(hFigureDisplacement, 'NextPlot', 'add', 'Box', 'on', 'FontName', 'Times New Roman', 'FontSize', 16);
    hDisplacement = pdeplot3D(pdeModel, "ColorMapData",pdeResult.Displacement.Magnitude, "Deformation",pdeResult.Displacement, "DeformationScaleFactor",2);
    axis equal;
    xlabel(hAxesDisplacement, '$x/{\rm{(m)}}$', 'Interpreter', 'latex');
    ylabel(hAxesDisplacement, '$y/{\rm{(m)}}$', 'Interpreter', 'latex');
    title(hAxesDisplacement, 'Displacement Magnitude');
    saveas(hFigureDisplacement,sprintf('./picture/L=%.2f/h=%.2f/t=%.2f/displacement.png', L, h, t));
    
    % 利用材料力学第四强度理论，绘制范氏等效应力
    hFigureMises = figure('Name', 'Von Mises Stress', 'NumberTitle', 'off');
    hAxesMises = axes(hFigureMises, 'NextPlot', 'add', 'Box', 'on', 'FontName', 'Times New Roman', 'FontSize', 16);
    hMises = pdeplot3D(pdeModel, "ColorMapData",pdeResult.VonMisesStress, "Deformation",pdeResult.Displacement, "DeformationScaleFactor",2);
    axis equal;
    xlabel(hAxesMises, '$x/{\rm{(m)}}$', 'Interpreter', 'latex');
    ylabel(hAxesMises, '$y/{\rm{(m)}}$', 'Interpreter', 'latex');
    title(hAxesMises, 'von Mises Stress');
    saveas(hFigureMises,sprintf('./picture/L=%.2f/h=%.2f/t=%.2f/stress.png', L, h, t));
end