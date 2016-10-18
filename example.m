%execuring MVLdoubledecker_github
clc
clear all
close all

x=[1:10];
xlab='X';
legend={'legend1','legend2','legend3','legend4'},;
y1=(2*x)+1;
y2=x.^2;
y3=(x.^2)+x+1;
y4=-4*(x.^2);
y1lab='var1';
y2lab='var2';
y3lab='var3';
y4lab='var4';

MVLdoubledecker_github(x,xlab,legend,y1,y1lab,y2,y2lab,y3,y3lab,y4,y4lab);