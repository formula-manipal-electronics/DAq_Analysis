m = figure();
set(m,'Color',[0 0 0]);
buttons = uicontrol(m,'Style','pushbutton','String','Close','Position',[350 300 200 200]);
set(buttons,'BackgroundColor',[0.1 0.1 0.1],'ForegroundColor',[1 0 0],'FontWeight','bold');
JEdit = java(findjobj(buttons));
JEdit.FlyOverAppearance = true;