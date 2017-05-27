function [ratio] = fun_relativeRatio(a)
    mmax = max(a);
    mmin = min(a);
    ratio = [];
    for i = 1:1:numel(a)
        ratio = [ratio, (a(i)-mmin)/(mmax-mmin)];
    end
end