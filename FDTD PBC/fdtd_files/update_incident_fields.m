% update incident fields for the current time step
if incident_plane_wave.enable == false
    return;
end
 

Exi_yn = Exi0;
Exi_yp = Exi0;
Exi_zn = Exi0;
Exi_zp = Exi0;

Eyi_zn = Eyi0;
Eyi_zp = Eyi0;
Eyi_xn = Eyi0;
Eyi_xp = Eyi0;

Ezi_xn = Ezi0;
Ezi_xp = Ezi0;
Ezi_yn = Ezi0;
Ezi_yp = Ezi0;

Hxi_yn = Hxi0;
Hxi_yp = Hxi0;
Hxi_zn = Hxi0;
Hxi_zp = Hxi0;

Hyi_zn = Hyi0;
Hyi_zp = Hyi0;
Hyi_xn = Hyi0;
Hyi_xp = Hyi0;

Hzi_xn = Hzi0;
Hzi_xp = Hzi0;
Hzi_yn = Hzi0; 
Hzi_yp = Hzi0;