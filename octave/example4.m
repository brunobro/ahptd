% Random matrices for verify consistent ratio
% when using convertion function for obtain criterion weight

clear all;
clc;

pkg load statistics;

%Type of conversion
type = 'C';

%Instance the AHPTD
ahptd_obj = AHPTD(type);

%Values of consistent ratio for executions
CR_all_results = [];

%Count inconsistency
inconsistency = 0;

%Count consistency
consistent    = 0;

for i = 1:1:1000

  %Values of consistent ratio for alternatives
  CR_results = [];

  %m: simulate number of alternatives
  % m >= 3, since all 2x2 matrix is consistent
  for m = 3:1:15

    %Generate a random vector and normalize
    values = rand(m);
    values = values/norm(values, 1);

    %Apply convertion function
    A          = ahptd_obj.Conversion(values);
    [l, u, cr] = ahptd_obj.LPV(A);

    %For NaN values
    %if isnan(cr)
    %  cr = 0;
    %endif

    %Store results
    CR_results = [CR_results cr];

    %Count consistency/inconsistency
    if cr > 0.1
      inconsistency = inconsistency + 1;
    else
      consistent = consistent + 1;
    endif

  endfor

  %Store results
  CR_all_results = [CR_all_results; CR_results];

endfor

%Plot results
hf = figure(1);
boxplot(CR_all_results);
set(gca,'xtick', [1:13]);
set(gca,'XTickLabel', linspace(3, 15, 13));
xlabel('Matrix dimension');
ylabel('Consistency ratio');
hold 'on';
plot(0.1 * ones(13), '--', 'color', 'green', 'linewidth', 1.5);
grid 'on';

%Save results
save cr_results.mat CR_all_results;
print(hf, 'consistency_ratios.png', '-dpng', '-r300');
