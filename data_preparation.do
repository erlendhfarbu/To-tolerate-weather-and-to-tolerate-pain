********************** importerer vaerdata*********
clear
import delimited "C:\Users\efa036\OneDrive - UiT Office 365\Statpaper3\weather19902020.txt", delimiter(space, collapse) varnames(35) encoding(UTF-8)

*** drops descriptives and unnecessary variables

drop in 11069/11078
drop v1 v22

destring ffm pom pon pox prm prn prx rr sa sd tam tan tax td um un ux, replace force

*creating date variable
gen date=date(dato, "DMY")
format date %td

list date dato

sum date

tsset date

foreach var in ffm pom pon pox prm prn prx rr sa sd  tam tan tax td um un ux {
tssmooth ma ma7_`var'=`var', window( 3 1 3)
}

gen day=day(date)
gen month=month(date)

qui{
foreach var in ffm pom pon pox prm prn prx rr sa sd  tam tan tax td um un ux {
* the expected weather
gen exp_`var'=.
forvalues m=1(1)12 {
forvalues d=1(1)31 {
egen exp_`var'_`m'_`d' = mean(ma7_`var') if month==`m' & day==`d'
replace exp_`var'= exp_`var'_`m'_`d' if month==`m' & day==`d'
drop exp_`var'_`m'_`d'
}
}
}
}
* Difference between observed and expected
foreach var in ffm pom pon pox prm prn prx rr sa sd  tam tan tax td um un ux {
gen a_`var'= `var'- exp_`var'
}

rename date pt_date_t7
* first date is 10958 last is 22025

merge m:m pt_date_t7 using "C:\Users\efa036\OneDrive - UiT Office 365\Statpaper3\ut_Sep2020.dta"
rename pt_date_t7 date
save "C:\Users\efa036\OneDrive - UiT Office 365\Statpaper3\datasett.dta", replace


use  "C:\Users\efa036\OneDrive - UiT Office 365\Statpaper3\datasett.dta", clear
gen id=_n


****** PPT ****************
bys id: gen ppt = (pt_rp2_kpa_tol_t7+pt_rp3_kpa_tol_t7)/2
replace ppt=pt_rp2_kpa_tol_t7 if pt_rp3_kpa_tol_t7==.
replace ppt=pt_rp3_kpa_tol_t7 if pt_rp2_kpa_tol_t7==.

hist ppt

bys date: egen ppt_median = median(ppt)
bys date: egen ppt_mean = mean(ppt)
bys date: gen over55=1 if ppt>=55 & ppt!=.
bys date: egen n_over55= count(over55)
bys date: egen n_ppt_day= count(ppt)
bys date: gen propover55=n_over55/n_ppt_day
tw (line propover55 date, yaxis(2))(line ppt_median date)(line ppt_mean date) if date>=td(01jan2015) & date<=td(01dec2016)


********************** CPT *************
bys date: egen cpt_mean=mean(pt_cpt_sec_tol_t7)
bys date: egen cpt_median=median(pt_cpt_sec_tol_t7)
bys date: egen n_cpt_day=count(pt_cpt_sec_tol_t7)
gen over100=1 if pt_cpt_sec_tol_t7>=100 & pt_cpt_sec_tol_t7!=.
bys date: egen n_over100= count(over100)
bys date: gen propover100=n_over100/n_cpt_day

tw (line propover100 date, yaxis(2))(line cpt_mean date) if date>=td(01jan2015) & date<=td(01dec2016)
 

gen rad_day=.
replace rad_day=(date-20119)*2*_pi/365.25 if date>=td(01jan2015) & date<=td(01dec2016)
gen sin=sin(rad_day)
gen cos=cos(rad_day)

*************** Making the dataset to a time-series ***************
 drop if date<td(01jan2015) | date>td(01dec2016)
bys date: gen last=_n==_N
drop if last!=1

tsset date
** Dropping variables
qui {
drop year_born_t6 month_born_t6 age_t6 sex_t6 marital_status_t6 constituency_t6 municipality_born_t6 q2_imported_t6 attendance_time_t6 height_t6 weight_t6 waist_t6 hip_t6 comment_hip_waist_t6 health_t6 hypothyroid_t6 chronic_pain_t6 fear_t6 worried_t6 dizzy_t6 tense_t6 blame_yourself_t6 insomnia_t6 depressed_t6 useless_t6 struggle_t6 future_t6 thyroxine_t6 thyroxine_age_t6 painkillers_presc_4weeks_t6 painkillers_nopresc_4weeks_t6 education_t6 occupation_fulltime_t6 occupation_parttime_t6 occupation_unemployed_t6 occupation_housekeeping_t6 occupation_retired_t6 occupation_student_t6 pension_t6 sick_leave_t6 rehabilitation_t6 disability_pension_full_t6 disability_pension_partial_t6 unemployment_benefit_t6 transition_benefit_t6 social_welfare_t6 household_income_t6 household_income_average_t6 work_cold_t6 filled_out_date_work_reg_p3_t6 change_work_p3_t6 what_work_p3_t6 employees_work_p3_t6 management_work_p3_t6 kind_of_management_work_p3_t6 other_management_work_p3_t6 describe_profession_work_p3_t6 activities_place_work_p3_t6 profession_place_work_p3_t6 handheld_work_p3_t6 handheld_years_work_p3_t6 physical_activity_work_t6 phys_activity_leisure_t6 exercise_t6 exercise_level_t6 exercise_duration_t6 alcohol_frequency_t6 alcohol_units_t6 alcohol_6units_t6 smoke_sometimes_t6 smoke_daily_t6 smoke_stop_time_t6 cigarettes_number_t6 smoke_start_age_t6 smoke_years_t6 snuff_chewing_tobacco_t6 insomnia_freq_q2_t6 sleepless_no_particular_t6 sleepless_polar_night_t6 sleepless_midnightsun_t6 sleepless_spring_autumn_t6 neck_pain_3months_t6 arm_pain_3months_t6 upper_back_pain_3months_t6 lumbar_pain_3months_t6 hip_leg_pain_3months_t6 other_pain_3months_t6 neck_pain_4weeks_t6 arm_pain_4weeks_t6 upper_back_pain_4weeks_t6 lumbar_pain_4weeks_t6 hip_leg_pain_4weeks_t6 other_pain_4weeks_t6 headache_last_year_t6 pain_duration_years_t6 pain_duration_months_t6 pain_frequency_t6 pain_location_head_t6 pain_location_jaw_t6 pain_location_neck_t6 pain_location_back_t6 pain_location_shoulder_t6 pain_location_arm_t6 pain_location_hand_t6 pain_location_hip_t6 pain_location_leg_t6 pain_location_foot_t6 pain_location_chest_t6 pain_location_stomach_t6 pain_location_genital_t6 pain_location_skin_t6 pain_location_other_t6 pain_cause_trauma_t6 pain_cause_stress_t6 pain_cause_surgery_t6 pain_cause_disk_hernia_t6 pain_cause_whiplash_t6 pain_cause_headache_t6 pain_cause_arthrosis_t6 pain_cause_rheum_arthritis_t6 pain_cause_bechterew_t6 pain_cause_fibromyalgia_t6 pain_cause_angina_t6 pain_cause_ischemia_t6 pain_cause_cancer_t6 pain_cause_neuropathy_t6 pain_cause_infection_t6 pain_cause_herpes_zoster_t6 pain_cause_other_t6 pain_cause_unknown_t6 pain_cause_other_spec_t6 pain_treatment_none_t6 pain_treatment_medication_t6 pain_treatment_manual_t6 pain_treatment_pain_clinic_t6 pain_treatment_surgery_t6 pain_treatment_behavioral_t6 pain_treatment_acupuncture_t6 pain_treatment_cam_t6 pain_treatment_other_t6 pain_intensity_normal_t6 pain_intensity_maximal_t6 pain_influence_sleep_t6 pain_influence_adl_t6 cold_work_t6 cold_env_leisure_t6 cold_env_work_t6 cold_env_out_cloth_t6 cold_env_out_without_cloth_t6 cold_env_in_without_heating_t6 cold_env_wet_clothing_t6 cold_env_contact_cold_obj_t6 frostbite_past_12mnd_t6 frostbite_past_12mnt_freq_t6 cold_itching_rash_t6 cold_med_treat_work_t6 cold_med_treat_leisure_t6 cold_env_breathing_diff_t6 cold_env_wheezy_breathing_t6 cold_env_mucus_lungs_t6 cold_env_chest_pain_t6 cold_env_arrythmia_t6 cold_env_circ_dis_t6 cold_env_imp_vision_t6 cold_env_migraine_t6 cold_env_white_fingers_t6 cold_env_blue_fingers_t6 cold_env_perform_conc_t6 cold_env_perform_memory_t6 cold_env_perform_tact_sens_t6 cold_env_perform_finger_dex_t6 cold_env_perform_move_t6 cold_env_perform_heavy_work_t6 cold_env_perform_long_work_t6 pt_pversion_t6 pt_date_t6 pt_time_t6 pt_station_t6 pt_examinor_t6 pt_examinor_sex_t6 pt_hair_color_t6 pt_dom_hand_t6 pt_cp_exclude_t6 pt_hp_exclude_t6 pt_pp_exclude_t6 pt_cp_side_t6 pt_hp_side_t6 pt_pp_side_t6 pt_pp_finger_t6 pt_cp_dur_t6 pt_cp_nrs01_t6 pt_cp_nrs02_t6 pt_cp_nrs03_t6 pt_cp_nrs04_t6 pt_cp_nrs05_t6 pt_cp_nrs06_t6 pt_cp_nrs07_t6 pt_cp_nrs08_t6 pt_cp_nrs09_t6 pt_cp_nrs10_t6 pt_cp_nrs11_t6 pt_cp_nrs12_t6 pt_cp_nrs01p_t6 pt_cp_nrs02p_t6 pt_cp_nrs03p_t6 pt_cp_nrs04p_t6 pt_cp_nrs05p_t6 pt_cp_nrs06p_t6 pt_cp_dur_error_t6 pt_cp_nrs_error_t6 pt_cp_rcv_error_t6 pt_pp_kpa1_t6 pt_pp_kpa2_t6 pt_pp_kpa3_t6 pt_pp1_error_t6 pt_pp2_error_t6 pt_pp3_error_t6 pt_exl_rep_t6 pt_exl_rep_frstb_t6 pt_exl_rep_calrg_t6 pt_exl_rep_raynd_t6 pt_exl_rep_hyprs_t6 pt_exl_rep_hypos_t6 pt_exl_rep_other_t6 pt_exl_rep_frtxt_t6 pt_exl_obs_sores_t6 pt_exl_obs_inflm_t6 pt_exl_obs_hyprs_t6 pt_exl_obs_hypos_t6 pt_exl_obs_lame_t6 pt_exl_obs_amput_t6 pt_exl_obs_other_t6 pt_exl_obs_frtxt_t6 cpt_attended_t6 pt_pre_cpt_sdnn_t6 pt_pre_cpt_pnn50_t6 pt_pre_cpt_sdsd_t6 pt_pre_cpt_rmssd_t6 pt_pre_cpt_irrr_t6 pt_pre_cpt_madrr_t6 pt_pre_cpt_tinn_t6 pt_pre_cpt_hrvi_t6 pt_pre_cpt_four_mf_power_t6 pt_pre_cpt_four_hf_power_t6 pt_pre_cpt_four_mfhf_pow_t6 pt_pre_cpt_four_lf_power_t6 pt_pre_cpt_four_lfhf_pow_t6 pt_pre_cpt_wavd8_mf_pow_t6 pt_pre_cpt_wavd8_hf_pow_t6 pt_pre_cpt_wavd8_mfhf_pow_t6 pt_pre_cpt_wavd8_lf_pow_t6 pt_pre_cpt_wavd8_lfhf_pow_t6 pt_pre_cpt_wavha_mf_pow_t6 pt_pre_cpt_wavha_hf_pow_t6 pt_pre_cpt_wavha_mfhf_pow_t6 pt_pre_cpt_wavha_lf_pow_t6 pt_pre_cpt_wavha_lfhf_pow_t6 pt_pre_cpt_sampen_r1_t6 pt_pre_cpt_sampen_r2_t6 pt_pre_cpt_phase_length_t6 pt_pre_cpt_no_rem_beats_t6 pt_pre_cpt_rem_beats_perc_t6 pt_post_cpt_sdnn_t6 pt_post_cpt_pnn50_t6 pt_post_cpt_sdsd_t6 pt_post_cpt_rmssd_t6 pt_post_cpt_irrr_t6 pt_post_cpt_madrr_t6 pt_post_cpt_tinn_t6 pt_post_cpt_hrvi_t6 pt_post_cpt_four_mf_pow_t6 pt_post_cpt_four_hf_pow_t6 pt_post_cpt_four_mfhf_pow_t6 pt_post_cpt_four_lf_pow_t6 pt_post_cpt_four_lfhf_pow_t6 pt_post_cpt_wavd8_mf_pow_t6 pt_post_cpt_wavd8_hf_pow_t6 pt_post_cpt_wavd8_mfhf_pow_t6 pt_post_cpt_wavd8_lf_pow_t6 pt_post_cpt_wavd8_lfhf_pow_t6 pt_post_cpt_wavha_mf_pow_t6 pt_post_cpt_wavha_hf_pow_t6 pt_post_cpt_wavha_mfhf_pow_t6 pt_post_cpt_wavha_lf_pow_t6 pt_post_cpt_wavha_lfhf_pow_t6 pt_post_cpt_sampen_r1_t6 pt_post_cpt_sampen_r2_t6 pt_post_cpt_phase_length_t6 pt_post_cpt_no_rem_beats_t6 pt_post_cpt_rem_beats_perc_t6 pt_pre_cpt_m_reg_slop_t6 pt_pre_cpt_m_pos_reg_slop_t6 pt_pre_cpt_m_neg_reg_slop_t6 pt_pre_cpt_sd_reg_slop_t6 pt_pre_cpt_sd_pos_reg_slop_t6 pt_pre_cpt_sd_neg_reg_slop_t6 pt_pre_cpt_no_pos_brs_seqs_t6 pt_pre_cpt_no_neg_brs_seqs_t6 pt_post_cpt_m_reg_slop_t6 pt_post_cpt_m_pos_reg_slop_t6 pt_post_cpt_m_neg_reg_slop_t6 pt_post_cpt_sd_reg_slop_t6 pt_post_cpt_sd_pos_reg_slop_t6 pt_post_cpt_sd_neg_reg_slop_t6 pt_post_cpt_no_pos_brs_seqs_t6 pt_post_cpt_no_neg_brs_seqs_t6 age_t7 sex_t7 attendance_time_d1_t7 height_t7 weight_t7 waist_t7 hip_t7 chronic_pain_t7 physical_activity_work_t7 phys_activity_leisure_t7 hours_sitting_weekday_t7 hours_sitting_weekend_t7 smoke_daily_t7 snuff_chewing_tobacco_t7 education_t7 household_income_t7 occupation_t7 unemployed_time_t7 occupation_status_t7 describe_profession_work_t7 occupation_description_t7 occupation_title_t7 last_occupation_t7 last_occupation_description_t7 last_occupation_title_t7 neck_pain_3months_t7 arm_pain_3months_t7 upper_back_pain_3months_t7 lumbar_pain_3months_t7 hip_leg_pain_3months_t7 other_pain_3months_t7 neck_pain_4weeks_t7 arm_pain_4weeks_t7 upper_back_pain_4weeks_t7 lumbar_pain_4weeks_t7 hip_leg_pain_4weeks_t7 other_pain_4weeks_t7 headache_last_year_t7 exercise_t7 exercise_level_t7 exercise_duration_t7 grip_completed_t7 grip_date_t7 grip_head_t7 grip_neck_t7 grip_back_t7 grip_chest_t7 grip_abdom_t7 grip_genit_t7 grip_larm_t7 grip_rarm_t7 grip_lleg_t7 grip_rleg_t7 grip_head_a01_t7 grip_head_a02_t7 grip_head_a03_t7 grip_head_a04_t7 grip_head_a05_t7 grip_head_a06_t7 grip_head_a07_t7 grip_head_a08_t7 grip_head_a09_t7 grip_head_a10_t7 grip_head_a11_t7 grip_head_a12_t7 grip_head_a13_t7 grip_head_a14_t7 grip_head_a15_t7 grip_head_a16_t7 grip_head_a17_t7 grip_head_a18_t7 grip_head_a19_t7 grip_head_a20_t7 grip_head_a21_t7 grip_head_a22_t7 grip_head_a23_t7 grip_head_a24_t7 grip_head_a25_t7 grip_head_a26_t7 grip_neck_a01_t7 grip_neck_a02_t7 grip_neck_a03_t7 grip_back_a01_t7 grip_back_a02_t7 grip_back_a03_t7 grip_back_a04_t7 grip_back_a05_t7 grip_back_a06_t7 grip_back_a07_t7 grip_chest_a01_t7 grip_chest_a02_t7 grip_chest_a03_t7 grip_chest_a04_t7 grip_chest_a05_t7 grip_chest_a06_t7 grip_chest_a07_t7 grip_chest_a08_t7 grip_chest_a09w_t7 grip_chest_a10w_t7 grip_abdom_a01_t7 grip_abdom_a02_t7 grip_abdom_a03_t7 grip_abdom_a04_t7 grip_abdom_a05_t7 grip_abdom_a06_t7 grip_genit_a01m_t7 grip_genit_a02m_t7 grip_genit_a03m_t7 grip_genit_a04m_t7 grip_genit_a05m_t7 grip_genit_a06m_t7 grip_genit_a07m_t7 grip_genit_a01w_t7 grip_genit_a02w_t7 grip_genit_a03w_t7 grip_genit_a04w_t7 grip_genit_a05w_t7 grip_genit_a06w_t7 grip_larm_a01_t7 grip_larm_a02_t7 grip_larm_a03_t7 grip_larm_a04_t7 grip_larm_a05_t7 grip_larm_a06_t7 grip_larm_a07_t7 grip_larm_a08_t7 grip_larm_a09_t7 grip_larm_a10_t7 grip_larm_a11_t7 grip_larm_a12_t7 grip_larm_a13_t7 grip_larm_a14_t7 grip_larm_a15_t7 grip_larm_a16_t7 grip_larm_a17_t7 grip_larm_a18_t7 grip_larm_a19_t7 grip_larm_a20_t7 grip_larm_a21_t7 grip_larm_a22_t7 grip_larm_a23_t7 grip_larm_a24_t7 grip_larm_a25_t7 grip_larm_a26_t7 grip_larm_a27_t7 grip_larm_a28_t7 grip_larm_a29_t7 grip_larm_a30_t7 grip_rarm_a01_t7 grip_rarm_a02_t7 grip_rarm_a03_t7 grip_rarm_a04_t7 grip_rarm_a05_t7 grip_rarm_a06_t7 grip_rarm_a07_t7 grip_rarm_a08_t7 grip_rarm_a09_t7 grip_rarm_a10_t7 grip_rarm_a11_t7 grip_rarm_a12_t7 grip_rarm_a13_t7 grip_rarm_a14_t7 grip_rarm_a15_t7 grip_rarm_a16_t7 grip_rarm_a17_t7 grip_rarm_a18_t7 grip_rarm_a19_t7 grip_rarm_a20_t7 grip_rarm_a21_t7 grip_rarm_a22_t7 grip_rarm_a23_t7 grip_rarm_a24_t7 grip_rarm_a25_t7 grip_rarm_a26_t7 grip_rarm_a27_t7 grip_rarm_a28_t7 grip_rarm_a29_t7 grip_rarm_a30_t7 grip_lleg_a01_t7 grip_lleg_a02_t7 grip_lleg_a03_t7 grip_lleg_a04_t7 grip_lleg_a05_t7 grip_lleg_a06_t7 grip_lleg_a07_t7 grip_lleg_a08_t7 grip_lleg_a09_t7 grip_lleg_a10_t7 grip_lleg_a11_t7 grip_lleg_a12_t7 grip_lleg_a13_t7 grip_lleg_a14_t7 grip_lleg_a15_t7 grip_lleg_a16_t7 grip_lleg_a17_t7 grip_lleg_a18_t7 grip_lleg_a19_t7 grip_lleg_a20_t7 grip_lleg_a21_t7 grip_lleg_a22_t7 grip_lleg_a23_t7 grip_lleg_a24_t7 grip_lleg_a25_t7 grip_rleg_a01_t7 grip_rleg_a02_t7 grip_rleg_a03_t7 grip_rleg_a04_t7 grip_rleg_a05_t7 grip_rleg_a06_t7 grip_rleg_a07_t7 grip_rleg_a08_t7 grip_rleg_a09_t7 grip_rleg_a10_t7 grip_rleg_a11_t7 grip_rleg_a12_t7 grip_rleg_a13_t7 grip_rleg_a14_t7 grip_rleg_a15_t7 grip_rleg_a16_t7 grip_rleg_a17_t7 grip_rleg_a18_t7 grip_rleg_a19_t7 grip_rleg_a20_t7 grip_rleg_a21_t7 grip_rleg_a22_t7 grip_rleg_a23_t7 grip_rleg_a24_t7 grip_rleg_a25_t7 grip_head_onset_t7 grip_head_age_t7 grip_head_ndays_t7 grip_head_dur_t7 grip_head_int_t7 grip_head_bother_t7 grip_head_depth_t7 grip_neck_onset_t7 grip_neck_age_t7 grip_neck_ndays_t7 grip_neck_dur_t7 grip_neck_int_t7 grip_neck_bother_t7 grip_neck_depth_t7 grip_back_onset_t7 grip_back_age_t7 grip_back_ndays_t7 grip_back_dur_t7 grip_back_int_t7 grip_back_bother_t7 grip_back_depth_t7 grip_back_rad_t7 grip_back_rad_dist_t7 grip_back_rad_sens_t7 grip_chest_onset_t7 grip_chest_age_t7 grip_chest_ndays_t7 grip_chest_dur_t7 grip_chest_int_t7 grip_chest_bother_t7 grip_chest_depth_t7 grip_abdom_onset_t7 grip_abdom_age_t7 grip_abdom_ndays_t7 grip_abdom_dur_t7 grip_abdom_int_t7 grip_abdom_bother_t7 grip_abdom_depth_t7 grip_genit_onset_t7 grip_genit_age_t7 grip_genit_ndays_t7 grip_genit_dur_t7 grip_genit_int_t7 grip_genit_bother_t7 grip_genit_depth_t7 grip_rarm_onset_t7 grip_rarm_age_t7 grip_rarm_ndays_t7 grip_rarm_dur_t7 grip_rarm_int_t7 grip_rarm_bother_t7 grip_rarm_depth_t7 grip_larm_onset_t7 grip_larm_age_t7 grip_larm_ndays_t7 grip_larm_dur_t7 grip_larm_int_t7 grip_larm_bother_t7 grip_larm_depth_t7 grip_rleg_onset_t7 grip_rleg_age_t7 grip_rleg_ndays_t7 grip_rleg_dur_t7 grip_rleg_int_t7 grip_rleg_bother_t7 grip_rleg_depth_t7 grip_lleg_onset_t7 grip_lleg_age_t7 grip_lleg_ndays_t7 grip_lleg_dur_t7 grip_lleg_int_t7 grip_lleg_bother_t7 grip_lleg_depth_t7 grip_impact_sleep_t7 grip_impact_adl_t7 pt_time_t7 pt_exclusion_pressure_t7 pt_exclusion_cold_t7 pt_rp2_side_t7  pt_rp2_kpa_tol_t7 pt_rp3_side_t7  pt_rp3_kpa_tol_t7 pt_cpt_sec_tol_t7
}


********** Fitting a sinusoidal curves



reg propover100 sin cos
predict sinfit
gen ns_cpt_day=propover100-sinfit
graph drop _all
tw (line propover100 date)  (line ns_cpt_day date) (line sinfit date) if date>=td(01jan2015) & date<=td(01nov2016)


rename ppt_mean ppt_day
corrgram ns_cpt_day
corrgram ppt_day


forvalues i=1(2)7{
scalar define n = floor(`i'/2)
scalar define q = `i'
foreach var in   a_ffm a_pom a_rr a_tam a_td a_um {
tssmooth ma ma_`i'`var'=`var', window(`=scalar(n)' 1 `=scalar(n)')
egen sma_`i'`var'=std(ma_`i'`var')
} 

}

 foreach var in  ns_cpt_day {
 egen s`var'= std(`var')
 }



