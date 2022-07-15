%
% ANALYTIC HIERARCHY PROCESS FOR TABULAR DATA
%

%Amplitude transformation
Tamp = @(x, tau) x + abs(min(x)) + tau;

%Normalization functions
LMP = @(x) x ./ sum(abs(x));
SMP = @(x) 1 ./ (x * sum( 1 ./ abs(x) ));

%Gets the weight of the criteria
function [u] = CriterionWeight(V)
  avgV = mean(V);
  N    = size(V)(1);
  u    = [];
  for m = 1:size(V)(2)
    u = [u (1/N) * sum(abs(V(:,m) - avgV(m)))];
  endfor
  u = u/sum(u);
endfunction

% Conversion functions
function [v] = f(r)
  if r > 1
    v = 1;
  else
    v = -1;
  endif
endfunction

function [C] = Conversion(V, type = 'C')
  N = size(V)(2);
  C = eye(N);

  for i = 1:N - 1

    for j = i + 1:N

      r = V(i) / V(j);
      s = r^f(r);

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

      C(i,j) = l^f(r);
      C(j,i) = 1/l^f(r);

    endfor
  endfor
endfunction

%Eigendecomposition and normalization
function [l, w, rc] = LPV(A)
  %Principal eigenvalue and eigenvector
  [w, l]   = eig(A);
  l        = sum(l);
  [~, idx] = max(l);
  l        = l(idx);
  w        = w(:,idx);
  w        = w/sum(w);
  w        = w';

  %Consistency ratio
  n = size(A)(1);
  ri = [0 0 0.58 0.9 1.12 1.24 1.32 1.41 1.45 1.49 1.51];
  ci = (l - n) / (n - 1);
  rc = ci / ri(n);
endfunction

function [x] = GPV(u, V)
  x = u * V';
endfunction

%Original values
C1 = [4000 9330 10660];
C2 = [11 26 30];
C3 = [30 25 35];
C4 = [25 25 120];
C5 = [1 2 2];
C7 = [290000000 310000000 310000000];
C8 = [592000000 633000000 633000000];
C9 = [6 8 8];

%Normalize values
C1_ = LMP(C1);
C2_ = LMP(C2);
C3_ = LMP(C3);
C4_ = LMP(C4);
C5_ = LMP(C5);
C7_ = SMP(C7);
C8_ = SMP(C8);
C9_ = SMP(C9);

w_C1 = [];
w_C2 = [];
w_C3 = [];
w_C4 = [];
w_C5 = [];
w_C6 = [];
w_C7 = [];
w_C8 = [];
w_C9 = [];

for TAU = 0.01:100

  C6 = [0 1 1] + TAU; %Considering tau
  C6_ = LMP(C6);

  %Normalized data matrix
  G = [C1_; C2_; C3_; C4_; C5_; C6_; C7_; C8_; C9_]';

  %Criterion weight (automated approach)
  u = CriterionWeight(G);

  %Criterion weight (semi-automated approach)
  A  = Conversion(u, type);
  [l_A, u_, rc_A] = LPV(A);

  w_C1 = [w_C1 u_(1)];
  w_C2 = [w_C2 u_(2)];
  w_C3 = [w_C3 u_(3)];
  w_C4 = [w_C4 u_(4)];
  w_C5 = [w_C5 u_(5)];
  w_C6 = [w_C6 u_(6)];
  w_C7 = [w_C7 u_(7)];
  w_C8 = [w_C8 u_(8)];
  w_C9 = [w_C9 u_(9)];

endfor

tau = 0.01:100;

figure();

hold 'on';
plot(tau, w_C1, "linewidth", 2);
plot(tau, w_C2, "linewidth", 2);
plot(tau, w_C3, "linewidth", 2);
plot(tau, w_C4, "linewidth", 2);
plot(tau, w_C5, "linewidth", 2);
plot(tau, w_C6, 'k', "linewidth", 2.5);
plot(tau, w_C7, "linewidth", 2);
plot(tau, w_C8, "linewidth", 2);
plot(tau, w_C9, "linewidth", 2);
grid 'on';
xlabel("\\tau");
ylabel('Criterion weight');
h = get(gcf, "currentaxes");
set(h, "fontsize", 14, "linewidth", 1.5);
legend({'C1','C2','C3','C4','C5','C6','C7','C8','C9'});

print('compare_cw.png','-dpng','-r300');
