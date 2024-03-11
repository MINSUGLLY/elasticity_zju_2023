%%
clear;
close all;
clc;

load('./DATA.mat')
%%
% 设置图像是否显示,显示统计数据
set(0,'DefaultFigureVisible', 'on')

delta = abs(maxFEMstress - maxStress) ./ maxFEMstress;
dataSize = size(delta);
Lnum = dataSize(3); 
hnum = dataSize(2);
tnum = dataSize(1); 

%% L mean
delta_L = [];
for i = 1:Lnum
    delta_L(end+1) = mean(mean(delta(:,:,i)));
end
Lfigure = figure('Name', 'L', 'NumberTitle', 'off');
Laxes = axes(Lfigure, 'NextPlot', 'add', 'Box', 'on', 'FontName', 'Times New Roman', 'FontSize', 16);
Lpoly = polyfit(Ls, delta_L, 1);
Lxfit = 0:0.01:max(Ls);
Lyfit = polyval(Lpoly, Lxfit);
Lscatter = plot(Lxfit, Lyfit, Ls, delta_L, 'r*');
xlabel(Laxes, '$L$', 'Interpreter', 'latex');
ylabel(Laxes, '${\delta}$', 'Interpreter', 'latex');
xlim(Laxes, [0, Ls(end)]);
ylim(Laxes, [0, 1]);
title(Laxes, '${\delta}-L$', 'Interpreter', 'latex');

%% h mean
delta_h = [];
for i = 1:hnum
    delta_h(end+1) = mean(mean(delta(i,:,:)));
end
hfigure = figure('Name', 'h', 'NumberTitle', 'off');
haxes = axes(hfigure, 'NextPlot', 'add', 'Box', 'on', 'FontName', 'Times New Roman', 'FontSize', 16);
hpoly = polyfit(hs, delta_h, 1);
hxfit = 0:0.01:max(hs);
hyfit = polyval(hpoly, hxfit);
hscatter = plot(hxfit, hyfit, hs, delta_h, 'r*');
xlabel(haxes, '$h$', 'Interpreter', 'latex');
ylabel(haxes, '${\delta}$', 'Interpreter', 'latex');
xlim(haxes, [0, hs(end)]);
ylim(haxes, [0, 1]);
title(haxes, '${\delta}-h$', 'Interpreter', 'latex');


%% t mean
delta_t = [];
for i = 1:tnum
    delta_t(end+1) = mean(mean(delta(:,i,:)));
end
tfigure = figure('Name', 't', 'NumberTitle', 'off');
taxes = axes(tfigure, 'NextPlot', 'add', 'Box', 'on', 'FontName', 'Times New Roman', 'FontSize', 16);
tpoly = polyfit(ts, delta_t, 1);
txfit = 0:0.01:max(ts);
tyfit = polyval(tpoly, txfit);
tscatter = plot(txfit, tyfit, ts, delta_t, 'r*');
xlabel(taxes, '$t$', 'Interpreter', 'latex');
ylabel(taxes, '${\delta}$', 'Interpreter', 'latex');
xlim(taxes, [0, ts(end)]);
ylim(taxes, [0, 1]);
title(taxes, '${\delta}-t$', 'Interpreter', 'latex');

%% t h=1
delta_t11 = squeeze(delta(6,:,11));
delta_t12 = squeeze(delta(6,:,10));
delta_t13 = squeeze(delta(6,:,6));

t1figure = figure('Name', 't1', 'NumberTitle', 'off');
t1axes = axes(t1figure, 'NextPlot', 'add', 'Box', 'on', 'FontName', 'Times New Roman', 'FontSize', 16);

t11poly = polyfit(ts, delta_t11, 1);
t11xfit = 0:0.01:max(ts);
t11yfit = polyval(t11poly, t11xfit);
t11scatter = plot(t11xfit, t11yfit, ts, delta_t11, 'r*');

t12poly = polyfit(ts, delta_t12, 1);
t12xfit = 0:0.01:max(ts);
t12yfit = polyval(t12poly, t12xfit);
t12scatter = plot(t12xfit, t12yfit, ts, delta_t12, 'b*');

t13poly = polyfit(ts, delta_t13, 1);
t13xfit = 0:0.01:max(ts);
t13yfit = polyval(t13poly, t13xfit);
t13scatter = plot(t13xfit, t13yfit, ts, delta_t13, 'g*');

legend('L=5 fit', 'L=5 scatter', 'L=3 fit', 'L=3 scatter', 'L=1 fit', 'L=1 scatter');
xlabel(t1axes, '$t$', 'Interpreter', 'latex');
ylabel(t1axes, '${\delta}$', 'Interpreter', 'latex');
xlim(t1axes, [0, ts(end)]);
ylim(t1axes, [0, 1]);
title(t1axes, '${\delta}-t$, where h=1', 'Interpreter', 'latex');

%% t h=0.3
delta_t21 = squeeze(delta(3,:,11));
delta_t22 = squeeze(delta(3,:,10));
delta_t23 = squeeze(delta(3,:,6));

t2figure = figure('Name', 't2', 'NumberTitle', 'off');
t2axes = axes(t2figure, 'NextPlot', 'add', 'Box', 'on', 'FontName', 'Times New Roman', 'FontSize', 16);

