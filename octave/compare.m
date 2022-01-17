%
% Compare ceiling, floor and int conversion functions
%

x = 0.01:0.01:9.9; %simulate ratios

function [v] = f(r)
  if r >= 1
    v = 1;
  else
    v = -1;
  endif
endfunction

function [RC] = Conversion(x, type = 'C')
  RC = [];
  
  for i=1:length(x)
       
    s = x(i)^f(x(i));
    
    if strcmp(type, 'C')
      s = ceil(s);
    elseif strcmp(type, 'F')
      s = floor(s);
    elseif strcmp(type, 'I')
      s = round(s);
    endif
    
    l = s;
    if s < 1
      l = 1;
    elseif s > 9
      l = 9;
    endif
    
    R = l^f(x(i));
       
    RC = [RC R];
    
  endfor
  
endfunction

% Ceiling function
C = Conversion(x, 'C');

% Flor function
F = Conversion(x, 'F');

% Int function
I = Conversion(x, 'I');

xtk = 0:0.5:9.99;
ytk = 0:1:10;

figure(1,"position", get(0,"screensize"));

subplot(311);
plot(x, C, 'r', "linewidth", 2);
title('(a)', "fontsize", 14);
grid 'on';
xlabel('Ratio');
ylabel('Converted ratio');
h = get(gcf, "currentaxes");
set(h, "fontsize", 14, "linewidth", 1.5);
xticks(xtk);
yticks(ytk);

subplot(312);
plot(x, F, 'r', "linewidth", 2);
title('(b)', "fontsize", 14);
grid 'on';
xlabel('Ratio');
ylabel('Converted ratio');
h = get(gcf, "currentaxes");
set(h, "fontsize", 14, "linewidth", 1.5);
xticks(xtk);
yticks(ytk);

subplot(313);
plot(x, I, 'r', "linewidth", 2);
title('(c)', "fontsize", 14);
grid 'on';
xlabel('Ratio');
ylabel('Converted ratio');
h = get(gcf, "currentaxes");
set(h, "fontsize", 14, "linewidth", 1.5);
xticks(xtk);
yticks(ytk);

print('compare.png','-dpng','-r400');

