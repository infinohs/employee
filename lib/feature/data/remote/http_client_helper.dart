import 'dart:convert';

import 'package:employee/feature/data/local/local_index.dart';
import 'package:employee/feature/data/local/shared_pref.dart';
import 'package:employee/feature/data/remote/apis_constants.dart';
import 'package:employee/feature/data/remote/logging_interceptor.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http/http.dart';

class HttpClientHelper {
  static final HttpClientHelper _instance = HttpClientHelper._internal();
  late Client client;

  HttpClientHelper._internal() {
    client = InterceptedClient.build(interceptors: [LoggingInterceptor()]);
  }

  factory HttpClientHelper() {
    return _instance;
  }

  Future<Response> getLoginApi(
      {String url: "", String mobileNumber: "", String password: ""}) async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    var fcmToken = await messaging.getToken();
    return await client.post(Uri.parse(url), body: {
      'email': mobileNumber,
      'password': password,
      'registration_id': fcmToken
    });
  }

  Future<Response> askEntryApi(
      {String url: "", String mobileNumber: "", String password: ""}) async {
    return await client.post(Uri.parse(url), body: {
      'email': mobileNumber,
      'password': password,
    });
  }

  Future<Response> getFlats({String securityGuardId: ""}) async {
    return await client.post(Uri.parse(ApiConstants.getFlats), body: {
      'security_guard_id': securityGuardId,
    });
  }

  Future<Response> getRegistrationDropDownApi(
      {String mobileNumber: "", String password: ""}) async {
    return await client.post(
      Uri.parse(ApiConstants.getRegistrationPreData),
    );
  }

  Future<Response> getComplaintActive(String userId) async {
    return await client.post(Uri.parse(ApiConstants.getZonalActiveComplaint),
        headers: {
          "Content-Type": "application/json",
          'Accept': 'application/json',
        },
        body: jsonEncode(<String, String>{'zonal_id': userId}));
  }

  Future<Response> getZonalResponse(String userId) async {
    return await client.post(Uri.parse(ApiConstants.get_employee_count),
        headers: {
          "Content-Type": "application/json",
          'Accept': 'application/json',
        },
        body: jsonEncode(<String, String>{'zonal_id': userId}));
  }

  Future<Response> getProfileDetailApi() async {
    int userId = await SharedPref().getIntValue(LocalIndex().UserId);
    String email = await SharedPref().getStringValue(LocalIndex().email);
    String username = await SharedPref().getStringValue(LocalIndex().username);
    return await client.post(Uri.parse(ApiConstants.getUserDetail),
        headers: {
          "Content-Type": "application/json",
          'Accept': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'user_id': userId.toString(),
          'email': email,
          'username': username
        }));
  }

  // Future<Response> updateProfileDetailApi(String userName,String mobile,String email,File Image) async {
  //   // int userIz = await SharedPref().getIntValue(LocalIndex().UserId);
  //   // return await client.post(Uri.parse(ApiConstants.updateUserDetail),
  //   //     headers: {
  //   //       "Content-Type": "application/json",
  //   //       'Accept': 'application/json',
  //   //     },
  //   //     body: jsonEncode(<String, String>{
  //   //       'id': userId.toString(),
  //   //       'file': "fileMultipart",
  //   //     }));
  //
  //
  //
  //   // var request = http.MultipartRequest('POST', Uri.parse(severUrl));
  //   // request.files.add(
  //   //     http.MultipartFile(
  //   //         'picturePath',
  //   //         File(filename).readAsBytes().asStream(),
  //   //         File(filename).lengthSync(),
  //   //         filename: filename.split("/").last
  //   //     )
  //   // );
  //   // var res = await request.send();
  //
  //
  // }

  Future<Response> getNotificationCall(String userId, String flag) async {
    return await client.post(Uri.parse(ApiConstants.getNotification),
        headers: {
          "Content-Type": "application/json",
          'Accept': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'user_id': userId,
          'is_society_owner_flag': flag
        }));
  }

  Future<Response> getComplaintComplited(String userId) async {
    return await client.post(Uri.parse(ApiConstants.getZonalCompletedComplaint),
        headers: {
          "Content-Type": "application/json",
          'Accept': 'application/json',
        },
        body: jsonEncode(<String, String>{'zonal_id': userId}));
  }

  Future<Response> getComplaintPending(String userId) async {
    return await client.post(Uri.parse(ApiConstants.getZonalCompletedPending),
        headers: {
          "Content-Type": "application/json",
          'Accept': 'application/json',
        },
        body: jsonEncode(<String, String>{'zonal_id': userId}));
  }

  Future<Response> getServicesApi(String society_id) async {
    return await client.post(Uri.parse(ApiConstants.getServices),
        headers: {
          "Content-Type": "application/json",
          'Accept': 'application/json',
        },
        body: jsonEncode(<String, String>{'society_id': society_id}));
  }

  Future<Response> registrationApi(
      String firstName,
      String lastName,
      String email,
      String mobile,
      String password,
      String societyId,
      int owerType,
      String cityId) async {
    return await client.post(
      Uri.parse(ApiConstants.getRegistration),
      headers: {
        "Content-Type": "application/json",
        'Accept': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'fname': firstName,
        'lname': lastName,
        'email': email,
        'mobile': mobile,
        'password': password,
        'society_id': societyId,
        'is_society_owner': owerType.toString(),
        'city_id': cityId,
      }),
    );
  }

  Future<Response> setComplaintApi(
      String complaint_name, int service_id, String description) async {
    int userId = await SharedPref().getIntValue(LocalIndex().UserId);
    String society_id =
        await SharedPref().getStringValue(LocalIndex().societyId);

    return await client.post(Uri.parse(ApiConstants.setComplaint),
        headers: {
          "Content-Type": "application/json",
          'Accept': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'user_id': userId.toString(),
          'complaint_name': complaint_name,
          'society_id': society_id,
          'service_id': service_id.toString(),
          'description': description,
        }));
  }

