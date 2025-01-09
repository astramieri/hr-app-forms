--alter table locations drop column latitude;
--alter table locations drop column longitude;

--alter table locations add latitude  number;
--alter table locations add longitude number;

update locations
   set latitude  = +32.94169852186318, 
       longitude = -97.13169565552413
  where location_id = 1400;  

update locations
   set latitude  = +37.76898304102118, 
       longitude = -122.38795794142843
  where location_id = 1500;    
  
update locations
   set latitude  = +47.61646622209697, 
       longitude = -122.33500204591456
  where location_id = 1700; 

update locations
   set latitude  = +43.648299680063246,
       longitude = -79.39575967596018
  where location_id = 1800; 
  
update locations
   set latitude  = +51.51741820007294,
       longitude = -0.13182088860304186
  where location_id = 2400; 
  
update locations
   set latitude  = 51.71647862046083,
       longitude = -1.2163296399371777
  where location_id = 2500; 
  
update locations
   set latitude  = 48.137733706017066,
       longitude = 11.5527297549143
  where location_id = 2700; 

commit;