if number_of_farfield_frequencies == 0
    return;
end
c	  = 2.99792458e+8;   	% speed of light in free space
mu_0  = 4 * pi * 1e-7;      % permeability of free space
eps_0 = 1.0/(c*c*mu_0); 	% permittivity of free space
eta_0 = sqrt(mu_0/eps_0);   % intrinsic impedance of free space

exp_jk_rpr = zeros(number_of_angles,1);
dx_sinth_cosphi = zeros(number_of_angles,1);
dy_sinth_sinphi = zeros(number_of_angles,1);
dz_costh = zeros(number_of_angles,1);
dy_dz_costh_sinphi = zeros(number_of_angles,1);
dy_dz_sinth = zeros(number_of_angles,1);
dy_dz_cosphi = zeros(number_of_angles,1);
dx_dz_costh_cosphi = zeros(number_of_angles,1);
dx_dz_sinth = zeros(number_of_angles,1);
dx_dz_sinphi = zeros(number_of_angles,1);
dx_dy_costh_cosphi = zeros(number_of_angles,1);
dx_dy_costh_sinphi = zeros(number_of_angles,1);
dx_dy_sinphi = zeros(number_of_angles,1);
dx_dy_cosphi = zeros(number_of_angles,1);
farfield_dataTheta = zeros(number_of_farfield_frequencies,number_of_angles);
farfield_dir = zeros(number_of_farfield_frequencies,number_of_angles);
farfield_dataPhi = zeros(number_of_farfield_frequencies,number_of_angles);

dx_sinth_cosphi = dx*sin(farfield_theta).*cos(farfield_phi);
dy_sinth_sinphi = dy*sin(farfield_theta).*sin(farfield_phi);
dz_costh = dz*cos(farfield_theta);
dy_dz_costh_sinphi = dy*dz*cos(farfield_theta).*sin(farfield_phi);
dy_dz_sinth = dy*dz*sin(farfield_theta);
dy_dz_cosphi = dy*dz*cos(farfield_phi);
dx_dz_costh_cosphi = dx*dz*cos(farfield_theta).*cos(farfield_phi);
dx_dz_sinth = dx*dz*sin(farfield_theta);
dx_dz_sinphi = dx*dz*sin(farfield_phi);
dx_dy_costh_cosphi = dx*dy*cos(farfield_theta).*cos(farfield_phi);
dx_dy_costh_sinphi = dx*dy*cos(farfield_theta).*sin(farfield_phi);
dx_dy_sinphi = dx*dy*sin(farfield_phi);
dx_dy_cosphi = dx*dy*cos(farfield_phi);
ci = 0.5*(ui+li);
cj = 0.5*(uj+lj);
ck = 0.5*(uk+lk);

% calculate directivity
for mi=1:number_of_farfield_frequencies
    disp(['Calculating farfields for ' , ...
        num2str(farfield.frequencies(mi)) ' Hz']);
    k = 2*pi*farfield.frequencies(mi)*(mu_0*eps_0)^0.5;

    Ntheta = zeros(number_of_angles,1);
    Ltheta = zeros(number_of_angles,1);
    Nphi = zeros(number_of_angles,1);
    Lphi = zeros(number_of_angles,1);
    rpr = zeros(number_of_angles,1);

