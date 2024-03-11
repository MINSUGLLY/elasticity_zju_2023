%%
clear;
close all;
clc;
if exist('./picture')
    rmdir('./picture', 's');
end

%% 参数设置(国际单位制) 
% 设置图像是否显示,不显示计算数据
set(0,'DefaultFigureVisible', 'off')

% 钢材型号 Q345
E = 2.0e11; % 杨氏模量
nu = 0.3; % 泊松比

p = 1000; % 外加载荷
Ls = [0.1 0.2 0.3 0.5 0.75 1.0 1.5 2.0 2.5 3.0 5.0 7.5 10.0 12.5 15.0]; % 长
hs = [0.1 0.2 0.3 0.5 0.75 1.0 1.25 1.5 1.75 2.0]; % 高
ts = [0.1 0.2 0.3 0.5 0.75 1.0 1.25 1.5 1.75 2.0]; % 厚

%% 弹性力学计算
maxStress = [];
for L = Ls
    maxStress_L = [];
    for h = hs
        maxStress_Lh = [];
        for t = ts
            maxStress_Lh(end+1) = Elasticity(L, h, t, E, nu, p);
        end
        maxStress_L = cat(1, maxStress_L, maxStress_Lh);
    end
    maxStress = cat(3, maxStress, maxStress_L);
end

%% 有限元方法
meshSizeRatio = 0.25; % meshSize = meshSizeRatio * median([L, h, t])
maxFEMdisplacement = [];
maxFEMstress = [];
for L = Ls
    maxFEMstress_L = [];
    maxFEMdisplacement_L = [];
    for h = hs
        maxFEMstress_Lh = []; 
        maxFEMdisplacement_Lh = [];
        for t = ts
            femResult = FEM(L, h, t, E, nu, p, meshSizeRatio);
            maxFEMdisplacement_Lh(end+1) = max(femResult.Displacement.Magnitude);
            maxFEMstress_Lh(end+1) = max(femResult.VonMisesStress);
        end
        maxFEMstress_L = cat(1, maxFEMstress_L, maxFEMstress_Lh);
        maxFEMdisplacement_L = cat(1, maxFEMdisplacement_L, maxFEMdisplacement_Lh);
    end
    maxFEMstress = cat(3, maxFEMstress, maxFEMstress_L);
    maxFEMdisplacement = cat(3, maxFEMdisplacement, maxFEMdisplacement_L);
end

%% 保存数据
save('DATA.mat', 'maxStress', "maxFEMstress", 'nu', 'E', 'p', 'Ls', 'hs', 'ts');