class ApiConstants {
  static final String BASE_URL_RELEASED =
      "http://admin.arkayahomecare.com/api/";
  static final String zonalLogin =
      BASE_URL_RELEASED + "check_zonal_managenr_login";
  static final String guadeLogin =
      BASE_URL_RELEASED + "check_security_guard_login";
  static final String getRegistrationPreData =
      BASE_URL_RELEASED + "admin_society_list";
  static final String getRegistration =
      BASE_URL_RELEASED + "add_Society_owner_app";

  static final String getNotification =
      BASE_URL_RELEASED + "get_end_user_all_notifications";
  static final String getServices =
      BASE_URL_RELEASED + "services_subscribedby_socitey";
  static final String setComplaint = BASE_URL_RELEASED + "add_complaint";
  static final String getUserDetail = BASE_URL_RELEASED + "edit_user_profile";
  static final String updateUserDetail =
      BASE_URL_RELEASED + "upload_profile_picture";
  static final String flat_guest_on_gate =
      BASE_URL_RELEASED + "flat_guest_on_gate";
  static final String getFlats = BASE_URL_RELEASED + "get_flats";
  static final String get_employee_count = BASE_URL_RELEASED + "get_employee_count";

  ///// Zonal
  static final String getZonalActiveComplaint =
      BASE_URL_RELEASED + "zonal_comp_active";
  static final String getZonalCompletedComplaint =
      BASE_URL_RELEASED + "zonal_comp_complet";
  static final String getZonalCompletedPending =
      BASE_URL_RELEASED + "zonal_comp_request";
////
}
