import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:vvc/models/vvc_language.dart';

List<VvcLanguage> vvcLanguages = [
  VvcLanguage(name: "English", locale: Locale("en", "US")),
  VvcLanguage(name: "বাংলা", locale: Locale("bn", "BD")),
];

class VvcMultiLanguage extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        "en_US": {
          //Error

          "error": "Something went wrong!",
          "error_title": "Error!",

          //Loading

          "loading": "Loading...",

          //Yes No

          "yes": "Yes",
          "no": "No",
          "cancel": "Cancel",
          "success": "Success!",

          //Error Page
          "error_message":
              "There might be issues about internet connection or the page is not available. Please be patient and try again. If the app doesn't work as expected, check your internet connection and relaunch the app. Thank you!",
          "reload": "Reload!",

          //Auth

          //Login

          "login": "Login",
          "login_email": "Email",
          "login_password": "Password",
          "login_email_error": "Invalid Email!",
          "login_password_error":
              "Password must be at least 6 characters long!",
          "login_remember": "Remember Me!",
          "login_forgot_password": "Forgot Password?",
          "login_continue_with": "Or Continue with,",
          "login_facebook": "Facebook Login",
          "login_google": "Google Login",
          "login_new_user": "New User?",
          "login_go_to_sign_up": "Sign Up Using Email!",
          "login_no_user_found": 'No user found for that email.',
          "login_wrong_password": 'Wrong password provided for that user.',

          //Reset Password

          "reset_password": "Reset Password!",
          "reset_password_send": "Send Reset Request",
          "reset_password_request_sent": "Request Sent!",
          "reset_password_message":
              "A password reset email is sent to your mail. Check and reset your password!",
          "reset_password_user_not_found": "User Not Found!",

          //Sign Up

          "signUp": "Sign Up",
          "signUp_email": "Email",
          "signUp_username": "Username",
          "signUp_password": "Password",
          "signUp_confirm_password": "Confirm Password",
          "signUp_email_error": "Invalid Email!",
          "signUp_username_error":
              "username must be at least 5 characters long!",
          "signUp_password_error":
              "Password must be at least 6 characters long!",
          "signUp_password_dont_match": "Passwords do not match!",
          "signUp_remember": "Remember Me!",

          "signUp_already_user": "Already a user? ",
          "signUp_go_to_login": "Log In!",
          "privacy_policy": "Privacy Policy",
          "terms_and_conditions": "Terms and Conditions!",
          "and": " and ",
          "privacy_terms_sentence": "I have read and agree to the ",
          "privacy_terms_title": "Privacy, Terms and Condtions",
          "privacy_terms_message":
              "Please read and accept our privacy policy and terms to create an account!",

          "signUp_username_exists": 'User name already exists.',
          "signUp_user_exists": 'The account already exists for that email.',

          //Home
          'home': "Home",

          //Contacts
          'contacts': "Contacts",

          //Profile
          'profile': "Profile",

          //Settings
          'settings': "Settings",

          "my_account": "My Account",
          "settings_name": "Name",
          "settings_name_subtitle": "Tap to change name.",
          "settings_no_name": "No Name",
          "settings_profile_picture": "Profile Picture",
          "settings_profile_picture_subtitle": "Tap to change profile picture.",
          "settings_email": "Email",
          "settings_email_subtitle": "Tap to change email.",
          "settings_user_name": "User Name",
          "settings_user_name_subtitle": "Long press to copy.",
          "settings_user_name_copy": "User name is copied to the clipboard!",
          "settings_created_by": "Created by",
          "settings_provide_by": "Account Provider ",
          "settings_created_at": "Created at",
          "settings_last_logged_in": "Last logged in",

          "settings_account_actions": "Account Actions",
          "settings_verification_title": "Verification!",
          "settings_already_verified":
              "You have already verified your account!",
          "settings_account_verified": "Your account is verified!",
          "settings_account_not_verified": "Your account is not verified!",
          "settings_verification_message":
              "A verification link is sent to your email. Click the link and verify it!\nLog out and login again to see the effect!",
          "settings_account_verified_subtitle": "Tap to verify account!",
          "settings_change_password": "Change Password",
          "settings_share_account": "Share Account",

