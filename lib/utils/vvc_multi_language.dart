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
        },
        "bn_BD": {
          //Error

          "error": "কোনো একটা সমস্যা হয়েছে!",
          "error_title": "ত্রুটি!",

          //Loading

          "loading": "লোড হচ্ছে...",

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
        },
      };
}