forvalues i = 1(2)7 {
scalar define n = ceil(`i'/2)
gen ma_`i'ns_cpt_day=. 
forvalues d = 20089(1)20759 {
egen ma_`i'ns_cpt_day`d'=mean(ns_cpt_day) if date>`d'-`=scalar(n)' & date<`d'+`=scalar(n)'
replace  ma_`i'ns_cpt_day=ma_`i'ns_cpt_day`d' if date==`d'
drop ma_`i'ns_cpt_day`d'

 }
gen sma_`i'ns_cpt_day=. 
forvalues d = 20089(1)20759 {
egen sma_`i'ns_cpt_day`d'=mean(sns_cpt_day) if date>`d'-`=scalar(n)' & date<`d'+`=scalar(n)'
replace  sma_`i'ns_cpt_day=sma_`i'ns_cpt_day`d' if date==`d'
drop sma_`i'ns_cpt_day`d'

 }
 
 gen ma_`i'ppt_day=. 
forvalues d = 20089(1)20759 {
egen ma_`i'ppt_day`d'=mean(ppt_day) if date>`d'-`=scalar(n)' & date<`d'+`=scalar(n)'
replace  ma_`i'ppt_day=ma_`i'ppt_day`d' if date==`d'
drop ma_`i'ppt_day`d'

 }
}
gen dow=dow(date)
 
 
 foreach var in ma_7ns_cpt_day ma_7ppt_day a_ffm a_pom      a_rr   a_tam   a_td a_um  { 
 forvalues i= 0(1)6 {
 gen `var'`i'= `var' if dow==`i'
 }
 }
 list ma_7ns_cpt_day* in 1/200
 
 gen periods=1 if date<=td(01aug2015)
replace periods=2 if  date>td(01aug2015) & date<td(31dec2015)
replace periods=3 if date>=td(31dec2015) & date<td(01jul2016)
replace periods=4 if date>=td(01jul2016)

save "C:\Users\efa036\OneDrive - UiT Office 365\Statpaper3\tidsserie_t7.dta", replace

use "C:\Users\efa036\OneDrive - UiT Office 365\Statpaper3\tidsserie_t7.dta", replace
gen time=_n
 save "C:\Users\efa036\OneDrive - UiT Office 365\Statpaper3\Paper3\for_r.dta", replace




