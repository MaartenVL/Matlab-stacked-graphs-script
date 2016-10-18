function  MVLdoubledecker_github(x,xlab,legend,varargin)
close all
%Script by Maarten Van Loo
%plotting multiple variables with same x array in one figure.
%input variables

%x
%xlabel
%legend
%y1
%y1label
%y2
%y2label
%etc

%%
% get min and max of 1st variable. This will scale following variables
base_min=min(varargin{1});
base_max=max(varargin{1});

%number of vars to be plotted
numplot=nargin-3-(numel(varargin)/2);

%get new max limits for each var except the first.
newlimits=[1:numplot];
newlimits=(newlimits*(base_max-base_min))+min(varargin{1,1});

% rescale vars except first between new limits
tik=1;
for i=3:2:nargin-3
    tik=tik+1;
    rescale{1,tik}=(((varargin{1,i}-min(varargin{1,i})).*(newlimits(tik)-newlimits(tik-1)))./(max(varargin{1,i})-min(varargin{1,i})))+newlimits(tik-1);
end
rescale{1,1}=varargin{1,1}

%find midpoints for all vars, which will be used as X and Y ticks en their
%labels
tik=0;
for i=1:2:numplot*2
    tik=tik+1;
    mids{1,tik}=((max(rescale{1,tik})-min(rescale{1,tik}))/2)+min(rescale{1,tik});
    mids_lab{1,tik}=((max(varargin{1,i})-min(varargin{1,i}))/2)+min(varargin{1,i});
    ticks{1,tik}=[min(rescale{1,tik}) mids{1,tik} max(rescale{1,tik})];
    ticks_lab{1,tik}=[min(varargin{1,i}) mids_lab{1,tik} max(varargin{1,i})];
end

% get indices for even and uneven-numbered vars
evenind=[1:2:numplot];
unevenind=[2:2:numplot];

% rescale labels - (min mid and max)
lefttick=[ticks{1,evenind}];
righttick=[ticks{1,unevenind}];

% rescale labels - (min mid and max)
leftticklabel=ticks_lab(evenind);
rightticklabel=ticks_lab(unevenind);

% plot
for i=1:numplot
    hold on
    plot(x,rescale{1,i},'k');
end
set(gca,'YLim', [min(rescale{1,1}) max(rescale{1,end})]); % de bovenste zijn laatste tick = normaal hoogste
set(gca,'ytick',lefttick);
set(gca,'yticklabel',leftticklabel);
set(gca,'XLim', [min(x) max(x)]); 

%size of axes and labels
FSaxlabel=13;
FSax=12;

%Xlabel
xlabel(xlab,'FontWeight','bold', 'FontSize',FSaxlabel);
set(gca,'FontWeight','bold','FontSize',FSax); %bold axis
set(gcf,'color','w');
set(gca,'LineWidth',2);

%Making plot area smaller so Ylabels will fit nicely
figpos=get(gcf,'Position');
x_offset=((figpos(3)-figpos(1))/100)*10;
set(gca,'Units','pixels');
ax1pos=get(gca,'Position');
ax1pos_update=ax1pos+[x_offset 0 -2*(x_offset) 0]; % minus 2 since you x_offset translation to the right needs to be cancelled out on top of the leftward translation from the right axis
set(gca,'Position',ax1pos_update);


%YLabels
rot_text=ones(1,numplot);
add_axpos=size(1,numplot);
add_axpos(evenind)=0; % starting from leftaxis (=zero)
add_axpos(unevenind)=ax1pos_update(3);
rot_text(unevenind)=-1;
mid2pixHeight=(((cell2mat(mids)-min(cell2mat(rescale))).*ax1pos_update(4))./(max(cell2mat(rescale))-min(cell2mat(rescale))));
for i=1:numplot
    htext=text(0,1,varargin{i*2},'VerticalAlignment','middle','HorizontalAlignment','center','rotation',rot_text(i)*90,'FontSize',FSaxlabel,'FontWeight','bold')
    set(htext,'Units','pixels');
    text_x_pos(i)=add_axpos(i)-((ax1pos_update(1)/2)*rot_text(i));
    set(htext,'Position',[text_x_pos(i) mid2pixHeight(i)]);
end


%extra Y axis right
hold on
box off
a2 = axes('YAxisLocation', 'Right');
set(a2, 'color', 'none');
set(a2, 'XTick', []);
set(a2,'Units','pixels');
set(a2,'Position',ax1pos_update);
set(a2, 'YLim', [min(rescale{1,1}) max(rescale{1,end})]); % de bovenste zijn laatste tick = normaal hoogste
set(a2,'ytick',righttick);
set(a2,'yticklabel',rightticklabel);
set(a2,'FontWeight','bold','FontSize',FSax); %bold axis
set(a2,'LineWidth',2);


%extra Xaxis top
a3 = axes('XAxisLocation', 'Top');
set(a3, 'color', 'none');
set(a3, 'YTick', []);
set(a3,'Units','pixels');
set(a3,'Position',ax1pos_update);
set(a3, 'XLim', [min(x) max(x)])
set(a3,'XTickLabel',[]);
set(a3,'FontWeight','bold','FontSize',FSax); %bold axis
set(a3,'LineWidth',2);

%legend
legend

end