for nj = lj:uj-1
    for nk =lk:uk-1
    % for +ax direction

    rpr = (ui - ci)*dx_sinth_cosphi ...
        + (nj-cj+0.5)*dy_sinth_sinphi ...
        + (nk-ck+0.5)*dz_costh;
    exp_jk_rpr = exp(j*k*rpr);
    Ntheta = Ntheta + (cjyxp(mi,1,nj-lj+1,nk-lk+1).*dy_dz_costh_sinphi ...
        - cjzxp(mi,1,nj-lj+1,nk-lk+1).*dy_dz_sinth).*exp_jk_rpr;
    Ltheta = Ltheta + (cmyxp(mi,1,nj-lj+1,nk-lk+1).*dy_dz_costh_sinphi ...
        - cmzxp(mi,1,nj-lj+1,nk-lk+1).*dy_dz_sinth).*exp_jk_rpr;
    Nphi = Nphi + (cjyxp(mi,1,nj-lj+1,nk-lk+1).*dy_dz_cosphi).*exp_jk_rpr;
    Lphi = Lphi + (cmyxp(mi,1,nj-lj+1,nk-lk+1).*dy_dz_cosphi).*exp_jk_rpr;

    % for -ax direction
    rpr = (li - ci)*dx_sinth_cosphi ...
        + (nj-cj+0.5)*dy_sinth_sinphi ...
        + (nk-ck+0.5)*dz_costh;
    exp_jk_rpr = exp(j*k*rpr);
    Ntheta = Ntheta + (cjyxn(mi,1,nj-lj+1,nk-lk+1).*dy_dz_costh_sinphi ...
        - cjzxn(mi,1,nj-lj+1,nk-lk+1).*dy_dz_sinth).*exp_jk_rpr;
    Ltheta = Ltheta + (cmyxn(mi,1,nj-lj+1,nk-lk+1).*dy_dz_costh_sinphi ...
        - cmzxn(mi,1,nj-lj+1,nk-lk+1).*dy_dz_sinth).*exp_jk_rpr;
    Nphi = Nphi + (cjyxn(mi,1,nj-lj+1,nk-lk+1).*dy_dz_cosphi).*exp_jk_rpr;
    Lphi = Lphi + (cmyxn(mi,1,nj-lj+1,nk-lk+1).*dy_dz_cosphi).*exp_jk_rpr;
    end
end
for ni =li:ui-1
    for nk =lk:uk-1
        % for +ay direction

    rpr = (ni - ci + 0.5)*dx_sinth_cosphi ...
        + (uj-cj)*dy_sinth_sinphi ...
        + (nk-ck+0.5)*dz_costh;
    exp_jk_rpr = exp(j*k*rpr);

    Ntheta = Ntheta + (cjxyp(mi,ni-li+1,1,nk-lk+1).*dx_dz_costh_cosphi ...
        - cjzyp(mi,ni-li+1,1,nk-lk+1).*dx_dz_sinth).*exp_jk_rpr;
    Ltheta = Ltheta + (cmxyp(mi,ni-li+1,1,nk-lk+1).*dx_dz_costh_cosphi ...
        - cmzyp(mi,ni-li+1,1,nk-lk+1).*dx_dz_sinth).*exp_jk_rpr;
    Nphi = Nphi + (-cjxyp(mi,ni-li+1,1,nk-lk+1).*dx_dz_sinphi).*exp_jk_rpr;
    Lphi = Lphi + (-cmxyp(mi,ni-li+1,1,nk-lk+1).*dx_dz_sinphi).*exp_jk_rpr;

    % for -ay direction
    rpr = (ni - ci + 0.5)*dx_sinth_cosphi ...
        + (lj-cj)*dy_sinth_sinphi ...
        + (nk-ck+0.5)*dz_costh;
    exp_jk_rpr = exp(j*k*rpr);

    Ntheta = Ntheta + (cjxyn(mi,ni-li+1,1,nk-lk+1).*dx_dz_costh_cosphi ...
        - cjzyn(mi,ni-li+1,1,nk-lk+1).*dx_dz_sinth).*exp_jk_rpr;
    Ltheta = Ltheta + (cmxyn(mi,ni-li+1,1,nk-lk+1).*dx_dz_costh_cosphi ...
        - cmzyn(mi,ni-li+1,1,nk-lk+1).*dx_dz_sinth).*exp_jk_rpr;
    Nphi = Nphi + (-cjxyn(mi,ni-li+1,1,nk-lk+1).*dx_dz_sinphi).*exp_jk_rpr;
    Lphi = Lphi + (-cmxyn(mi,ni-li+1,1,nk-lk+1).*dx_dz_sinphi).*exp_jk_rpr;
    end
