disp('defining sources'); 

% Define incident plane wave, angles are in degrees

incident_plane_wave.enable = true;
incident_plane_wave.E_theta = 0;
incident_plane_wave.E_phi = 1;
incident_plane_wave.theta_incident = 90;
incident_plane_wave.phi_incident = 0;

incident_plane_wave.waveform_type = 'sinusoidal';
incident_plane_wave.number_of_cells_per_wavelength = 20;

current_object.waveform = incident_plane_wave.waveform_type;
current_object.phase = 0;