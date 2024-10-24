import 'package:flutter_test/flutter_test.dart';
import 'package:fyp_pro/main.dart';


void main() {
  testWidgets('MyApp Test when logged in', (WidgetTester tester) async {
    // Create the widget by providing required parameters
    await tester.pumpWidget(MyApp(
      isLoggedIn: true,    // Simulate a logged-in state
      userRole: 'Public',  // Provide a role for testing, e.g., 'Public'
    ));

    // Add further test logic as needed
  });

  testWidgets('MyApp Test when not logged in', (WidgetTester tester) async {
    // Create the widget with not logged-in state
    await tester.pumpWidget(MyApp(
      isLoggedIn: false,   // Simulate a not-logged-in state
      userRole: null,      // No user role when not logged in
    ));

    // Add further test logic as needed
  });
}
