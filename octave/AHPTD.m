#### ANALYTIC HIERARCHY PROCESS FOR TABULAR DATA (AHPTD)## Author: Bruno Rodrigues de Oliveira <bruno@editorapantanal.com.br>## ORCID: https://orcid.org/0000-0002-1037-6541## Version: 1## Example:##%Instance the AHPTD##ahptd_obj = AHPTD()##%Original values##Cri1 = [200 300 500];##Cri2 = [150 50 100];##Cri3 = [3000 2000 5500];##Cri4 = [1 2 3];##%Normalize values##Price_   = ahptd_obj.SMP(Price);##Size_    = ahptd_obj.LMP(Size);##Renewal_ = ahptd_obj.SMP(Renewal);##Style_   = ahptd_obj.LMP(Style);####%Normalized data matrix##V = [Price_; Size_ ; Renewal_; Style_]';####%Criteria weight##u = ahptd_obj.CriterionWeight(V);####%Get the PC matrix of criteria##A          = ahptd_obj.Conversion(u);##[l, u, cr] = ahptd_obj.LPV(A);####%Get the PC matrix of alternatives##A_Price   = ahptd_obj.Conversion(Price_);##A_Size    = ahptd_obj.Conversion(Size_);##A_Renewal = ahptd_obj.Conversion(Renewal_);##A_Style   = ahptd_obj.Conversion(Style_);####%Get the Local priority vector##[l_Price, v_Price, cr_Price]       = ahptd_obj.LPV(A_Price);##[l_Size, v_Size, cr_Size]          = ahptd_obj.LPV(A_Size);##[l_Renewal, v_Renewal, cr_Renewal] = ahptd_obj.LPV(A_Renewal);##[l_Style, v_Style, cr_Style]       = ahptd_obj.LPV(A_Style);####%Get the Global priority vector##V = [v_Price; v_Size; v_Renewal; v_Style]';##x = ahptd_obj.GPV(u, V)classdef AHPTD    properties    type_conversion;  endproperties     methods      %Constructor    function obj = AHPTD(type_conversion = 'C')      obj.type_conversion = type_conversion;    endfunction
        %Amplitude transformation    function y = Tamp(obj, x, tau = 0.01)      y = x + abs(min(x)) + tau;      endfunction        %Normalization function    function y = LMP(obj, x)      y = x ./ sum(abs(x));
    endfunction        %Normalization function    function y = SMP(obj, x)      y = 1 ./ (x * sum( 1 ./ abs(x) ));    endfunction
        %Gets the weight of the criteria    function [u] = CriterionWeight(obj, V)      avgV = mean(V);      N    = size(V)(1);      u    = [];      for m = 1:size(V)(2)        u = [u (1/N) * sum(abs(V(:,m) - avgV(m)))];      endfor      u = u/sum(u);    endfunction        function [C] = Conversion(obj, V)      N = size(V)(2);      C = eye(N);            for i = 1:N - 1                for j = i + 1:N                          r = V(i) / V(j);          s = r^obj.f(r);                          if strcmp(obj.type_conversion, 'C')            s = ceil(s);          elseif strcmp(obj.type_conversion, 'F')            s = floor(s);          elseif strcmp(obj.type_conversion, 'I')            s = round(s);          endif                  l = s;          if s < 1            l = 1;          elseif s > 9            l = 9;          endif                    C(i,j) = l^obj.f(r);          C(j,i) = 1/l^obj.f(r);                  endfor      endfor    endfunction    %Local pripority vector    function [l, w, cr] = LPV(obj, A)      %Principal eigenvalue and eigenvector      [w, l]   = eig(A);      l        = sum(l);      [~, idx] = max(l);      l        = l(idx);      w        = w(:,idx);      w        = w/sum(w);      w        = w';            %Consistency ratio      n = size(A)(1);      ri = [0 0 0.52 0.89 1.11 1.25 1.35 1.40 1.45 1.49 1.52 1.54 1.56 1.58 1.59];      ci = (l - n) / (n - 1);      cr = ci / ri(n);    endfunction    %Global pripority vector    function [x] = GPV(obj, u, V)      x = u * V';    endfunction      endmethods    methods (Access = 'private')        % Conversion functions    function [v] = f(obj, r)      if r > 1        v = 1;      else        v = -1;      endif    endfunction      endmethods
  endclassdef