t21poly = polyfit(ts, delta_t21, 1);
t21xfit = 0:0.01:max(ts);
t21yfit = polyval(t21poly, t21xfit);
t21scatter = plot(t21xfit, t21yfit, ts, delta_t21, 'r*');

t22poly = polyfit(ts, delta_t22, 1);
t22xfit = 0:0.01:max(ts);
t22yfit = polyval(t22poly, t22xfit);
t22scatter = plot(t22xfit, t22yfit, ts, delta_t22, 'b*');

t23poly = polyfit(ts, delta_t23, 1);
t23xfit = 0:0.01:max(ts);
t23yfit = polyval(t23poly, t23xfit);
t23scatter = plot(t23xfit, t23yfit, ts, delta_t23, 'g*');

legend('L=5 fit', 'L=5 scatter', 'L=3 fit', 'L=3 scatter', 'L=1 fit', 'L=1 scatter');
xlabel(t2axes, '$t$', 'Interpreter', 'latex');
ylabel(t2axes, '${\delta}$', 'Interpreter', 'latex');
xlim(t2axes, [0, ts(end)]);
ylim(t2axes, [0, 1]);
title(t2axes, '${\delta}-t$, where h=0.3', 'Interpreter', 'latex');

%% eta
eta = reshape(ts'./Ls, 1, []);
delta_eta = reshape(squeeze(mean(delta, 1)), 1, []);

etafigure = figure('Name', 'eta', 'NumberTitle', 'off');
etaaxes = axes(etafigure, 'NextPlot', 'add', 'Box', 'on', 'FontName', 'Times New Roman', 'FontSize', 16);
etapoly = polyfit(eta, delta_eta, 1);
etaxfit = 0:0.01:max(eta);
etayfit = polyval(etapoly, etaxfit);
etascatter = plot(etaxfit, etayfit, eta, delta_eta, 'r.');
xlabel(etaaxes, '${\eta}$', 'Interpreter', 'latex');
ylabel(etaaxes, '${\delta}$', 'Interpreter', 'latex');
xlim(etaaxes, [0, max(eta)]);
ylim(etaaxes, [0, 1]);
title(etaaxes, '${\delta}-{\eta}$', 'Interpreter', 'latex');

%% xi
xi = reshape(hs'./Ls, 1, []);
delta_xi = reshape(squeeze(mean(delta, 2)),1 , []);

xifigure = figure('Name', 'xi', 'NumberTitle', 'off');
xiaxes = axes(xifigure, 'NextPlot', 'add', 'Box', 'on', 'FontName', 'Times New Roman', 'FontSize', 16);
xipoly = polyfit(xi, delta_xi, 1);
xixfit = 0:0.01:max(xi);
xiyfit = polyval(xipoly, xixfit);
xiscatter = plot(xixfit, xiyfit, xi, delta_xi, 'r.');
xlabel(xiaxes, '${\xi}$', 'Interpreter', 'latex');
ylabel(xiaxes, '${\delta}$', 'Interpreter', 'latex');
xlim(xiaxes, [0, max(xi)]);
ylim(xiaxes, [0, 1]);
title(xiaxes, '${\delta}-{\xi}$', 'Interpreter', 'latex');
%% omega
X = zeros([Lnum*hnum*tnum, 3]);
X(:, 3) = 1;
deltaLabel = [];
X1 = [];
X2 = [];
for i = 1:Lnum
    for j = 1:hnum
        for k = 1:tnum
            deltaLabel(end+1) = log(delta(j, k, i));
            X1(end+1) = log(ts(k)/Ls(i));
            X2(end+1) = log(hs(j)/Ls(i));
        end
    end
end
deltaLabel = deltaLabel';
X1 = X1';
X2 = X2';
X(:, 1) = X1;
X(:, 2) = X2;

omega = (X'*X)^(-1)*X'*deltaLabel;

[meshX, meshY] = meshgrid(min(X1):0.2:max(X1), min(X2):0.2:max(X2));
meshZ = omega(1)*meshX+omega(2)*meshY+omega(3);
omegafigure = figure('Name', 'omega', 'NumberTitle', 'off');
omegaaxes = axes(omegafigure, 'Box', 'on', 'FontName', 'Times New Roman', 'FontSize', 16);

omegascatter = scatter3(X1,X2,deltaLabel);
hold on;
omegamesh = mesh(meshX,meshY,meshZ);
hold off;

xlabel(omegaaxes, '$log{\eta}$', 'Interpreter', 'latex');
ylabel(omegaaxes, '$log{\xi}$', 'Interpreter', 'latex');
zlabel(omegaaxes, '$log{\delta}$', 'Interpreter', 'latex');
title(omegaaxes, '$log{\delta}-log{\eta},log{\xi}$', 'Interpreter', 'latex');

%% origin
originfigure = figure('Name', 'origin', 'NumberTitle', 'off');
originaxes = axes(originfigure, 'Box', 'on', 'FontName', 'Times New Roman', 'FontSize', 16);

originscatter = scatter3(exp(X1),exp(X2),exp(deltaLabel));
xlabel(originaxes, '${\eta}$', 'Interpreter', 'latex');
ylabel(originaxes, '${\xi}$', 'Interpreter', 'latex');
zlabel(originaxes, '${\delta}$', 'Interpreter', 'latex');
title(originaxes, '${\delta}-{\eta},{\xi}$', 'Interpreter', 'latex');