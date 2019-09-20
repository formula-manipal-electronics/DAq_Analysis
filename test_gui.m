% basic window initialisation
backcolor = [0 0 0];
axiscolor = [0.75 0.75 0.75];
main = figure('Name','ShankyMahadev','NumberTitle','off');
main.Color = backcolor;
main.WindowState = 'maximized';
main.MenuBar = 'none';
main.ToolBar = 'none';
main.Units = 'pixels';

t = [0:1:1000];

% these are the vertical and horizontal lines there are 4 of them as 1 line for each
% graph
ver_pointer = zeros(4);
hor_pointer = zeros(4);

% temporary to be replaced by loading data code
f = zeros(4,1001);
f(1,1:1001) = sin(0.1*t);
f(2,1:1001) = sin(0.1*t)./(0.1*t);
f(3,1:1001) = sawtooth(0.5*t);
f(4,1:1001) = tan(0.1*t);
rpm_value = 0.5;
thr_value = 0.5;
bpps_value = 0.5;

% p_width is size of hor pointer
% delta is how much the ver pointer moves with each arrow press
% curr_pos is the current loc of the ver pointer
% last_time is the lenght of the data
last_time = size(t);
last_time = last_time(2);
curr_pos = 250;
delta = 1;
p_width = 5;

setappdata(main,'pos',curr_pos);
setappdata(main,'del',delta);
setappdata(main,'lt',last_time);
setappdata(main,'wd',p_width);

%initialisation of layout
%vbox is used for graphs
%bar for gray bar
%hbox for below indicators
vbox = uiextras.VBox('Parent',main,'Position',[0.03 0.275 0.875 0.725],'Padding',19,'BackgroundColor',backcolor);
bar = uiextras.VBox('Parent',main,'Position',[0 0.265 1 0.01],'BackgroundColor',[0.5 0.5 0.5]);
hbox = uiextras.HBox('Parent',main,'Position',[0.01 0 1 0.265],'BackgroundColor',[0 0 0],'Spacing',19,'Padding',19);
s = warning('off', 'MATLAB:uitabgroup:OldVersion');


set(main,'WindowKeyPressFcn',@keycallback)

%creation of axes
for k = 1:4  
    a(k) = axes(vbox,'ActivePositionProperty','Position');
end



%creation of ver gauages
for k = 5:7
    a(k) = axes(hbox,'ActivePositionProperty','Position');
    b(k-4)= uicontrol(hbox,'Style','text','BackgroundColor',backcolor);
end
    p = uipanel(hbox,'BackgroundColor',backcolor);
    set(hbox,'Sizes',[-1 -1.25 -1 -1.25 -1 -1.25 -8.25]);


%temporary plotting needs to replaced
y = [rpm_value rpm_value];

for k= 1:3
    ar(k) = area(a(k+4),y);
    set(a(k+4),'Color',backcolor,'TickDir','out','Box','off','Ylim',[0 2],'XColor',axiscolor,'YColor',axiscolor);
    if(k==1)
        set(a(k+4),'XTick',{},'YTick',[0:0.16:2],'YTickLabel',[0:1:12.5]);
    end
    if(k==2)
        set(a(k+4),'XTick',{},'YTick',[0:0.2:2],'YTickLabel',[0:10:100]);
    end
    if(k==3)
       set(a(k+4),'XTick',{},'YTick',[0:0.2:2],'YTickLabel',[0:2:20]); 
    end
    %set(a(k+4),'AmbientLightColor',backcolor,'XColor',[0.9 0.9 0.9],'YColor',[0.9 0.9 0.9]);
end

plot(a(1),t,f(1,1:last_time),'LineWidth',1.5);
plot(a(2),t,f(2,1:last_time),'g','LineWidth',1.5);
plot(a(3),t,f(3,1:last_time),'r','LineWidth',1.5);
plot(a(4),t,f(4,1:last_time),'b','LineWidth',1.5);
yD =0;

hold on
for k = 1:4
  set(a(k),'XGrid','on','YGrid','on','GridColor',[1 1 1],'Color', [0 0 0],'GridAlpha',0.25);
  set(a(k),'AmbientLightColor',backcolor,'XColor',[1 1 1],'YColor',[1 1 1],'TickDir','in','Box','off');
  set(a(k),'XLim',[0 last_time],'YLim',1.2*get(a(k),'YLim'));
  ver_pointer(k) = line([curr_pos curr_pos],ylim(a(k)),'Color',[1 1 0],'Parent',a(k),'LineWidth',1);
  hor_pointer(k) = line([curr_pos-p_width curr_pos+p_width],[f(k,curr_pos) f(k,curr_pos)],'Color',[1 1 0],'Parent',a(k),'LineWidth',1);
  
  if(k<4)
      set(a(k),'XTickLabel',{});
  end 
end
hold off

setappdata(main,'vpoint',ver_pointer);
setappdata(main,'hpoint',hor_pointer);
setappdata(main,'data',f);
setappdata(main,'graphs',a);

function keycallback(source,eventData)
keypressed = eventData.Key;
curr_pos = getappdata(source,'pos');
delta= getappdata(source,'del');
last_time = getappdata(source,'lt');
if strcmpi(keypressed,'rightarrow')
    if (curr_pos+delta<=last_time)
        curr_pos = curr_pos+delta;
        update_pointer(curr_pos,source);
        setappdata(source,'pos',curr_pos);
    end
end
if strcmpi(keypressed,'leftarrow')
    if(curr_pos-delta>0)
        curr_pos = curr_pos-delta;
        update_pointer(curr_pos,source);
        setappdata(source,'pos',curr_pos);
    end
end
end

function update_pointer(pos,main)
ver_pointer = getappdata(main,'vpoint');
hor_pointer = getappdata(main,'hpoint');
p_width = getappdata(main,'wd');
f = getappdata(main,'data');
for k = 1:4
    set(ver_pointer(k),'XData',[pos pos]);
    set(hor_pointer(k),'XData',[pos-p_width pos+p_width],'YData',[f(k,pos) f(k,pos)]);
end
end

