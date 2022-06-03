% Calculate incident plane wave power
radiated_power = zeros(number_of_farfield_frequencies,1);

for mi=1:number_of_farfield_frequencies
    powr = 0;
    powr = dx*dy* sum(sum(sum(cmyzp(mi,:,:,:).* conj(cjxzp(mi,:,:,:)) ...
    - cmxzp(mi,:,:,:) .* conj(cjyzp(mi,:,:,:)))));
    powr = powr - dx*dy* sum(sum(sum(cmyzn(mi,:,:,:) ...
    .* conj(cjxzn(mi,:,:,:)) - cmxzn(mi,:,:,:) .* conj(cjyzn(mi,:,:,:)))));
    powr = powr + dx*dz* sum(sum(sum(cmxyp(mi,:,:,:) ...
    .* conj(cjzyp(mi,:,:,:)) - cmzyp(mi,:,:,:) .* conj(cjxyp(mi,:,:,:)))));
    powr = powr - dx*dz* sum(sum(sum(cmxyn(mi,:,:,:) ...
    .* conj(cjzyn(mi,:,:,:)) - cmzyn(mi,:,:,:) .* conj(cjxyn(mi,:,:,:)))));
    powr = powr + dy*dz* sum(sum(sum(cmzxp(mi,:,:,:) ...
    .* conj(cjyxp(mi,:,:,:)) - cmyxp(mi,:,:,:) .* conj(cjzxp(mi,:,:,:)))));
    powr = powr - dy*dz* sum(sum(sum(cmzxn(mi,:,:,:) ...
    .* conj(cjyxn(mi,:,:,:)) - cmyxn(mi,:,:,:) .* conj(cjzxn(mi,:,:,:)))));
    radiated_power(mi) = 0.5 * real(powr);
end