          "settings_app_actions": "App Actions",
          "settings_on_onboarding": "Turn On Onboarding",
          "settings_off_onboarding": "Turn Off Onboarding",
          "settings_language": "Language",
          "settings_select_language": "Select Language!",

          "settings_about_app": "About App",
          "settings_about_vvc": "About VVC",
          "settings_privacy": "Privacy Policy",
          "settings_terms": "Terms and Conditions",

          "settings_see_ya": "See ya!",
          "settings_logout": "Logout",
          "settings_logout_confirmation": "Are you sure you want to logout?",

          "settings_name_change_title":
              "Change your name. This will change the account name, not your card names!",
          "settings_name_change_new_name": "New Name",
          "settings_name_change_new_name_error":
              "Name must be at least 3 characters long!",
          "settings_name_change": "Change Name",
          "settings_name_change_success": "Name changed successfully!",

          "settings_profile_picture_change_success":
              "Profile Picture changed successfully!",

          "settings_email_change_title": "Change your email.",
          "settings_email_change_current_password": "Current Password",
          "settings_email_change_current_password_error":
              "Password is at least 6 characters long!",
          "settings_email_change_new_email": "New Email",
          "settings_email_change_new_email_error": "Invalid Email!",
          "settings_email_change": "Change Email",
          "settings_email_change_success": "Email changed successfully!",
          "settings_email_change_already_in_use":
              "Email is already in use. Please try again with different email!",
          "settings_email_change_wrong_password":
              "Your current password is not what we have in our system!",
          "settings_email_change_cross_limit":
              "Don't cross your limit to do such tasks again! We have blocked you for a while. Try again later!",

          "settings_username_change_title": "Change your username.",
          "settings_username_change_current_password": "Current Password",
          "settings_username_change_current_password_error":
              "Password is at least 6 characters long!",
          "settings_username_change_new_username": "New Username",
          "settings_username_change_new_username_error":
              "User name is at least 5 characters long!",
          "settings_username_change": "Change Username",
          "settings_username_change_success": "Username changed successfully!",
          "settings_username_change_already_in_use":
              "Username is already in use.",
          "settings_username_change_wrong_password":
              "Your current password is not what we have in our system!",
          "settings_username_change_cross_limit":
              "Don't cross your limit to do such tasks again! We have blocked you for a while. Try again later!",

