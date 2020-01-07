
m = figure('NumberTitle','off');
backcolor = [0 0 0];
a = axes(m);
Y = [0.5 0.5];
ax = area(a,Y);
setappdata(m,'pos',ax);
set(a,'Color',backcolor,'TickDir','in','Box','off','XTickLabel',{},'YTickLabel',{},'Ylim',[0 2]);
set(a,'Position',[0.75 0.25 0.1 0.5]); %if gca is replace by ax it wont work.

set(m,'WindowKeyPressFcn',@keycallback);
function keycallback(source,eventData)
ax = getappdata(source,'pos');
keypressed = eventData.Key;
if strcmpi(keypressed,'leftarrow')
set(ax,'YData',[2 2]);
end
end