end

for ni =li:ui-1
    for nj =lj:uj-1
    % for +az direction

    rpr = (ni-ci+0.5)*dx_sinth_cosphi ...
        + (nj - cj + 0.5)*dy_sinth_sinphi ...
        + (uk-ck)*dz_costh;
    exp_jk_rpr = exp(j*k*rpr);

    Ntheta = Ntheta + (cjxzp(mi,ni-li+1,nj-lj+1,1).*dx_dy_costh_cosphi ...
        + cjyzp(mi,ni-li+1,nj-lj+1,1).*dx_dy_costh_sinphi).*exp_jk_rpr;
    Ltheta = Ltheta + (cmxzp(mi,ni-li+1,nj-lj+1,1).*dx_dy_costh_cosphi ...
        + cmyzp(mi,ni-li+1,nj-lj+1,1).*dx_dy_costh_sinphi).*exp_jk_rpr;
    Nphi = Nphi + (-cjxzp(mi,ni-li+1,nj-lj+1,1) ...
    .*dx_dy_sinphi+cjyzp(mi,ni-li+1,nj-lj+1,1).*dx_dy_cosphi).*exp_jk_rpr;
    Lphi = Lphi + (-cmxzp(mi,ni-li+1,nj-lj+1,1) ...
    .*dx_dy_sinphi+cmyzp(mi,ni-li+1,nj-lj+1,1).*dx_dy_cosphi).*exp_jk_rpr;

    % for -az direction

    rpr = (ni-ci+0.5)*dx_sinth_cosphi ...
        + (nj - cj + 0.5)*dy_sinth_sinphi ...
        + (lk-ck)*dz_costh;
    exp_jk_rpr = exp(j*k*rpr);

    Ntheta = Ntheta + (cjxzn(mi,ni-li+1,nj-lj+1,1).*dx_dy_costh_cosphi ...
        + cjyzn(mi,ni-li+1,nj-lj+1,1).*dx_dy_costh_sinphi).*exp_jk_rpr;
    Ltheta = Ltheta + (cmxzn(mi,ni-li+1,nj-lj+1,1).*dx_dy_costh_cosphi ...
        + cmyzn(mi,ni-li+1,nj-lj+1,1).*dx_dy_costh_sinphi).*exp_jk_rpr;
    Nphi = Nphi + (-cjxzn(mi,ni-li+1,nj-lj+1,1) ... 
    .*dx_dy_sinphi+cjyzn(mi,ni-li+1,nj-lj+1,1).*dx_dy_cosphi).*exp_jk_rpr;
    Lphi = Lphi + (-cmxzn(mi,ni-li+1,nj-lj+1,1) ...
    .*dx_dy_sinphi+cmyzn(mi,ni-li+1,nj-lj+1,1).*dx_dy_cosphi).*exp_jk_rpr;
    end
end

    if incident_plane_wave.enable == false
        % calculate directivity
        farfield_dataTheta(mi,:)=(k^2./(8*pi*eta_0*radiated_power(mi))) ...
            .* (abs(Lphi+eta_0*Ntheta).^2);
        farfield_dataPhi(mi,:)  =(k^2./(8*pi*eta_0*radiated_power(mi))) ...
            .* (abs(Ltheta-eta_0*Nphi).^2);
    else
        % calculate radar cross-section
        farfield_dataTheta(mi,:)  = ...
            (k^2./(8*pi*eta_0*incident_plane_wave.incident_power(mi))) ...
            .* (abs(Lphi+eta_0*Ntheta).^2);
        farfield_dataPhi(mi,:)    = ...
            (k^2./(8*pi*eta_0*incident_plane_wave.incident_power(mi))) ...
            .* (abs(Ltheta-eta_0*Nphi).^2);
    end
end  