          "settings_password_change_title": "Change your pasword.",
          "settings_password_change_current_password": "Current Password",
          "settings_password_change_current_password_error":
              "Password is at least 6 characters long!",
          "settings_password_change_new_password": "New Password",
          "settings_password_change_new_password_error":
              "Password is at least 6 characters long!",
          "settings_password_change_confirm_password": "Confirm Password",
          "settings_password_change_confirm_password_error":
              "Password is at least 6 characters long!",
          "settings_password_change_dont_match": "Passwords do not match!",
          "settings_password_change": "Change Password",
          "settings_password_change_success": "Password changed successfully!",
          "settings_password_change_wrong_password":
              "Your current password is not what we have in our system!",
          "settings_password_change_cross_limit":
              "Don't cross your limit to do such tasks again! We have blocked you for a while. Try again later!",
        },
        "bn_BD": {
          //Error

          "error": "কোনো একটা সমস্যা হয়েছে!",
          "error_title": "ত্রুটি!",

          //Loading

          "loading": "লোড হচ্ছে...",

          //Yes No

          "yes": "হ্যাঁ",
          "no": "না",
          "cancel": "না",
          "success": "সফল!",

          //Error Page
          "error_message":
              "ইন্টারনেট সংযোগে সমস্যা থাকতে পারে বা এই পেজটি নাই। দয়া করে ধৈর্য ধরুন এবং আবার চেষ্টা করুন। যদি অ্যাপটি আশানুরুপ কাজ না করে তবে আপনার ইন্টারনেট সংযোগ পরীক্ষা করে অ্যাপটি পুনরায় চালু করুন।",
          "reload": "পুনরায় লোড করুন!",

          //Auth

          //Login

          "login": "লগইন",
          "login_email": "ইমেইল",
          "login_password": "পাসওয়ার্ড",
          "login_email_error": "ভুল ইমেইল",
          "login_password_error": "পাসওয়ার্ড অন্তত ৬ অক্ষর দীর্ঘ হতে হবে!!",
          "login_remember": "মনে রাখুন!",
          "login_forgot_password": "পাসওয়ার্ড ভুলে গেছেন?",
          "login_continue_with": "অথবা লগইন করুন,",
          "login_facebook": "ফেসবুক লগইন",
          "login_google": "গুগল লগইন",
          "login_new_user": "নতুন ব্যবহারকারী?",
          "login_go_to_sign_up": "ইমেইল ব্যবহার করে সাইন আপ করুন!",
          "login_no_user_found":
              "এই ইমেইলের কোনও ব্যবহারকারীকে পাওয়া যায় নি।",
          "login_wrong_password":
              'এই ব্যবহারকারীর জন্য ভুল পাসওয়ার্ড প্রদান করা হয়েছে।',

          //Reset password

          "reset_password": "পাসওয়ার্ড রিসেট করুন!",
          "reset_password_send": "রিসেট রিকুয়েস্ট পাঠান",
          "reset_password_request_sent": "অনুরোধ পাঠানো হল!",
          "reset_password_message":
              "আপনার মেইলে একটি পাসওয়ার্ড রিসেট ইমেল পাঠানো হয়েছে। ইমেইল চেক করুন এবং পুনরায় পাসওয়ার্ড সেট করুন!",
          "reset_password_user_not_found": "কোনো ব্যবহারকারী পাওয়া যায় নি!",

          //Sign Up

          "signUp": "সাইন আপ",
          "signUp_email": "ইমেইল",
          "signUp_username": "ইউজারনেম",
          "signUp_password": "পাসওয়ার্ড",
          "signUp_confirm_password": "পাসওয়ার্ড পুনরায় লিখুন",
          "signUp_email_error": "ভুল ইমেইল",
          "signUp_username_error": "ইউজারনেম অন্তত ৫ অক্ষর দীর্ঘ হতে হবে!",
          "signUp_password_error": "পাসওয়ার্ড অন্তত ৬ অক্ষর দীর্ঘ হতে হবে!",
          "signUp_password_dont_match": "পাসওয়ার্ড মিলছে না!",
          "signUp_remember": "মনে রাখুন!",

          "signUp_already_user": "ইতিমধ্যে একজন ব্যবহারকারী? ",
          "signUp_go_to_login": "লগইন",
          "privacy_policy": "গোপনীয়তা নীতি",
          "terms_and_conditions": "শর্তাবলী!",
          "and": " এবং ",
          "privacy_terms_sentence": "আমি পড়েছি এবং একমত হয়েছি - ",
          "privacy_terms_title": "গোপনীয়তা নীতি এবং শর্তাবলী",
          "privacy_terms_message":
              "দয়া করে একটি অ্যাকাউন্ট তৈরি করতে আমাদের গোপনীয়তা নীতি এবং শর্তাবলী পড়ুন এবং স্বীকার করুন!",

          "signUp_username_exists": "এই ইউজারনেম ব্যবহার করা হয়েছে!",
          "signUp_user_exists":
              'ইতিমধ্যেই এই ইমেলের জন্য একটি অ্যাকাউন্ট বিদ্যমান।',

          //Home
          'home': "হোম",

          //Contacts
          'contacts': "কন্টাক্টস",

          //Profile
          'profile': "প্রোফাইল",

          //Settings
          'settings': "সেটিংস",

          "my_account": "আমার অ্যাকাউন্ট",
          "settings_name": "নাম",
          "settings_name_subtitle": "নাম পরিবর্তন করতে আলতো চাপুন",
          "settings_no_name": "নাম নেই",
          "settings_profile_picture": "প্রোফাইল ছবি",
          "settings_profile_picture_subtitle":
              "প্রোফাইল ছবি পরিবর্তন করতে আলতো চাপুন",
          "settings_email": "ইমেইল",
          "settings_email_subtitle": "ইমেইল পরিবর্তন করতে আলতো চাপুন",
          "settings_user_name": "ইউজারনেম",
          "settings_user_name_subtitle": "কপি করতে দীর্ঘ প্রেস করুন",
          "settings_user_name_copy":
              "ক্লিপবোর্ডে ব্যবহারকারীর নাম কপি করা হয়েছে!",
          "settings_created_by": "অ্যাকাউন্ট দাতা",
          "settings_provide_by": "অ্যাকাউন্ট সরবরাহকারী ",
          "settings_created_at": "একাউন্ট তৈরী হয়েছে",
          "settings_last_logged_in": "সর্বশেষ লগ ইন",

          "settings_account_actions": "অ্যাকাউন্ট পদক্ষেপ",
          "settings_verification_title": "যাচাই!",
          "settings_already_verified":
              "আপনি ইতিমধ্যে আপনার অ্যাকাউন্ট যাচাই করেছেন!",
          "settings_account_verified": "অ্যাকাউন্ট যাচাই করা হয়েছে!",
          "settings_account_not_verified": "অ্যাকাউন্ট যাচাই করা হয়নি!",
          "settings_verification_message":
              "আপনার ইমেলটিতে একটি যাচাইকরণ লিঙ্ক পাঠানো হয়েছে। লিঙ্কটি ক্লিক করুন এবং এটি যাচাই করুন!\nলগআউট করুন এবং আবার লগইন করুন!",
          "settings_account_verified_subtitle":
              "আপনার অ্যাকাউন্ট যাচাই করতে আলতো চাপুন|",
          "settings_change_password": "পাসওয়ার্ড পরিবর্তন",
          "settings_share_account": "অ্যাকাউন্ট শেয়ার করুন",

          "settings_app_actions": "অ্যাপ পদক্ষেপ",
          "settings_on_onboarding": "অনবোর্ডিং চালু করুন",
          "settings_off_onboarding": "অনবোর্ডিং বন্ধ করুন",
          "settings_language": "ভাষা",
          "settings_select_language": "ভাষা নির্বাচন করুন",

          "settings_about_app": "অ্যাপ সম্পর্কে",
          "settings_about_vvc": "VVC সম্পর্কে",
          "settings_privacy": "গোপনীয়তা",
          "settings_terms": "শর্তাবলী",

          "settings_see_ya": "দেখা হবে",
          "settings_logout": "লগ আউট",
          "settings_logout_confirmation": "আপনি কি লগ আউট করতে চান?",

          "settings_name_change_title":
              "আপনার নাম পরিবর্তন করুন। এটি আপনার কার্ডের নাম নয়, অ্যাকাউন্টের নাম পরিবর্তন করবে!",
          "settings_name_change_new_name": "নতুন নাম",
          "settings_name_change_new_name_error":
              "নামটি কমপক্ষে 3 অক্ষর দীর্ঘ হতে হবে!",
          "settings_name_change": "নাম পরিবর্তন করুন",
          "settings_name_change_success":
              "নতুন নাম সফলভাবে পরিবর্তন করা হয়েছে!",

          "settings_profile_picture_change_success":
              "আপনার ছবিটি পরিবর্তন করা সফল হয়েছে!",

          "settings_email_change_title": "আপনার ইমেইল পরিবর্তন করুন।",
          "settings_email_change_current_password": "বর্তমান পাসওয়ার্ড",
          "settings_email_change_current_password_error":
              "পাসওয়ার্ড কমপক্ষে 6 টি অক্ষর দীর্ঘ!",
          "settings_email_change_new_email": "নতুন ইমেইল",
          "settings_email_change_new_email_error": "ভুল ইমেইল",
          "settings_email_change": "ইমেইল পরিবর্তন করুন",
          "settings_email_change_success": "ইমেইল পরিবর্তন সফল হয়েছে!",
          "settings_email_change_already_in_use":
              "ইমেইল ইতোমধ্যে ব্যবহৃত হচ্ছে. ভিন্ন ইমেল দিয়ে আবার চেষ্টা করুন!",
          "settings_email_change_wrong_password":
              "আপনার বর্তমান পাসওয়ার্ডটি আমাদের সিস্টেমে নেই!",
          "settings_email_change_cross_limit":
              "এই জাতীয় কাজগুলি করতে আবার আপনার সীমা অতিক্রম করবেন না! আমরা আপনাকে কিছু সময়ের জন্য অবরুদ্ধ করছি। পরে আবার চেষ্টা করুন।",

          "settings_username_change_title": "আপনার ইউজারনেম পরিবর্তন করুন।",
          "settings_username_change_current_password": "বর্তমান পাসওয়ার্ড",
          "settings_username_change_current_password_error":
              "পাসওয়ার্ড কমপক্ষে 6 টি অক্ষর দীর্ঘ!",
          "settings_username_change_new_username": "নতুন ইউজারনেম",
          "settings_username_change_new_username_error":
              "ইউজারনেম কমপক্ষে 5 অক্ষর দীর্ঘ হতে হবে!",
          "settings_username_change": "ইউজারনেম পরিবর্তন করুন",
          "settings_username_change_success": "ইউজারনেম পরিবর্তন সফল হয়েছে!",
          "settings_username_change_already_in_use":
              "ইউজারনেম পরিবর্তন করা যাচ্ছে না, এটি ইতিমধ্যে ব্যবহৃত হয়েছে!",
          "settings_username_change_wrong_password":
              "আপনার বর্তমান পাসওয়ার্ডটি আমাদের সিস্টেমে নেই!",
          "settings_username_change_cross_limit":
              "এই জাতীয় কাজগুলি করতে আবার আপনার সীমা অতিক্রম করবেন না! আমরা আপনাকে কিছু সময়ের জন্য অবরুদ্ধ করছি। পরে আবার চেষ্টা করুন।",

          "settings_password_change_title": "আপনার পাসওয়ার্ড পরিবর্তন করুন",
          "settings_password_change_current_password": "বর্তমান পাসওয়ার্ড",
          "settings_password_change_current_password_error":
              "পাসওয়ার্ড কমপক্ষে 6 টি অক্ষর দীর্ঘ!",
          "settings_password_change_new_password": "নতুন পাসওয়ার্ড",
          "settings_password_change_new_password_error":
              "পাসওয়ার্ড কমপক্ষে 6 টি অক্ষর দীর্ঘ!",
          "settings_password_change_confirm_password": "পুনরায় পাসওয়ার্ড দিন",
          "settings_password_change_confirm_password_error":
              "পাসওয়ার্ড কমপক্ষে 6 টি অক্ষর দীর্ঘ!",
          "settings_password_change_dont_match": "পাসওয়ার্ড মিলছে না",
          "settings_password_change": "পাসওয়ার্ড পরিবর্তন করুন",
          "settings_password_change_success":
              "পাসওয়ার্ড পরিবর্তন করা সফল হয়েছে!",
          "settings_password_change_wrong_password":
              "আপনার বর্তমান পাসওয়ার্ডটি আমাদের সিস্টেমে নেই!",
          "settings_password_change_cross_limit":
              "এই জাতীয় কাজগুলি করতে আবার আপনার সীমা অতিক্রম করবেন না! আমরা আপনাকে কিছু সময়ের জন্য অবরুদ্ধ করছি। পরে আবার চেষ্টা করুন।",
        },
      };
}
