% update electric fields except the tangential components
% on the boundaries 

current_time  = current_time + dt/2;

Ex(1:nx,2:ny,2:nz) = Cexe(1:nx,2:ny,2:nz).*Ex(1:nx,2:ny,2:nz) ...
                     + Cexhz(1:nx,2:ny,2:nz).*...
                     (Hz(1:nx,2:ny,2:nz)-Hz(1:nx,1:ny-1,2:nz)) ...
                     + Cexhy(1:nx,2:ny,2:nz).*...
                     (Hy(1:nx,2:ny,2:nz)-Hy(1:nx,2:ny,1:nz-1));   
                  
Ey(2:nx,1:ny,2:nz)=Ceye(2:nx,1:ny,2:nz).*Ey(2:nx,1:ny,2:nz) ...
                      + Ceyhx(2:nx,1:ny,2:nz).*  ...
                      (Hx(2:nx,1:ny,2:nz)-Hx(2:nx,1:ny,1:nz-1)) ...
                      + Ceyhz(2:nx,1:ny,2:nz).*  ...
                      (Hz(2:nx,1:ny,2:nz)-Hz(1:nx-1,1:ny,2:nz)); 
               
Ez(2:nx,2:ny,1:nz)=Ceze(2:nx,2:ny,1:nz).*Ez(2:nx,2:ny,1:nz) ...
                      + Cezhy(2:nx,2:ny,1:nz).*  ...
                      (Hy(2:nx,2:ny,1:nz)-Hy(1:nx-1,2:ny,1:nz)) ...
                      + Cezhx(2:nx,2:ny,1:nz).*...
                      (Hx(2:nx,2:ny,1:nz)-Hx(2:nx,1:ny-1,1:nz));

if incident_plane_wave.enable
   xui = incident_plane_wave.ui;
   xuj = incident_plane_wave.uj;
   xuk = incident_plane_wave.uk;
   xli = incident_plane_wave.li;
   xlj = incident_plane_wave.lj;
   xlk = incident_plane_wave.lk;
   
    % Ex_yn
        Ex(xli:xui-1,xlj,xlk:xuk) = ...
        Ex(xli:xui-1,xlj,xlk:xuk) - dt/(eps_0*dy) * Hzi_yn(:,1,:);
	% Ex_yp
        Ex(xli:xui-1,xuj,xlk:xuk) = ... 
        Ex(xli:xui-1,xuj,xlk:xuk) + dt/(eps_0*dy) * Hzi_yp(:,1,:);
	% Ex_zn
        Ex(xli:xui-1,xlj:xuj,xlk) = ...
        Ex(xli:xui-1,xlj:xuj,xlk) + dt/(eps_0*dz) * Hyi_zn(:,:,1); 
	% Ex_zp
        Ex(xli:xui-1,xlj:xuj,xuk) = ...
        Ex(xli:xui-1,xlj:xuj,xuk) - dt/(eps_0*dz) * Hyi_zp(:,:,1); 

	% Ey_xn
        Ey(xli,xlj:xuj-1,xlk:xuk) = ...
        Ey(xli,xlj:xuj-1,xlk:xuk) + dt/(eps_0*dx) * Hzi_xn(1,:,:);
	% Ey_xp
        Ey(xui,xlj:xuj-1,xlk:xuk) = ...
        Ey(xui,xlj:xuj-1,xlk:xuk) - dt/(eps_0*dx) * Hzi_xp(1,:,:);
	% Ey_zn
        Ey(xli:xui,xlj:xuj-1,xlk) = ... 
        Ey(xli:xui,xlj:xuj-1,xlk) - dt/(eps_0*dz) * Hxi_zn(:,:,1);
	% Ey_zp
        Ey(xli:xui,xlj:xuj-1,xuk) = ...
        Ey(xli:xui,xlj:xuj-1,xuk) + dt/(eps_0*dz) * Hxi_zp(:,:,1);                             

	% Ez_xn
        Ez(xli,xlj:xuj,xlk:xuk-1) = ... 
        Ez(xli,xlj:xuj,xlk:xuk-1) - dt/(eps_0*dx) * Hyi_xn(1,:,:);
	% Ez_xp
        Ez(xui,xlj:xuj,xlk:xuk-1) = ...
        Ez(xui,xlj:xuj,xlk:xuk-1) + dt/(eps_0*dx) * Hyi_xp(1,:,:);
	% Ez_yn
        Ez(xli:xui,xlj,xlk:xuk-1) = ... 
        Ez(xli:xui,xlj,xlk:xuk-1) + dt/(eps_0*dy) * Hxi_yn(:,1,:);
	% Ez_yp
        Ez(xli:xui,xuj,xlk:xuk-1) = ...
        Ez(xli:xui,xuj,xlk:xuk-1) - dt/(eps_0*dy) * Hxi_yp(:,1,:);
end 
