import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TermsConditionsBody extends StatelessWidget {
  const TermsConditionsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(16.0.r),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              _buildSectionTitle('1. Acceptance of Terms'),
              _buildSectionContent(
                  'By accessing or using Language Learn, you confirm that you have read, understood, and agreed to these Terms and Conditions. If you do not agree, please refrain from using our application.'),

              _buildSectionTitle('2. User Accounts and Security'),
              _buildSectionContent(
                  'To access certain features of the app, you must create an account using a valid email and password. You are responsible for keeping your login credentials confidential.'),

              _buildSectionTitle('3. Use of the Application'),
              _buildSectionContent(
                  'Language Learn provides tools to help users learn new words through notifications and quizzes. The app is intended for personal, non-commercial use only.'),

              _buildSectionTitle('4. Privacy and Data Protection'),
              _buildSectionContent(
                  'We take user privacy seriously. Your personal information (e.g., email, encrypted password) is stored securely and is not shared with third parties except as required by law.'),

              _buildSectionTitle('5. Intellectual Property'),
              _buildSectionContent(
                  'All content, including but not limited to software, design, logos, and quizzes, belongs to Language Learn and is protected under copyright laws.'),

              _buildSectionTitle('6. Limitation of Liability'),
              _buildSectionContent(
                  'We strive to provide accurate and efficient language-learning tools, but we do not guarantee that the app will be error-free or uninterrupted.'),

              _buildSectionTitle('7. Changes to Terms'),
              _buildSectionContent(
                  'We reserve the right to update these Terms and Conditions at any time. Users will be notified of significant changes.'),

              _buildSectionTitle('8. Termination of Service'),
              _buildSectionContent(
                  'We reserve the right to suspend or terminate accounts that violate these terms, engage in fraudulent activity, or misuse the application.'),

              _buildSectionTitle('9. Governing Law'),
              _buildSectionContent(
                  'These Terms and Conditions shall be governed by and interpreted in accordance with the laws of Azerbaijan.'),

              _buildSectionTitle('10. Contact Information'),
              _buildSectionContent(
                  'If you have any questions about these Terms and Conditions, you can contact us at info@languagelearn.com.'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(top: 12.h),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildSectionContent(String content) {
    return Padding(
      padding: EdgeInsets.only(top: 4.h, bottom: 8.h),
      child: Text(
        content,
        style: TextStyle(fontSize: 14.sp),
      ),
    );
  }
}