//
//   Future<Response> getBanner() async {
//     return await http.get(Uri.parse(
//         ApiConstants().BASE_URL_RELEASED + ApiConstants().GET_BANNER));
//   }
//   Future<Response> getArticle() async {
//     return await http.get(Uri.parse(
//         ApiConstants().BASE_URL_RELEASED + ApiConstants().GET_ARTICLES));
//   }
//   Future<Response> getProductByType(String cityName, String productType) async {
//     var param = "?cityName=$cityName&productType=$productType";
//     return await http.get(Uri.parse(ApiConstants().BASE_URL_RELEASED +
//         ApiConstants().GET_PRODUCT_BY_TYPE +
//         param));
//   }
//   Future<Response> getHeroFaq() async {
//     return await http.get(Uri.parse(ApiConstants().BASE_URL_RELEASED +
//         ApiConstants().GET_HERO_FAQ_GLOBAL_REVIEW));
//   }
//
//   Future<Response> getProductTypeTray(
//       {String locations: "", String city = ""}) async {
//     var param = "?locations=$locations" + "&city=$city";
//     return await http.get(Uri.parse(ApiConstants().BASE_URL_RELEASED +
//         ApiConstants().GET_PRODUCT_TYPE_TRAY +
//         param));
//   }
//
//   Future<Response> getDetails() async {
//     String token = await SharedPref().getStringValue(LocalIndex().TOKEN_KEY);
//     return await http.get(
//       Uri.parse(ApiConstants().BASE_URL_RELEASED + ApiConstants().GET_DETAILS),
//       headers: {
//         "Content-Type": "application/json",
//         'Authorization': 'Bearer $token',
//         'Accept': 'application/json',
//       },
//     );
//   }
//
//   Future<Response> getFriendsWhoSignedUp() async {
//     String token = await SharedPref().getStringValue(LocalIndex().TOKEN_KEY);
//     int userId = await SharedPref().getIntValue(LocalIndex().USERID);
//
//     var param = "?referrerCode=${"U-" + userId.toString()}&statuses=Converted";
//     return await http.get(
//       Uri.parse(ApiConstants().BASE_URL_RELEASED +
//           ApiConstants().GET_FRIENDS_WHO +
//           param),
//       headers: {
//         "Content-Type": "application/json",
//         'Authorization': 'Bearer $token',
//         'Accept': 'application/json',
//       },
//     );
//   }
//
//   Future<Response> getReward() async {
//     String token = await SharedPref().getStringValue(LocalIndex().TOKEN_KEY);
//     int userId = await SharedPref().getIntValue(LocalIndex().USERID);
//
//     var param = "?referrerCode=${"U-" + userId.toString()}&fromDate&toDate";
//     return await http.get(
//       Uri.parse(ApiConstants().BASE_URL_RELEASED +
//           ApiConstants().YOUR_REWARDS +
//           param),
//       headers: {
//         "Content-Type": "application/json",
//         'Authorization': 'Bearer $token',
//         'Accept': 'application/json',
//       },
//     );
//   }
//
//   Future<Response> getTicket() async {
//     String token = await SharedPref().getStringValue(LocalIndex().TOKEN_KEY);
//     int userId = await SharedPref().getIntValue(LocalIndex().USERID);
//
//     var param = "?customerCode=${"U-" + userId.toString()}&status=New,Opened";
//     //  "?referrerCode=${"U-" + userId.toString()}&fromDate&toDate";
//     return await http.get(
//       Uri.parse(ApiConstants().BASE_URL_RELEASED +
//           ApiConstants().GET_TICKETS +
//           param),
//       headers: {
//         "Content-Type": "application/json",
//         'Authorization': 'Bearer $token',
//         'Accept': 'application/json',
//       },
//     );
//   }
//
//   Future<Response> sendMultipartRequest(
//       String url, List<http.MultipartFile> files) async {
//     var request = http.MultipartRequest("Post", Uri.parse(url));
//     request.files.addAll(files);
//     // request.headers.addAll(headers);
//     print(request.toString());
//     var response = await request.send();
//     return await http.Response.fromStream(response);
//   }
//
//   Future<Response> sendMultipartRequestWithToken(
//       String url, String token, List<http.MultipartFile> files) async {
//     var headers = Map<String, String>();
//     headers.putIfAbsent("Accept", () => "application/json");
//     headers.putIfAbsent("Content-Type", () => "application/json");
//     headers.putIfAbsent("Authorization", () => 'Bearer $token');
//
//     var request = http.MultipartRequest("Post", Uri.parse(url));
//     request.files.addAll(files);
//     request.headers.addAll(headers);
//     print(request.toString());
//     var response = await request.send();
//     return await http.Response.fromStream(response);
//   }
//
//   Future<Response> getMethodResponse(String url) async {
//     return await http.get(Uri.parse(url));
//   }
//
//   Future<Response> getGlobalOffer() async {
//     String cityName =
//         await SharedPref().getStringValue(LocalIndex().CITY_NAME_KEY);
//     String mobileNumber =
//         await SharedPref().getStringValue(LocalIndex().MOBILE_NUMBER_KEY);
//     var param = "?cityName=$cityName&mobileNumber=$mobileNumber";
//     return await http.get(Uri.parse(ApiConstants().BASE_URL_RELEASED +
//         ApiConstants().GET_GLOBAL_OFFERS +
//         param));
//   }
//
//   Future<Response> getApplyNowOffer() async {
//     return await http.post(Uri.parse(
//         ApiConstants().BASE_URL_RELEASED + ApiConstants().ApplyNowUrl));
//   }
//
//   Future<Response> getProductTypesDetails(
//       String cityName, String mobileNumber) async {
//     var param = "mobileNumber=" +
//         mobileNumber +
//         "&sendProducts=true&sendRecipes=true&cityName=" +
//         cityName +
//         "&sendRemainingStock=true";
//     return await http.get(Uri.parse(ApiConstants().BASE_URL_RELEASED +
//         ApiConstants().GET_PRODUCT_TYPES_DETAILS +
//         param));
//   }
//
//   Future<Response> getProCoinsSlap(String userCode) async {
//     var param = "userCode=$userCode";
//     return await http.get(Uri.parse(ApiConstants().BASE_URL_RELEASED +
//         ApiConstants().GET_PRO_COINS_SLAPS +
//         param));
//   }
//
//   Future<Response> getProCoinsLedger(
//       String customerCode, String? fromDate, String? toDate) async {
//     var param = "customerCode=" + customerCode;
//     if (fromDate != null) {
//       param = param + "&fromDate=$fromDate";
//     } else if (toDate != null) {
//       param = param + "&toDate=$toDate";
//     }
//
//     return await http.get(Uri.parse(ApiConstants().BASE_URL_RELEASED +
//         ApiConstants().GET_PRO_COINS_LDGER +
//         param));
//   }
//
//   Future<Response> getProductCurrentStockDetails(
//       String cityName, String productCode) async {
//     var param = "productCode=" + productCode + "cityName=" + cityName;
//     return await http.get(Uri.parse(ApiConstants().BASE_URL_RELEASED +
//         ApiConstants().GET_PRODUCT_TYPES_DETAILS +
//         param));
//   }
//
//   Future<Response> getProCoins() async {
//     String code = await SharedPref().getStringValue(LocalIndex().CODE);
//     return await http.get(Uri.parse(
//         ApiConstants().BASE_URL_RELEASED + ApiConstants().GET_PROCOIN + code));
//   }
//
//   Future<Response> getDefaultCoupon() async {
//     return await http.get(Uri.parse(
//         ApiConstants().BASE_URL_RELEASED + ApiConstants().GET_DEFAULT_COUPON));
//   }
//
//   Future<Response> getConfirmStagingApi(String txdId) async {
//     String token = await SharedPref().getStringValue(LocalIndex().TOKEN_KEY);
//
//     var param = "?stagedPaymentTxnId=$txdId";
//     return await http.post(
//         Uri.parse(ApiConstants().BASE_URL_RELEASED +
//             ApiConstants().CONFIRM_STAGING_API +
//             param),
//         headers: {
//           "Content-Type": "application/json",
//           'Authorization': 'Bearer $token',
//           'Accept': 'application/json',
//         });
//   }
//
//   Future<Response> getCalenderDeliveryItemRating(
//       String? code, double rating) async {
//     String token = await SharedPref().getStringValue(LocalIndex().TOKEN_KEY);
//
//     var param = "?code=$code&rating=$rating";
//     return await http.post(
//       Uri.parse(ApiConstants().BASE_URL_RELEASED +
//           ApiConstants().CALENDER_DELIVERY_ITEM_RATING +
//           param),
//       headers: {
//         "Content-Type": "application/json",
//         'Authorization': 'Bearer $token',
//         'Accept': 'application/json',
//       },
//     );
//   }
//
//   Future<Response> saveAndUpdateCartItem(var body, String url) async {
//     String token = await SharedPref().getStringValue(LocalIndex().TOKEN_KEY);
//     return await http.post(
//       Uri.parse(url),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//         'Authorization': 'Bearer $token',
//       },
//       body: body,
//     );
//   }
//
//   Future<Response> getContainTermsConditionPage() async {
//     return await http.get(
//       Uri.parse(
//           ApiConstants().BASE_URL_RELEASED + ApiConstants().TEAM_AND_CONDITION),
//     );
//   }
//
//   Future<Response> getCalenderDeliveryRange(
//       String fromDate, String toDate) async {
//     String token = await SharedPref().getStringValue(LocalIndex().TOKEN_KEY);
//     String param = "?fromDate=$fromDate&toDate=$toDate";
//     return await http.get(
//       Uri.parse(ApiConstants().BASE_URL_RELEASED +
//           ApiConstants().DATE_RANGE_DELIVERY +
//           param),
//       headers: {
//         "Content-Type": "application/json",
//         'Authorization': 'Bearer $token',
//         'Accept': 'application/json',
//       },
//     );
//   }
//
// /*mega recharge packs*/
//   Future<Response> getMegaRechargeOffers(String url) async {
//     String token = await SharedPref().getStringValue(LocalIndex().TOKEN_KEY);
//     return await http.get(
//       Uri.parse(url),
//       headers: {
//         "Content-Type": "application/json",
//         'Authorization': 'Bearer $token',
//         'Accept': 'application/json',
//       },
//     );
//   }
//
//   Future<Response> getActiveAndInActiveSubscriptionsList(
//       bool isActiveSubscription) async {
//     String token = await SharedPref().getStringValue(LocalIndex().TOKEN_KEY);
//     String param = "?isActiveSubscription=$isActiveSubscription";
//     print(token);
//     return await http.get(
//       Uri.parse(ApiConstants().BASE_URL_RELEASED +
//           ApiConstants().SUBSCRIPTIONLINEITEM_LIST +
//           param),
//       headers: {
//         "Content-Type": "application/json",
//         'Authorization': 'Bearer $token',
//         'Accept': 'application/json',
//       },
//     );
//   }
//
//   Future<Response> addUserReview(String body, String url) async {
//     String token = await SharedPref().getStringValue(LocalIndex().TOKEN_KEY);
//     return await http.post(
//       Uri.parse(url),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//         'Authorization': 'Bearer $token',
//       },
//       body: body,
//     );
//   }
//
//   Future<Response> getProductReviewsByProduct(
//       String productTypeID, String userCode) async {
//     var param;
//     if (userCode == "") {
//       param = "productType=" + productTypeID;
//     } else {
//       param = "productType=" + productTypeID + "&userCode=" + userCode;
//     }
//     String token = await SharedPref().getStringValue(LocalIndex().TOKEN_KEY);
//     return await http.get(
//       Uri.parse(ApiConstants().BASE_URL_RELEASED +
//           ApiConstants().GET_REVIEW_BY_PRODUCT +
//           param),
//       headers: {
//         "Content-Type": "application/json",
//         'Authorization': 'Bearer $token',
//         'Accept': 'application/json',
//       },
//     );
//   }
//
//   // Delete Subscription LineItem
//   Future<Response> deleteSubscriptionLineItem(String lineItemCode) async {
//     String token = await SharedPref().getStringValue(LocalIndex().TOKEN_KEY);
//     String param = "?lineItemCode=$lineItemCode";
//     return await http.post(
//       Uri.parse(ApiConstants().BASE_URL_RELEASED +
//           ApiConstants().DELETE_SUBSCRIPTION_LINEITEM +
//           param),
//       headers: {
//         "Content-Type": "application/json",
//         'Authorization': 'Bearer $token',
//         'Accept': 'application/json',
//       },
//     );
//   }
//
// // Resume Subscription
//   Future<Response> resumeSubscription() async {
//     String token = await SharedPref().getStringValue(LocalIndex().TOKEN_KEY);
//     return await http.post(
//       Uri.parse(ApiConstants().BASE_URL_RELEASED +
//           ApiConstants().RESUME_SUBSCRIPTION),
//       headers: {
//         "Content-Type": "application/json",
//         'Authorization': 'Bearer $token',
//         'Accept': 'application/json',
//       },
//     );
//   }
//
//   // Modify Subscription
//   Future<Response> modifySubscription(LineItemDTOs lineItemDTOs) async {
//     String token = await SharedPref().getStringValue(LocalIndex().TOKEN_KEY);
//     print(jsonEncode(lineItemDTOs));
//     return await http.post(
//       Uri.parse(ApiConstants().BASE_URL_RELEASED +
//           ApiConstants().MODIFY_SUBSCRIPTION),
//       body: jsonEncode(lineItemDTOs),
//       headers: {
//         "Content-Type": "application/json",
//         'Authorization': 'Bearer $token',
//         'Accept': 'application/json',
//       },
//     );
//   }
//
//   // Order History
//   Future<Response> getOrderHistoryByDateRange(
//       String fromDate, String toDate, String? status) async {
//     String token = await SharedPref().getStringValue(LocalIndex().TOKEN_KEY);
//     String? param;
//     if (fromDate.isNotEmpty && toDate.isNotEmpty) {
//       if (status != null && status.isNotEmpty) {
//         param = "?fromDate=$fromDate&toDate=$toDate&status=$status";
//       } else {
//         param = "?fromDate=$fromDate&toDate=$toDate";
//       }
//     }
//
//     return await http.post(
//       Uri.parse(ApiConstants().BASE_URL_RELEASED +
//           ApiConstants().DATE_RANGE_DELIVERY +
//           param!),
//       headers: {
//         "Content-Type": "application/json",
//         'Authorization': 'Bearer $token',
//         'Accept': 'application/json',
//       },
//     );
//   }
//
//   //Inserting version info
//   Future<Response> getVersionInfo() async {
//     return await http.get(Uri.parse(
//         ApiConstants().BASE_URL_RELEASED + ApiConstants().VERSION_INFO));
//   }
//
//   /*create staged payment*/
//   Future<Response> createStagedPayment(var jsonData, String url) async {
//     String token = await SharedPref().getStringValue(LocalIndex().TOKEN_KEY);
//     return await http.post(
//       Uri.parse(url),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//         'Authorization': 'Bearer $token',
//       },
//       body: jsonData,
//     );
//   }
//
//   // Delete Subscription LineItem
//   Future<Response> deleteUserReview(String deleteReviewId) async {
//     String token = await SharedPref().getStringValue(LocalIndex().TOKEN_KEY);
//     String param = "id=$deleteReviewId";
//     return await http.post(
//       Uri.parse(ApiConstants().BASE_URL_RELEASED +
//           ApiConstants().DELETE_REVIEW +
//           param),
//       headers: {
//         "Content-Type": "application/json",
//         'Authorization': 'Bearer $token',
//         'Accept': 'application/json',
//       },
//     );
//   }
//
//   //  Future getMultipartList_ApplyCode(String referral) {
//   //   List<http.MultipartFile> files = [];
//   //   files.add(multiPartFile("referralCode", referral, "application/json"));
//   //   return files;
//   // }
//   Future<Response> applyRefferalCodeApi(String referral) async {
//     String token = await SharedPref().getStringValue(LocalIndex().TOKEN_KEY);
//     String param = "referralCode=$referral";
//     return await http.post(
//       Uri.parse(
//           ApiConstants().BASE_URL_RELEASED + ApiConstants().APPLY_CODE + param),
//       headers: {
//         "Content-Type": "application/json",
//         'Authorization': 'Bearer $token',
//         'Accept': 'application/json',
//       },
//     );
//   }
//
//   Future<Response> refreshFirebaseToken(String firebaseToken) async {
//     String token = await SharedPref().getStringValue(LocalIndex().TOKEN_KEY);
//     return await http.post(
//       Uri.parse(ApiConstants().BASE_URL_RELEASED +
//           ApiConstants().REFRESH_FIREBASE_TOKEN),
//       headers: {
//         "Content-Type": "application/json",
//         'Authorization': 'Bearer $token',
//         'Accept': 'application/json',
//       },
//     );
//   }
}
